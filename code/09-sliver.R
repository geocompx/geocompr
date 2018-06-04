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
# 2. SLIVER POLYGONS
#
#**********************************************************
# 1 ATTACH PACKAGES AND DATA-------------------------------
#**********************************************************

# attach packages
library("RQGIS")
library("spData")
library("sf")

# attach data
data("incongruent", package = "spData")
data("aggregating_zones", package = "spData")
incongruent = st_transform(incongruent, 4326)
aggregating_zones = st_transform(aggregating_zones, 4326)

#**********************************************************
# 2 SLIVER POLYGONS----------------------------------------
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
plot(single$geometry, col = NA)
plot(sub$geometry, add = TRUE, col = "blue", border = "blue", lwd = 1.5)


# eliminate sliver polygons
get_usage("qgis:eliminatesliverpolygons")
clean = run_qgis("qgis:eliminatesliverpolygons",
                 INPUT = mp,
                 ATTRIBUTE = "area",
                 COMPARISON = "<=",
                 COMPARISONVALUE = 25000,
                 OUTPUT = file.path(tempdir(), "clean.gpkg"),
                 load_output = TRUE)
# plot cleaned polygons
plot(st_geometry(clean))
