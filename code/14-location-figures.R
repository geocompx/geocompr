# Filename: 14-location_figures.R (2022-11-30, last update: 2023-08-09)
#
# TO DO: Build figures for location chapter
#
# Author(s): Jannes Muenchow, Jakub Nowosad
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
library(sf)
library(geodata)
library(tmap)
library(classInt)
library(mapview)
library(dplyr)
library(purrr)
library(htmlwidgets)
library(leaflet)
library(z22)

# attach data
data("metro_names", "shops", package = "spDataLarge")
# download German border polygon
ger = geodata::gadm(country = "DEU", level = 0, path = tempdir())

#**********************************************************
# 2 CENSUS STACK FIGURE------------------------------------
#**********************************************************

# 2.1 Data preparation=====================================
#**********************************************************
# Load Census 2022 data using z22 package
pop = z22_data("population", res = "1km", year = 2022, as = "df") |>
  rename(pop = cat_0)
# Women data only available from Census 2011
women = z22_data("women", year = 2011, res = "1km", as = "df") |>
  rename(women = cat_0)
mean_age = z22_data("age_avg", res = "1km", year = 2022, as = "df") |>
  rename(mean_age = cat_0)
hh_size = z22_data("household_size_avg", res = "1km", year = 2022, as = "df") |>
  rename(hh_size = cat_0)

# Join all data frames
input_tidy = pop |>
  left_join(women, by = c("x", "y")) |>
  left_join(mean_age, by = c("x", "y")) |>
  left_join(hh_size, by = c("x", "y")) |>
  relocate(pop, .after = y) |>
  mutate(across(c(pop, women, mean_age, hh_size), ~ifelse(.x < 0, NA, .x)))
input_ras = terra::rast(input_tidy, type = "xyz", crs = "EPSG:3035")

# reproject German outline
ger = st_as_sf(terra::project(ger, crs(input_ras)))

# 2.2 Create figure========================================
#**********************************************************
# Reclassification matrices for the figure
rcl_pop = matrix(c(0, 250, 1, 250, 500, 2, 500, 2000, 3, 2000, 4000, 4, 4000, 8000, 5, 8000, Inf, 6), ncol = 3, byrow = TRUE)
rcl_women = matrix(c(0, 40, 1, 40, 47, 2, 47, 53, 3, 53, 60, 4, 60, 100, 5), ncol = 3, byrow = TRUE)
rcl_age = matrix(c(0, 40, 1, 40, 42, 2, 42, 44, 3, 44, 47, 4, 47, 120, 5), ncol = 3, byrow = TRUE)
rcl_hh = matrix(c(0, 1.5, 1, 1.5, 2.0, 2, 2.0, 2.5, 3, 2.5, 3.0, 4, 3.0, 100, 5), ncol = 3, byrow = TRUE)

# Reclassify variables
pop_class = terra::classify(input_ras$pop, rcl = rcl_pop, right = NA)
women_class = terra::classify(input_ras$women, rcl = rcl_women, right = NA)
age_class = terra::classify(input_ras$mean_age, rcl = rcl_age, right = NA)
hh_class = terra::classify(input_ras$hh_size, rcl = rcl_hh, right = NA)

# Set categories for proper legend display
cls = data.frame(id = 1:6, class = as.character(1:6))
set.cats(pop_class, layer = 1, value = cls)
set.cats(women_class, layer = 1, value = cls[1:5,])
set.cats(age_class, layer = 1, value = cls[1:5,])
set.cats(hh_class, layer = 1, value = cls[1:5,])

reclass_fig = c(pop_class, women_class, age_class, hh_class)
names(reclass_fig) = c("pop", "women", "mean_age", "hh_size")

tm_1 = tm_shape(reclass_fig) +
  tm_raster(col.scale = tm_scale_categorical(values = "brewer.gn_bu"),
            col.legend = tm_legend(title = "Class", position = tm_pos_out("right", "center")),
            col.free = FALSE) +
  tm_facets(nrow = 1) +
  tm_shape(ger) +
  tm_borders() +
  tm_layout(panel.labels = c("population", "women", "mean age", "household size"),
            panel.label.size = 0.8)

tmap_save(tm_1, "images/14_census_stack.png", width = 7, height = 2.2)

#**********************************************************
# 3 METROPOLITAN AREA FIGURE-------------------------------
#**********************************************************

# Reclassification matrices for continuous values (from, to, weight)
rcl_women = matrix(c(
  0, 40, 3,    # 0-40% female -> weight 3
  40, 47, 2,   # 40-47% -> weight 2
  47, 53, 1,   # 47-53% -> weight 1
  53, 60, 0,   # 53-60% -> weight 0
  60, 100, 0   # >60% -> weight 0
), ncol = 3, byrow = TRUE)

