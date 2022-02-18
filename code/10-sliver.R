# Filename: 09-sliver.R (2018-06-04)
#
# TO DO: Create sliver polygon figure
#
# Author(s): Jannes Muenchow
#
#**********************************************************
# CONTENTS-------------------------------------------------
#**********************************************************
#
# 1. ATTACH PACKAGES AND DATA
# 2. ELIMINATE SLIVER POLYGONS
# 3. FIGURES
#
#**********************************************************
# 1 ATTACH PACKAGES AND DATA-------------------------------
#**********************************************************

# attach packages
library(RQGIS)
library(spData)
library(sf)
library(dplyr)
library(tmap)

# attach data
data("incongruent", package = "spData")
data("aggregating_zones", package = "spData")
incongruent = st_transform(incongruent, 4326)
aggregating_zones = st_transform(aggregating_zones, 4326)

#**********************************************************
# 2 ELIMINATE SLIVER POLYGONS------------------------------
#**********************************************************

set_env(dev = FALSE)
get_usage("qgis:union")
union = run_qgis("qgis:union", 
                 INPUT = incongruent,
                 INPUT2 = aggregating_zones,
                 OUTPUT = file.path(tempdir(), "union.shp"),
                 load_output = TRUE)
# getting rid of empty geometries
union = union[!is.na(st_dimension(union)), ]
# multipart polygons to single polygons
single = st_cast(union, "MULTIPOLYGON") %>%
  st_cast("POLYGON")
# figure
single$area = st_area(single)
# find polygons which are smaller than 25000 m^2
x = 25000
units(x) = "m^2"
sub = dplyr::filter(single, area < x)
# have a quick glance
plot(single$geometry, col = NA)
plot(sub$geometry, add = TRUE, col = "blue", border = "blue", lwd = 1.5)

# eliminate sliver polygons
get_usage("qgis:eliminatesliverpolygons")
clean = run_qgis("qgis:eliminatesliverpolygons",
                 INPUT = single,
                 ATTRIBUTE = "area",
                 COMPARISON = "<=",
                 COMPARISONVALUE = 25000,
                 OUTPUT = file.path(tempdir(), "clean.shp"),
                 load_output = TRUE)
# have a quick glance
plot(st_geometry(clean))

#**********************************************************
# 3 FIGURES------------------------------------------------
#**********************************************************

sliver_fig = tm_shape(single) + 
  tm_borders() + 
  tm_shape(sub) + 
  tm_fill(col = "blue") + 
  tm_borders(col = "blue", lwd = 1.5)

clean_fig = tm_shape(clean) + 
  tm_borders()

sc_maps = tmap_arrange(sliver_fig, clean_fig, ncol = 2) 

# save the output
tmap_save(sc_maps, "figures/09-sliver.png",
          width = 12, height = 5, units = "cm")
