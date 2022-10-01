## ----08-ex-e0, message=FALSE------------------------------------------------------------------------------------------------------------------------------
library(sf)
library(terra)


## Vector formats: Shapefile (old format supported by many programs), GeoPackage (more recent format with better support of attribute data) and GeoJSON (common format for web mapping).

## 

## Raster formats: GeoTiff, Arc ASCII, R-raster (see book for descriptions).

## 

## Database formats: PostGIS, SQLite, FileGDB (see book for details).


## `st_read()` prints outputs and keeps strings as text strings (`st_read()` creates factors). This can be seen from the source code of `read_sf()`, which show's it wraps `st_read()`:


## ----08-ex-e2---------------------------------------------------------------------------------------------------------------------------------------------
read_sf


## ----08-ex-e3---------------------------------------------------------------------------------------------------------------------------------------------
c_h = read.csv(system.file("misc/cycle_hire_xy.csv", package = "spData")) |> 
  st_as_sf(coords = c("X", "Y"))
c_h


## ----08-ex-e4---------------------------------------------------------------------------------------------------------------------------------------------
library(rnaturalearth)
germany_borders = ne_countries(country = "Germany", returnclass = "sf")
plot(germany_borders)
st_write(germany_borders, "germany_borders.gpkg")


## ----08-ex-e5---------------------------------------------------------------------------------------------------------------------------------------------
library(geodata)
gmmt = worldclim_global(var = "tmin", res = 5, path = tempdir())
names(gmmt)
plot(gmmt)

gmmt_june = terra::subset(gmmt, "wc2.1_5m_tmin_06")
plot(gmmt_june)
writeRaster(gmmt_june, "tmin_june.tif")


## ----08-ex-e6---------------------------------------------------------------------------------------------------------------------------------------------
png(filename = "germany.png", width = 350, height = 500)
plot(st_geometry(germany_borders), axes = TRUE, graticule = TRUE)
dev.off()


## ----08-ex-e7, eval=FALSE---------------------------------------------------------------------------------------------------------------------------------
## library(mapview)
## mapview_obj = mapview(c_h, zcol = "nbikes", legend = TRUE)
## mapshot(mapview_obj, file = "cycle_hire.html")