rcl_age = matrix(c(
  0, 40, 3,    # Mean age <40 -> weight 3
  40, 42, 2,   # 40-42 -> weight 2
  42, 44, 1,   # 42-44 -> weight 1
  44, 47, 0,   # 44-47 -> weight 0
  47, 120, 0   # >47 -> weight 0
), ncol = 3, byrow = TRUE)

rcl_hh = matrix(c(
  0, 1.5, 3,     # 1-1.5 persons -> weight 3
  1.5, 2.0, 2,   # 1.5-2 -> weight 2
  2.0, 2.5, 1,   # 2-2.5 -> weight 1
  2.5, 3.0, 0,   # 2.5-3 -> weight 0
  3.0, 100, 0    # >3 -> weight 0
), ncol = 3, byrow = TRUE)

rcl = list(rcl_women, rcl_age, rcl_hh)

# Separate population (used as counts for metro detection) from variables to reclassify
pop_ras = input_ras$pop
demo_vars = c("women", "mean_age", "hh_size")
reclass = map2(as.list(input_ras[[demo_vars]]), rcl, function(x, y) {
  terra::classify(x = x, rcl = y, right = NA)
}) |>
  rast()
names(reclass) = demo_vars

# aggregate by a factor of 20 using actual population counts
pop_agg = terra::aggregate(pop_ras, fact = 20, fun = sum, na.rm = TRUE)
# just keep raster cells with more than 500,000 inhabitants
polys = pop_agg[pop_agg > 500000, drop = FALSE] 
# convert all cells belonging to one region into polygons
metros = polys |>
  terra::patches(directions = 8) |>
  terra::as.polygons() |>
  st_as_sf()

# Hardcoded metro names based on centroid coordinates (avoids API dependency)
# Census 2022 detects 10 metro areas (vs 8 in Census 2011)
metro_names_vec = c("Hamburg", "Berlin", "Hannover", "Düsseldorf",
                    "Leipzig", "Dresden", "Frankfurt", "Nürnberg",
                    "Stuttgart", "München")
metros$names = metro_names_vec
metros_points = st_centroid(metros)

tm_2 = tm_shape(pop_agg/1000) +
  tm_raster(col.scale = tm_scale_intervals(values = "brewer.gn_bu",
                                            style = "fixed",
                                            breaks = c(0, 200, 400, 600, 800, 1000, 1200, 1400)),
            col.legend = tm_legend(title = "Number of people\n(in 1,000)",
                                   position = tm_pos_out("right", "center"))) +
  tm_shape(ger) +
  tm_borders() +
  tm_shape(metros) +
  tm_borders(col = "gold", lwd = 2) +
  tm_shape(metros_points) +
  tm_text("names", size = 0.55, fontface = "italic", col = "white", xmod = 0.08, ymod = 0) +
  tm_shape(metros_points) +
  tm_text("names", size = 0.55, fontface = "italic", col = "white", xmod = -0.08, ymod = 0) +
  tm_shape(metros_points) +
  tm_text("names", size = 0.55, fontface = "italic", col = "white", xmod = 0, ymod = 0.08) +
  tm_shape(metros_points) +
  tm_text("names", size = 0.55, fontface = "italic", col = "white", xmod = 0, ymod = -0.08) +
  tm_shape(metros_points) +
  tm_text("names", size = 0.55, fontface = "italic")

tmap_save(tm_2, "images/14_metro_areas.png", width = 5, height = 4)

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

# add poi raster to demographic weights
reclass = c(reclass, poi)
# calculate the total score
result = sum(reclass)
# have a look at suitable bike shop locations in Berlin
berlin = metros[metro_names == "Berlin", ]
berlin_raster = terra::crop(result, berlin) 

# 4.2 Figure===============================================
#**********************************************************
m = mapview(raster::raster(berlin_raster), col.regions = c(NA, "darkgreen"),
            na.color = "transparent", legend = TRUE, map.type = "OpenStreetMap")
mapshot(m, url = file.path(getwd(), "images/08_bikeshops_berlin.html"))

# using leaflet (instead of mapview)
berlin_raster = berlin_raster >= 9
berlin_raster[berlin_raster == 0] = NA

leaflet() |>
  addTiles() |>
  addRasterImage(raster::raster(berlin_raster), colors = "darkgreen", opacity = 0.8) |>
  addLegend("bottomright", colors = c("darkgreen"), 
            labels = c("potential locations"), title = "Legend")
