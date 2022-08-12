# Filename: 13-location-jm.R (2019-04-22)
#
# TO DO: Build figures for location chapter
#
# Author(s): Jannes Muenchow
#
#**********************************************************
# CONTENTS-------------------------------------------------
#**********************************************************
#
# 1. ATTACH PACKAGES AND DATA
# 2. OVERVIEW RASTER FIGURE
# 3. METRO RASTER FIGURE
# 4. POTENTIAL LOCATIONS
#
#**********************************************************
# 1 ATTACH PACKAGES AND DATA-------------------------------
#**********************************************************

# attach packages
library(raster)
library(sp)
library(sf)
library(lattice)
library(latticeExtra)
library(grid)
library(gridExtra)
library(classInt)
library(mapview)
library(tidyverse)
library(htmlwidgets)
library(leaflet)

# attach data
data("census_de", "metro_names", "shops", package = "spDataLarge")
# download German border polygon
ger = getData(country = "DEU", level = 0)

#**********************************************************
# 2 CENSUS STACK FIGURE------------------------------------
#**********************************************************

# 2.1 Data preparation=====================================
#**********************************************************
input = dplyr::select(census_de, x = x_mp_1km, y = y_mp_1km, pop = Einwohner,
                      women = Frauen_A, mean_age = Alter_D,
                      hh_size = HHGroesse_D)
# set -1 and -9 to NA
input_tidy = mutate_all(input, list(~ifelse(. %in% c(-1, -9), NA, .)))
input_ras = rasterFromXYZ(input_tidy, crs = st_crs(3035)$proj4string)

# convert the brick into a stack, ratify and factor variables apparently only
# work with a raster stack
input_ras = stack(input_ras)
# ratify rasters (factor variables)
for (i in names(input_ras)) {
  input_ras[[i]] = ratify(input_ras[[i]])
  values(input_ras[[i]]) = as.factor(values(input_ras[[i]]))
}

# reproject German outline
ger = spTransform(ger, proj4string(input_ras))

# 2.2 Create figure========================================
#**********************************************************

# find out about lattice settings
# trellis.par.get()
p_1 = spplot(input_ras, col.regions = RColorBrewer::brewer.pal(6, "GnBu"), 
             main = list("Classes", cex = 0.5),
             layout = c(4, 1), 
             # Leave some space between the panels
             between = list(x = 0.5),
             colorkey = list(space = "top", width = 0.8, height = 0.2,
                             # make tick size smaller
                             tck = 0.5,
                             labels = list(cex = 0.4)),
             strip = strip.custom(bg = "white",
                                  par.strip.text = list(cex = 0.5),
                                  factor.levels = c("population", "women",
                                                    "mean age", 
                                                    "household size")),
             sp.layout = list(
               list("sp.polygons", ger, col = gray(0.5),
                    first = FALSE)))
# save the output
ggplot2::ggsave(filename = "figures/08_census_stack.png",
                plot = arrangeGrob(p_1, ncol = 1),
                width = 5.1, height = 3)


#**********************************************************
# 3 METROPOLITAN AREA FIGURE-------------------------------
#**********************************************************

# create reclassifcation matrices
rcl_pop = matrix(c(1, 1, 127, 2, 2, 375, 3, 3, 1250, 
                   4, 4, 3000, 5, 5, 6000, 6, 6, 8000), 
                 ncol = 3, byrow = TRUE)
rcl_women = matrix(c(1, 1, 3, 2, 2, 2, 3, 3, 1, 4, 5, 0), 
                   ncol = 3, byrow = TRUE)
rcl_age = matrix(c(1, 1, 3, 2, 2, 0, 3, 5, 0),
                 ncol = 3, byrow = TRUE)
rcl_hh = rcl_women
rcl = list(rcl_pop, rcl_women, rcl_age, rcl_hh)
# reclassify
reclass = map2(as.list(input_ras), rcl, function(x, y) {
  reclassify(x = x, rcl = y, right = NA)
}) %>% 
  stack
names(reclass) = names(input_ras)
# aggregate by a factor of 20
pop_agg = aggregate(reclass$pop, fact = 20, fun = sum)
# just keep raster cells with more than 500,000 inhabitants
polys = pop_agg[pop_agg > 500000, drop = FALSE] 
# convert all cells belonging to one region ino polygons
polys = polys %>% 
  clump() %>%
  rasterToPolygons() %>%
  st_as_sf()
# dissolve
metros = polys %>%
  group_by(clumps) %>%
  summarize()

# palette
pal = RColorBrewer::brewer.pal(5, "GnBu")
# cuts = c(0, 249000, 499000, 749000, 999000, 1249000)
cuts = c(0, 250000, 500000, 750000, 1000000, 1250000)
coords = st_centroid(metros) %>%
  st_coordinates() %>%
  round(4)
# move all labels up except for Düsseldorf
metro_names = dplyr::pull(metro_names, city) %>% 
  as.character() %>% 
  ifelse(. == "Wülfrath", "Duesseldorf", .)
