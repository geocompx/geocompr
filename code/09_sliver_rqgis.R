library(sf)
library(raster)
library(RQGIS3)
library(RSAGA)
library(rgrass7)

data("incongruent", "aggregating_zones", package = "spData")
incongr_wgs = st_transform(incongruent, 4326)
aggzone_wgs = st_transform(aggregating_zones, 4326)

alg = "native:union"
union = run_qgis(alg, INPUT = incongr_wgs, OVERLAY = aggzone_wgs, 
                 OUTPUT = file.path(tempdir(), "union.shp"),
                 load_output = TRUE)
single = run_qgis("native:multiparttosingleparts",
                  INPUT = file.path(tempdir(), "union.shp"),
                  OUTPUT = file.path(tempdir(), "single.shp"),
                  load_output = TRUE)
# remove empty geometries
union = union[!is.na(st_dimension(union)), ]
# multipart polygons to single polygons
single = st_cast(union, "POLYGON")
# find polygons which are smaller than 25000 m^2
x = 25000
units(x) = "m^2"
single$area = st_area(single)
sub = dplyr::filter(single, area < x)

find_algorithms("sliver", name_only = TRUE)
#> [1] "qgis:eliminatesliverpolygons"
alg = "qgis:eliminatesliverpolygons"
clean = run_qgis("grass7:v.clean",
                 input = file.path(tempdir(), "union.shp"),
                 tool = 10,
                 threshold = 25000,
                 output = file.path(tempdir(), "clean.shp"),
                 error = file.path(tempdir(), "error.shp"),
                 load_output = TRUE)

for (i in 110:nrow(single)) {
  print(i)
  st_write(single[i, ], file.path(tempdir(), "test.shp"), delete_dsn = TRUE)
}
