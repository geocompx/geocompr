## ---- message = FALSE----------------------------------------------------
library(sf)
library(raster)
library(tidyverse)
library(osmdata)

## ---- eval = FALSE-------------------------------------------------------
## download.file("https://tinyurl.com/ybtpkwxz",
##               destfile = "census.zip", mode = "wb")
## unzip("census.zip") # unzip the files
## census_de = readr::read_csv2(list.files(pattern = "Gitter.csv"))

## ---- echo = FALSE-------------------------------------------------------
# spDataLarge contains census_de, metro_names, and shops
library(spDataLarge)
data("census_de")

## ----census-desc, echo = FALSE-------------------------------------------
tab = tribble(
  ~"class", ~"pop", ~"women", ~"age", ~"hh",
  1, "3-250", "0-40", "0-40", "1-2", 
  2, "250-500", "40-47", "40-42", "2-2.5",
  3, "500-2000", "47-53", "42-44", "2.5-3",
  4, "2000-4000", "53-60", "44-47", "3-3.5",
  5, "4000-8000", ">60", ">47", ">3.5",
  6, ">8000", "", "", ""
)
cap = paste("Excerpt from the data description",
             "'Datensatzbeschreibung_klassierte_Werte_1km-Gitter.xlsx'", 
             "located in the downloaded file census.zip describing the classes", 
             "of the retained variables. The classes -1 and -9 refer to", 
             "uninhabited areas or areas which have to be kept secret,", 
             "for example due to the need to preserve anonymity.")
knitr::kable(tab,
             col.names = c("class", "population\\\n(number of people)",
                           "women\\\n(%)", "mean age\\\n(years)",
                           "household size\\\n(number of people)"),
             caption = cap, align = "c", format = "html")

## ------------------------------------------------------------------------
# pop = population, hh_size = household size
input = dplyr::select(census_de, x = x_mp_1km, y = y_mp_1km, pop = Einwohner,
                      women = Frauen_A, mean_age = Alter_D,
                      hh_size = HHGroesse_D)
# set -1 and -9 to NA
input_tidy = mutate_all(input, funs(ifelse(. %in% c(-1, -9), NA, .)))

## ------------------------------------------------------------------------
input_ras = rasterFromXYZ(input_tidy, crs = st_crs(3035)$proj4string)
# print the output to the console
input_ras

## Note that we are using an equal-area projection (EPSG:3035; Lambert Equal Area Europe), i.e. a projected CRS where each grid cell has the same area, here 1000 x 1000 square meters.

## ----census-stack, echo = FALSE, fig.cap = "Gridded German census data of 2011. See Table \\@ref(tab:census-desc) for a description of the classes."----
knitr::include_graphics("figures/08_census_stack.png")

## ------------------------------------------------------------------------
rcl_pop = matrix(c(1, 1, 127, 2, 2, 375, 3, 3, 1250, 
                   4, 4, 3000, 5, 5, 6000, 6, 6, 8000), 
                 ncol = 3, byrow = TRUE)
rcl_women = matrix(c(1, 1, 3, 2, 2, 2, 3, 3, 1, 4, 5, 0), 
                   ncol = 3, byrow = TRUE)
rcl_age = matrix(c(1, 1, 3, 2, 2, 0, 3, 5, 0),
                 ncol = 3, byrow = TRUE)
rcl_hh = rcl_women
rcl = list(rcl_pop, rcl_women, rcl_age, rcl_hh)

## ------------------------------------------------------------------------
reclass = map2(as.list(input_ras), rcl, function(x, y) {
  reclassify(x = x, rcl = y, right = NA)
}) %>% 
  stack
names(reclass) = names(input_ras)
reclass

## ---- eval = FALSE, echo = FALSE-----------------------------------------
## tmp = mapply(FUN = function(x, y) {
##   reclassify(x = x, rcl = y, right = NA)
## }, x = as.list(input_ras), y = rcl)
## 
## 
## for (i in seq_len(nlayers(reclass))) {
##   reclass[[i]] = reclassify(reclass[[i]], rcl = rcl[[i]], right = NA)
## }
## names(reclass) = names(input_ras)

## ------------------------------------------------------------------------
pop_agg = aggregate(reclass$pop, fact = 20, fun = sum)

## ------------------------------------------------------------------------
polys = rasterToPolygons(pop_agg[pop_agg > 500000, drop = FALSE]) %>% 
  st_as_sf(polys)

## ------------------------------------------------------------------------
polys = st_union(polys)

## ------------------------------------------------------------------------
metros = st_cast(polys, "POLYGON")

## ------------------------------------------------------------------------
# find out about the offending polygon
int = st_intersects(metros, metros)
# polygons 5 and 9 share one border, delete polygon number 5
metros_2 = metros[-5]

## ---- eval = FALSE-------------------------------------------------------
## # dissolve on spatial neighborhood
## nbs = st_intersects(polys, polys)
## # nbs = over(polys, polys, returnList = TRUE)
## 
## fun = function(x, y) {
##   tmp = lapply(y, function(i) {
##   if (any(x %in% i)) {
##    union(x, i)
##   } else {
##    x
##     }
##   })
##   Reduce(union, tmp)
## }
## # call function recursively
## fun_2 = function(x, y) {
##   out = fun(x, y)
##   while (length(out) < length(fun(out, y))) {
##     out = fun(out, y)
##   }
##   out
## }
## 
## cluster = map(nbs, ~ fun_2(., nbs) %>% sort)
## # just keep unique clusters
## cluster = cluster[!duplicated(cluster)]
## # assign the cluster classes to each pixel
## for (i in seq_along(cluster)) {
##   polys[cluster[[i]], "region_id"] = i
## }
## # dissolve pixels based on the the region id
## polys = group_by(polys, region_id) %>%
##   summarize(pop = sum(layer, na.rm = TRUE))
## # polys_2 = aggregate(polys, list(polys$region_id), sum)
## plot(polys[, "region_id"])
## 
## # Another approach, can be also be part of an excercise
## 
## coords = st_coordinates(polys_3) %>%
##   as.data.frame
## ls = split(coords, f = coords$L2)
## ls = lapply(ls, function(x) {
##   dplyr::select(x, X, Y) %>%
##     as.matrix %>%
##     list %>%
##     st_polygon
## })
## metros = do.call(st_sfc, ls)
## metros = st_set_crs(metros, 3035)
## metros = st_sf(data.frame(region_id = 1:9), geometry = metros)
## st_intersects(metros, metros)
## plot(metros[-5,])
## st_centroid(metros) %>%
##   st_coordinates