ind = metro_names %in% "Duesseldorf"
coords[!ind, 2] = coords[!ind, 2] + 30000

# 3.2 Create figure========================================
#**********************************************************
p_2 = 
  spplot(pop_agg, col.regions = pal, 
         main = list("Number of people in 1000", cex = 0.5),
         # if we want to get rid of the plot frame around the map
         # par.settings = list(axis.line = list(col = 'transparent')), 
         colorkey = list(space = "top", width = 0.5, height = 0.4,
                         # make tick length shorter
                         tck = 0.5,
                         labels = list(cex = 0.4, at = cuts,
                                       labels = cuts / 1000),
                         # draw a box and ticks around the legend
                         axis.line = list(col = "black")),
         # legend necessary if we do not use main as legend title
         # legend = list(top = list(fun = grid::textGrob("Size\n(m)", x = 1.05))),
         # at command necessary again as we have a continous variable!!!
         at = cuts,
         # overlay with further spatial objects
         sp.layout = list(
           list("sp.polygons", ger, col = gray(0.5), first = FALSE),
           list("sp.polygons", as(metros, "Spatial"), col = "gold",
                lwd = 2, first = FALSE)
           # list("sp.text", coords, txt = metro_names, cex = 0.7, font = 3,
           #      first = FALSE)
         ))

# use shadow text
# take care, latticeExtra::layer uses NSE, you need to use the data-argument!!!
# See ?layer and:
# browseURL(paste0("https://procomun.wordpress.com/2013/04/24/", 
#                  "stamen-maps-with-spplot/))
# browseURL(paste0("https://gist.github.com/oscarperpinan/",
#                  "7482848#file-stamenpolywithlayerinfunction4-r"))
# shadowtext by Barry Rowlingson
# browseURL(paste0("http://blog.revolutionanalytics.com/2009/05/",
#                  "make-text-stand-out-with-outlines.html"))
# needs some adjustment for lattice, strwidth and strheight replace by
# stringWidth and stringHeight (gridExtra), see
# browseURL("https://stat.ethz.ch/pipermail/r-help/2004-November/061255.html")
theta = seq(pi / 4, 2 * pi, length.out = 8)
xy = xy.coords(coords)
xo = 75 * convertWidth(stringWidth("A"), unitTo = "native", valueOnly = TRUE)
yo = 75 * convertWidth(stringHeight("A"), unitTo = "native", valueOnly = TRUE)
p_3 = p_2 + 
  latticeExtra::layer(
    for (i in theta) {
      ltext(x = xy$x + cos(i) * xo, y = xy$y + sin(i) * yo, 
            labels = metro_names, col = "white", font = 3, cex = 0.5)
    },
    data = list(xy = xy, metro_names = metro_names, theta = theta,
                xo = xo, yo = yo)
  ) +
  latticeExtra::layer(
    ltext(x = xy$x, y =  xy$y, labels = metro_names, col = "black", cex = 0.5, 
          font = 3),
    data = list(xy = xy, metro_names = metro_names)
  )
  
# save the output
ggplot2::ggsave(filename = "figures/08_metro_areas.png",
                plot = arrangeGrob(p_3, ncol = 1),
                width = 3, height = 4)

#**********************************************************
# 4 POTENTIAL LOCATIONS------------------------------------ 
#**********************************************************

# 4.1 Data preparation=====================================
#**********************************************************
shops = st_transform(shops, proj4string(reclass))
# create poi raster
poi = rasterize(x = shops, y = reclass, field = "osm_id", fun = "count")
int = classInt::classIntervals(values(poi), n = 4, style = "fisher")
int = round(int$brks)
rcl_poi = matrix(c(int[1], rep(int[-c(1, length(int))], each = 2), 
                   int[length(int)] + 1), ncol = 2, byrow = TRUE)
rcl_poi = cbind(rcl_poi, 0:3)  
# reclassify
poi = reclassify(poi, rcl = rcl_poi, right = NA) 
names(poi) = "poi"

# dismiss population raster
reclass = dropLayer(reclass, "pop")
# add poi raster
reclass = addLayer(reclass, poi)
# calculate the total score
result = sum(reclass)
# have a look at suitable bike shop locations in Berlin
berlin = metros[metro_names == "Berlin", ]
berlin_raster = raster::crop(result, berlin) 

# 4.2 Figure===============================================
#**********************************************************
m = mapview(berlin_raster, col.regions = c(NA, "darkgreen"),
            na.color = "transparent", legend = TRUE, map.type = "OpenStreetMap")
mapshot(m, url = file.path(getwd(), "figures/08_bikeshops_berlin.html"))

# using leaflet (instead of mapview)
berlin_raster = berlin_raster > 9
berlin_raster = berlin_raster == TRUE
berlin_raster[berlin_raster == 0] = NA

leaflet() %>% 
  addTiles() %>%
  addRasterImage(berlin_raster, colors = "darkgreen", opacity = 0.8) %>%
  addLegend("bottomright", colors = c("darkgreen"), 
            labels = c("potential locations"), title = "Legend")
