## ----07-ex-e0, message=FALSE------------------------------------------------------------------------------------------------------------------------------
library(sf)
library(terra)
library(spData)


## ----07-ex-e1---------------------------------------------------------------------------------------------------------------------------------------------
st_crs(nz)
nz_wgs = st_transform(nz, "EPSG:4326")
nz_crs = st_crs(nz)
nz_wgs_crs = st_crs(nz_wgs)
nz_crs$epsg
nz_wgs_crs$epsg
st_bbox(nz)
st_bbox(nz_wgs)
nz_wgs_NULL_crs = st_set_crs(nz_wgs, NA)
nz_27700 = st_transform(nz_wgs, "EPSG:27700")
par(mfrow = c(1, 3))
plot(st_geometry(nz))
plot(st_geometry(nz_wgs))
plot(st_geometry(nz_wgs_NULL_crs))
# answer: it is fatter in the East-West direction
# because New Zealand is close to the South Pole and meridians converge there
plot(st_geometry(nz_27700))
par(mfrow = c(1, 1))


## ----07-ex-e2---------------------------------------------------------------------------------------------------------------------------------------------
# see https://github.com/r-spatial/sf/issues/509
world_tmerc = st_transform(world, "+proj=tmerc")
plot(st_geometry(world_tmerc))
world_4326 = st_transform(world_tmerc, "EPSG:4326")
plot(st_geometry(world_4326))


## ----07-ex-e3---------------------------------------------------------------------------------------------------------------------------------------------
con_raster = rast(system.file("raster/srtm.tif", package = "spDataLarge"))
con_raster_utm12n = project(con_raster, "EPSG:32612", method = "near")
con_raster_utm12n

plot(con_raster)
plot(con_raster_utm12n)


## ----07-ex-e4---------------------------------------------------------------------------------------------------------------------------------------------
cat_raster = rast(system.file("raster/nlcd.tif", package = "spDataLarge"))
cat_raster_wgs84 = project(cat_raster, "EPSG:4326", method = "bilinear")
cat_raster_wgs84

plot(cat_raster)
plot(cat_raster_wgs84)