## ----metro-areas, echo = FALSE, fig.width = 1, fig.height = 1, fig.cap = "The aggregated population raster (resolution: 20 km) with the identified metropolitan areas (golden polygons) and the corresponding names."----
knitr::include_graphics("figures/08_metro_areas.png")

## ------------------------------------------------------------------------
metros_wgs = st_transform(metros, 4326)
coords = st_centroid(metros_wgs) %>%
  st_coordinates() %>%
  round(., 4)

## ---- eval = FALSE, warning = FALSE, message = FALSE---------------------
## # reverse geocoding to find out the names of the metropolitan areas
## metro_names = map_dfr(1:nrow(coords), function(i) {
##   add = ggmap::revgeocode(coords[i, ], output = "more")
##   x = 2
##   while (is.na(add$address) & x > 0) {
##     add = ggmap::revgeocode(coords[i, ], output = "more")
##     # just try three times
##     x = x - 1
##   }
##   # give the server a bit time
##   Sys.sleep(sample(seq(1, 4, 0.1), 1))
##   # return the result
##   add
## })

## ---- echo = FALSE-------------------------------------------------------
# attach metro_names from spDataLarge
data("metro_names")

## ------------------------------------------------------------------------
metro_names = 
  dplyr::select(metro_names, locality, administrative_area_level_2) %>%
  # replace Velbert and umlaut ü
  mutate(locality = ifelse(locality == "Velbert", administrative_area_level_2, 
                           locality),
         locality = gsub("ü", "ue", locality)) %>%
  pull(locality)

## ---- eval = FALSE, message = FALSE--------------------------------------
## shops = map(metro_names, function(x) {
##   message("Downloading shops of: ", x, "\n")
##   # give the server a bit time
##   Sys.sleep(sample(seq(5, 10, 0.1), 1))
##   query = opq(x) %>%
##     add_osm_feature(key = "shop")
##   points = osmdata_sf(query)
##   # request the same data again if nothing has been downloaded
##   iter = 2
##   while (nrow(points$osm_points) == 0 & iter > 0) {
##     points = osmdata_sf(query)
##     iter = iter - 1
##   }
##   points = st_set_crs(points$osm_points, 4326)
## })

## ---- eval = FALSE-------------------------------------------------------
## # checking if we have downloaded shops for each metropolitan area
## ind = map(shops, nrow) == 0
## if (any(ind)) {
##   message("There are/is still (a) metropolitan area/s without any features:\n",
##           paste(metro_names[ind], collapse = ", "), "\nPlease fix it!")
## }

## ---- eval = FALSE-------------------------------------------------------
## # select only specific columns and rbind all list elements
## shops = map(shops, dplyr::select, osm_id, shop) %>%
##   reduce(rbind)

## ---- echo = FALSE-------------------------------------------------------
# attach shops from spDataLarge
data("shops")

## If the `shop` column were used instead of the `osm_id` column, we would have retrieved fewer shops per grid cell.

## ---- message = FALSE----------------------------------------------------
shops = st_transform(shops, proj4string(reclass))
# create poi raster
poi = rasterize(x = shops, y = reclass, field = "osm_id", fun = "count")

## ---- message = FALSE, warning = FALSE-----------------------------------
# construct reclassification matrix
int = classInt::classIntervals(values(poi), n = 4, style = "fisher")
int = round(int$brks)
rcl_poi = matrix(c(int[1], rep(int[-c(1, length(int))], each = 2), 
                   int[length(int)] + 1), ncol = 2, byrow = TRUE)
rcl_poi = cbind(rcl_poi, 0:3)  
# reclassify
poi = reclassify(poi, rcl = rcl_poi, right = NA) 
names(poi) = "poi"

## ------------------------------------------------------------------------
# add poi raster
reclass = addLayer(reclass, poi)
# delete population raster
reclass = dropLayer(reclass, "pop")

## ------------------------------------------------------------------------
# calculate the total score
result = sum(reclass)

## ----bikeshop-berlin, echo = FALSE, eval = TRUE, fig.cap = "Suitable areas (i.e. raster cells with a score > 9) in accordance with our hypothetical survey for bike stores in Berlin."----
library(leaflet)
library(sp)
# have a look at suitable bike shop locations in Berlin
berlin = metros_2[metro_names == "Berlin"]
berlin_raster = raster::crop(result, as(berlin, "Spatial"))
# summary(berlin_raster)
# berlin_raster
berlin_raster = berlin_raster > 9

berlin_raster = berlin_raster == TRUE
berlin_raster[berlin_raster == 0] = NA

leaflet() %>% 
  addTiles() %>%
  addRasterImage(berlin_raster, colors = "darkgreen", opacity = 0.8) %>%
  addLegend("bottomright", colors = c("darkgreen"), 
            labels = c("potential locations"), title = "Legend")

