# Filename: 14-location_figures.R (2022-11-30)
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
library(terra)
library(sp)
library(sf)
library(geodata)
library(tmap)
library(classInt)
library(mapview)
library(tidyverse)
library(htmlwidgets)
library(leaflet)
# we still need the raster package but will reference it when needed with
# raster::
# library(raster)

# attach data
data("census_de", "metro_names", "shops", package = "spDataLarge")
# download German border polygon
ger = geodata::gadm(country = "DEU", level = 0, path = tempdir())
# ger = raster::getData(country = "DEU", level = 0)

#**********************************************************
# 2 CENSUS STACK FIGURE------------------------------------
#**********************************************************

# 2.1 Data preparation=====================================
#**********************************************************
input = select(census_de, x = x_mp_1km, y = y_mp_1km, pop = Einwohner,
                      women = Frauen_A, mean_age = Alter_D,
                      hh_size = HHGroesse_D)
# set -1 and -9 to NA
input_tidy = dplyr::mutate(
  input, 
  dplyr::across(.fns =  ~ifelse(.x %in% c(-1, -9), NA, .x)))
input_ras = terra::rast(input_tidy, type = "xyz", crs = "EPSG:3035")

# reproject German outline
ger = st_as_sf(terra::project(ger, crs(input_ras)))

# 2.2 Create figure========================================
#**********************************************************
tm_1 = tm_shape(input_ras) +
  tm_raster(style = "cat", palette = "GnBu", title = "Class") +
  tm_facets(nrow = 1) +
  tm_shape(ger) +
  tm_borders() +
  tm_layout(panel.labels = c("population", "women", "mean age", "household size"),
            legend.outside.size = 0.08)

tmap_save(tm_1, "figures/14_census_stack.png", width = 5.1, height = 2)

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
  terra::classify(x = x, rcl = y, right = NA)
}) |>
  rast()
# aggregate by a factor of 20
pop_agg = terra::aggregate(reclass$pop, fact = 20, fun = sum, na.rm = TRUE)
# just keep raster cells with more than 500,000 inhabitants
polys = pop_agg[pop_agg > 500000, drop = FALSE] 
# convert all cells belonging to one region ino polygons
metros = polys |>
  terra::patches(directions = 8) |>
  terra::as.polygons() |>
  st_as_sf()
metros$names = c("Hamburg", "Berlin", "Düsseldorf", "Leipzig",
                 "Frankfurt am Main", "Nürnberg", "Stuttgart", "München")

metros_points = st_centroid(metros)

tm_2 = tm_shape(pop_agg/1000) +
  tm_raster(palette = "GnBu",
            title = "Number of people\n(in 1,000)") +
  tm_shape(ger) +
  tm_borders() +
  tm_shape(metros) +
  tm_borders(col = "gold", lwd = 2) +
  tm_shape(metros_points) +
  tm_text(text = "names", ymod = 0.6, shadow = TRUE, size = 0.75,
          fontface = "italic") +
  tm_layout(legend.outside = TRUE, legend.outside.size = 0.3)

tmap_save(tm_2, "figures/14_metro_areas.png", width = 4, height = 4)

#**********************************************************
# 4 POTENTIAL LOCATIONS------------------------------------ 
#**********************************************************

# 4.1 Data preparation=====================================
#**********************************************************
shops = st_transform(shops, st_crs(reclass))
# create poi raster
poi = terra::rasterize(x = terra::vect(shops),
                       y = reclass, field = "osm_id", fun = "length")
int = classInt::classIntervals(values(poi), n = 4, style = "fisher")
int = round(int$brks)
rcl_poi = matrix(c(int[1], rep(int[-c(1, length(int))], each = 2), 
                   int[length(int)] + 1), ncol = 2, byrow = TRUE)
rcl_poi = cbind(rcl_poi, 0:3)  
# reclassify
poi = terra::classify(poi, rcl = rcl_poi, right = NA) 
names(poi) = "poi"

# dismiss population raster
reclass = reclass[[names(reclass) != "pop"]] |>
  c(poi)
# calculate the total score
result = sum(reclass)
# have a look at suitable bike shop locations in Berlin
berlin = metros[metro_names == "Berlin", ]
berlin_raster = terra::crop(result, berlin) 

# 4.2 Figure===============================================
#**********************************************************
m = mapview(raster::raster(berlin_raster), col.regions = c(NA, "darkgreen"),
            na.color = "transparent", legend = TRUE, map.type = "OpenStreetMap")
mapshot(m, url = file.path(getwd(), "figures/08_bikeshops_berlin.html"))

# using leaflet (instead of mapview)
berlin_raster = berlin_raster > 9
berlin_raster[berlin_raster == 0] = NA

leaflet() |>
  addTiles() |>
  addRasterImage(raster::raster(berlin_raster), colors = "darkgreen", opacity = 0.8) |>
  addLegend("bottomright", colors = c("darkgreen"), 
            labels = c("potential locations"), title = "Legend")
