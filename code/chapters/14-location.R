## ----13-location-1, message=FALSE-------------------------------------------------------------------------------------------------------------------------
library(sf)
library(dplyr)
library(purrr)
library(raster)
library(osmdata)
library(spDataLarge)


## ----13-location-2, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## download.file("https://tinyurl.com/ybtpkwxz",
##               destfile = "census.zip", mode = "wb")
## unzip("census.zip") # unzip the files
## census_de = readr::read_csv2(list.files(pattern = "Gitter.csv"))


## ----13-location-4----------------------------------------------------------------------------------------------------------------------------------------
# pop = population, hh_size = household size
input = dplyr::select(census_de, x = x_mp_1km, y = y_mp_1km, pop = Einwohner,
                      women = Frauen_A, mean_age = Alter_D,
                      hh_size = HHGroesse_D)
# set -1 and -9 to NA
input_tidy = mutate_all(input, list(~ifelse(. %in% c(-1, -9), NA, .)))


## ----census-desc, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
tab = tribble(
  ~"class", ~"pop", ~"women", ~"age", ~"hh",
  1, "3-250", "0-40", "0-40", "1-2", 
  2, "250-500", "40-47", "40-42", "2-2.5",
  3, "500-2000", "47-53", "42-44", "2.5-3",
  4, "2000-4000", "53-60", "44-47", "3-3.5",
  5, "4000-8000", ">60", ">47", ">3.5",
  6, ">8000", "", "", ""
)
# commented code to show the input data frame with factors (RL):
# summary(input_tidy) # all integers
# fct_pop = factor(input_tidy$pop, labels = tab$pop)
# summary(fct_pop)
# sum(is.na(input_tidy$pop))
# fct_women = factor(input_tidy$women, labels = tab$women[1:5])
# summary(fct_women)
# sum(is.na(input_tidy$women))
# fct_mean_age = factor(input_tidy$mean_age, labels = tab$age[1:5])
# summary(fct_mean_age)
# sum(is.na(input_tidy$mean_age))
# fct_hh_size = factor(input_tidy$hh_size, labels = tab$hh[1:5])
# summary(fct_hh_size)
# sum(is.na(input_tidy$hh_size))
# input_factor = bind_cols(
#   select(input_tidy, 1:2),
#   pop = fct_pop,
#   women = fct_women,
#   mean_age = fct_mean_age,
#   hh_size = fct_hh_size,
# )
# summary(input_factor)
cap = paste("Categories for each variable in census data from",
            "Datensatzbeschreibung...xlsx", 
            "located in the downloaded file census.zip (see Figure",
            "13.1 for their spatial distribution).")
knitr::kable(tab,
             col.names = c("class", "Population", "% female", "Mean age",
                           "Household size"),
             caption = cap, 
             caption.short = "Categories for each variable in census data.",
             align = "c", booktabs = TRUE)


## ----13-location-5----------------------------------------------------------------------------------------------------------------------------------------
input_ras = rasterFromXYZ(input_tidy, crs = st_crs(3035)$proj4string)


## ----13-location-6, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## input_ras
## #> class : RasterBrick
## #> dimensions : 868, 642, 557256, 4 (nrow, ncol, ncell, nlayers)
## #> resolution : 1000, 1000 (x, y)
## #> extent : 4031000, 4673000, 2684000, 3552000 (xmin, xmax, ymin, ymax)
## #> coord. ref. : +proj=laea +lat_0=52 +lon_0=10
## #> names       :  pop, women, mean_age, hh_size
## #> min values  :    1,     1,        1,       1
## #> max values  :    6,     5,        5,       5


## Note that we are using an equal-area projection (EPSG:3035; Lambert Equal Area Europe), i.e., a projected CRS\index{CRS!projected} where each grid cell has the same area, here 1000 x 1000 square meters.

## Since we are using mainly densities such as the number of inhabitants or the portion of women per grid cell, it is of utmost importance that the area of each grid cell is the same to avoid 'comparing apples and oranges'.

## Be careful with geographic CRS\index{CRS!geographic} where grid cell areas constantly decrease in poleward directions (see also Section \@ref(crs-intro) and Chapter \@ref(reproj-geo-data)).


## ----census-stack, echo=FALSE, fig.cap="Gridded German census data of 2011 (see Table 13.1 for a description of the classes).", fig.scap="Gridded German census data."----
knitr::include_graphics("figures/08_census_stack.png")


## ----13-location-8----------------------------------------------------------------------------------------------------------------------------------------
rcl_pop = matrix(c(1, 1, 127, 2, 2, 375, 3, 3, 1250, 
                   4, 4, 3000, 5, 5, 6000, 6, 6, 8000), 
                 ncol = 3, byrow = TRUE)
rcl_women = matrix(c(1, 1, 3, 2, 2, 2, 3, 3, 1, 4, 5, 0), 
                   ncol = 3, byrow = TRUE)
rcl_age = matrix(c(1, 1, 3, 2, 2, 0, 3, 5, 0),
                 ncol = 3, byrow = TRUE)
rcl_hh = rcl_women
rcl = list(rcl_pop, rcl_women, rcl_age, rcl_hh)


## ----13-location-9----------------------------------------------------------------------------------------------------------------------------------------
reclass = input_ras
for (i in seq_len(nlayers(reclass))) {
  reclass[[i]] = reclassify(x = reclass[[i]], rcl = rcl[[i]], right = NA)
}
names(reclass) = names(input_ras)


## ----13-location-10, eval=FALSE---------------------------------------------------------------------------------------------------------------------------
## reclass
## #> ... (full output not shown)
## #> names       :  pop, women, mean_age, hh_size
## #> min values  :  127,     0,        0,       0
## #> max values  : 8000,     3,        3,       3


## ----13-location-11, warning=FALSE------------------------------------------------------------------------------------------------------------------------
pop_agg = aggregate(reclass$pop, fact = 20, fun = sum)


## ----13-location-12, warning=FALSE------------------------------------------------------------------------------------------------------------------------
summary(pop_agg)
pop_agg = pop_agg[pop_agg > 500000, drop = FALSE] 


## ----13-location-13, warning=FALSE, message=FALSE---------------------------------------------------------------------------------------------------------
polys = pop_agg %>% 
  clump() %>%
  rasterToPolygons() %>%
  st_as_sf()


## ----13-location-14---------------------------------------------------------------------------------------------------------------------------------------
metros = polys %>%
  group_by(clumps) %>%
  summarize()


## ----metro-areas, echo=FALSE, fig.width=1, fig.height=1, fig.cap="The aggregated population raster (resolution: 20 km) with the identified metropolitan areas (golden polygons) and the corresponding names.", fig.scap="The aggregated population raster."----
knitr::include_graphics("figures/08_metro_areas.png")


## ----13-location-16, warning=FALSE------------------------------------------------------------------------------------------------------------------------
metros_wgs = st_transform(metros, 4326)
coords = st_centroid(metros_wgs) %>%
  st_coordinates() %>%
  round(4)


## ----13-location-17, eval=FALSE---------------------------------------------------------------------------------------------------------------------------
## library(revgeo)
## metro_names = revgeo(longitude = coords[, 1], latitude = coords[, 2],
##                      output = "frame")


## ----metro-names, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
knitr::kable(dplyr::select(metro_names, city, state), 
             caption = "Result of the reverse geocoding.", 
             caption.short = "Result of the reverse geocoding.", 
             booktabs = TRUE)


## ----13-location-19---------------------------------------------------------------------------------------------------------------------------------------
metro_names = dplyr::pull(metro_names, city) %>% 
  as.character() %>% 
  ifelse(. == "Wülfrath", "Duesseldorf", .)


## ----13-location-20, eval=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------
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


## ----13-location-21, eval=FALSE---------------------------------------------------------------------------------------------------------------------------
## # checking if we have downloaded shops for each metropolitan area
## ind = map(shops, nrow) == 0
## if (any(ind)) {
##   message("There are/is still (a) metropolitan area/s without any features:\n",
##           paste(metro_names[ind], collapse = ", "), "\nPlease fix it!")
## }


## ----13-location-22, eval=FALSE---------------------------------------------------------------------------------------------------------------------------
## # select only specific columns
## shops = map(shops, dplyr::select, osm_id, shop)
## # putting all list elements into a single data frame
## shops = do.call(rbind, shops)


## If the `shop` column were used instead of the `osm_id` column, we would have retrieved fewer shops per grid cell.

## This is because the `shop` column contains `NA` values, which the `count()` function omits when rasterizing vector objects.


## ----13-location-25, message=FALSE------------------------------------------------------------------------------------------------------------------------
shops = st_transform(shops, proj4string(reclass))
# create poi raster
poi = rasterize(x = shops, y = reclass, field = "osm_id", fun = "count")


## ----13-location-26, message=FALSE, warning=FALSE---------------------------------------------------------------------------------------------------------
# construct reclassification matrix
int = classInt::classIntervals(values(poi), n = 4, style = "fisher")
int = round(int$brks)
rcl_poi = matrix(c(int[1], rep(int[-c(1, length(int))], each = 2), 
                   int[length(int)] + 1), ncol = 2, byrow = TRUE)
rcl_poi = cbind(rcl_poi, 0:3)  
# reclassify
poi = reclassify(poi, rcl = rcl_poi, right = NA) 
names(poi) = "poi"


## ----13-location-27---------------------------------------------------------------------------------------------------------------------------------------
# add poi raster
reclass = addLayer(reclass, poi)
# delete population raster
reclass = dropLayer(reclass, "pop")


## ----13-location-28---------------------------------------------------------------------------------------------------------------------------------------
# calculate the total score
result = sum(reclass)


## ----bikeshop-berlin, echo=FALSE, eval=TRUE, fig.cap="Suitable areas (i.e., raster cells with a score > 9) in accordance with our hypothetical survey for bike stores in Berlin.", fig.scap="Suitable areas for bike stores."----
if (knitr::is_latex_output()){
    knitr::include_graphics("figures/bikeshop-berlin-1.png")
} else if (knitr::is_html_output()){
    library(leaflet)
    library(sp)
    # have a look at suitable bike shop locations in Berlin
    berlin = metros[metro_names == "Berlin", ]
    berlin_raster = raster::crop(result, berlin) 
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
}

