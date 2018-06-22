## ---- message=FALSE------------------------------------------------------
library(sf)
library(raster)
library(tidyverse)
library(spData)

## ---- eval=FALSE---------------------------------------------------------
## download.file(url = "http://nrdata.nps.gov/programs/lands/nps_boundary.zip",
##               destfile = "nps_boundary.zip")
## unzip(zipfile = "nps_boundary.zip")
## f = "temp/Current_Shapes/Data_Store/06-06-12_Posting/nps_boundary.shp"
## usa_parks = st_read(dsn = f)

## ----datapackages, echo=FALSE--------------------------------------------
datapackages = tibble::tribble(
  ~`Package name`, ~Description,
  "getlandsat", "Provides access to Landsat 8 data.",
  "osmdata", "Download and import of OpenStreetMap data.",
  "raster", "The `getData()` function downloads and imports administrative country, SRTM/ASTER elevation, WorldClim data.",
  "rnaturalearth", "Functions to download Natural Earth vector and raster data, including world country borders.",
  "rnoaa", "An R interface to National Oceanic and Atmospheric Administration (NOAA) climate data.",
  "rWBclimate", "An access to the World Bank climate data."
)
knitr::kable(datapackages, caption = "Selected R packages for spatial data retrieval.")

## ------------------------------------------------------------------------
library(rnaturalearth)
usa = ne_countries(country = "United States of America") # United States borders
class(usa)
# alternative way of accessing the data, with raster::getData()
# getData("GADM", country = "USA", level = 0)

## ------------------------------------------------------------------------
usa_sf = st_as_sf(usa)

## ------------------------------------------------------------------------
library(raster)
worldclim_prec = getData(name = "worldclim", var = "prec", res = 10)
class(worldclim_prec)

## ---- eval=FALSE---------------------------------------------------------
## library(osmdata)
## parks = opq(bbox = "leeds uk") %>%
##   add_osm_feature(key = "leisure", value = "park") %>%
##   osmdata_sf()

## ---- eval=FALSE---------------------------------------------------------
## world2 = spData::world
## world3 = st_read(system.file("shapes/world.gpkg", package = "spData"))

## ----formats, echo=FALSE-------------------------------------------------
file_formats = tibble::tribble(~Name, ~Extension, ~Info, ~Type, ~Model, 
                         "ESRI Shapefile", ".shp (the main file)", "One of the most popular vector file formats. Consists of at least three files. The main files size cannot exceed 2 GB. It lacks support for mixed type. Column names are limited to 10 characters, and number of columns are limited at 255. It has poor support for Unicode standard. ", "Vector", "Partially open",
                         "GeoJSON", ".geojson", "Extends the JSON exchange format by including a subset of the simple feature representation.", "Vector", "Open",
                         "KML", ".kml", "XML-based format for spatial visualization, developed for use with Google Earth. Zipped KML file forms the KMZ format.", "Vector", "Open",
                         "GPX", ".gpx", "XML schema created for exchange of GPS data.", "Vector", "Open",
                         "GeoTIFF", ".tiff", "GeoTIFF is one of the most popular raster formats. Its structure is similar to the regular `.tif` format, however, additionally stores  the raster header.", "Raster", "Open",
                         "Arc ASCII", ".asc", "Text format where the first six lines represent the raster header, followed by the raster cell values arranged in rows and columns.", "Raster", "Open",
                         # "JPEG??"
                         "R-raster", ".gri, .grd", "Native raster format of the R-package raster.", "Raster", "Open",
                         # "NCDF??"
                         # "HDF??"
                         "SQLite/SpatiaLite", ".sqlite", "SQLite is a standalone, relational database management system. It is used as a default database driver in GRASS GIS 7. SpatiaLite is the spatial extension of SQLite providing support for simple features.", "Vector and raster", "Open",
                         # "WKT/WKB??",
                         "ESRI FileGDB", ".gdb", "Collection of spatial and nonspatial objects created in the ArcGIS software. It allows storage of multiple feature classes and enables use of topological definitions. Limited access to this format is provided by GDAL with the use of the OpenFileGDB and FileGDB drivers.", "Vector and raster", "Proprietary",
                         "GeoPackage", ".gpkg", "Lightweight database container based on SQLite allowing an easy and platform-independent exchange of geodata", "Vector and raster", "Open"
                         # "WKT/WKB"??
                         )
knitr::kable(file_formats, caption = "Selected spatial file formats.")

## ---- eval=FALSE---------------------------------------------------------
## sf_drivers = st_drivers()
## head(sf_drivers, n = 5)

## ----drivers, echo=FALSE-------------------------------------------------
sf_drivers = st_drivers() %>%
  dplyr::filter(name %in% c("ESRI Shapefile", "GeoJSON", "KML", "GPX", "GPKG"))
knitr::kable(head(sf_drivers, n = 5), caption = "Sample of available drivers for reading/writing vector data (it could vary between different GDAL versions).")

## ------------------------------------------------------------------------
vector_filepath = system.file("shapes/world.gpkg", package = "spData")
world = st_read(vector_filepath)

## ---- results='hide'-----------------------------------------------------
cycle_hire_txt = system.file("misc/cycle_hire_xy.csv", package = "spData")
cycle_hire_xy = st_read(cycle_hire_txt, options = c("X_POSSIBLE_NAMES=X",
                                                    "Y_POSSIBLE_NAMES=Y"))

## ---- results='hide'-----------------------------------------------------
world_txt = system.file("misc/world_wkt.csv", package = "spData")
world_wkt = read_sf(world_txt, options = "GEOM_POSSIBLE_NAMES=WKT")
# the same as
world_wkt = st_read(world_txt, options = "GEOM_POSSIBLE_NAMES=WKT", 
                    quiet = TRUE, stringsAsFactors = FALSE)

## Not all of the supported vector file formats store information about their coordinate reference system.

## ------------------------------------------------------------------------
url = "https://developers.google.com/kml/documentation/KML_Samples.kml"
st_layers(url)
kml = read_sf(url, layer = "Placemarks")

## ---- message=FALSE------------------------------------------------------
raster_filepath = system.file("raster/srtm.tif", package = "spDataLarge")
single_layer = raster(raster_filepath)

## ------------------------------------------------------------------------
multilayer_filepath = system.file("raster/landsat.tif", package = "spDataLarge")
band3 = raster(multilayer_filepath, band = 3)

## ------------------------------------------------------------------------

multilayer_brick = brick(multilayer_filepath)
multilayer_stack = stack(multilayer_filepath)

## ---- echo=FALSE, results='hide'-----------------------------------------
world_files = list.files(pattern = "world\\.")
file.remove(world_files)

## ------------------------------------------------------------------------
st_write(obj = world, dsn = "world.gpkg")

## ---- error=TRUE---------------------------------------------------------
st_write(obj = world, dsn = "world.gpkg")

## ---- results='hide'-----------------------------------------------------
st_write(obj = world, dsn = "world.gpkg", layer_options = "OVERWRITE=YES")

## ---- results='hide'-----------------------------------------------------
st_write(obj = world, dsn = "world.gpkg", delete_layer = TRUE)

## ------------------------------------------------------------------------
write_sf(obj = world, dsn = "world.gpkg")

## ---- eval=FALSE---------------------------------------------------------
## st_write(cycle_hire_xy, "cycle_hire_xy.csv", layer_options = "GEOMETRY=AS_XY")
## st_write(world_wkt, "world_wkt.csv", layer_options = "GEOMETRY=AS_WKT")

## ----datatypes, echo=FALSE-----------------------------------------------
dT = tibble::tribble(
               ~`Data type`,      ~`Minimum value`,        ~`Maximum value`,
               "LOG1S",             "FALSE (0)",              "TRUE (1)",
               "INT1S",                  "-127",                   "127",
               "INT1U",                     "0",                   "255",
               "INT2S",               "-32,767",                "32,767",
               "INT2U",                     "0",                "65,534",
               "INT4S",        "-2,147,483,647",         "2,147,483,647",
               "INT4U",                     "0",         "4,294,967,296",
               "FLT4S",              "-3.4e+38",               "3.4e+38",
               "FLT8S",             "-1.7e+308",              "1.7e+308"
  )
knitr::kable(dT, caption = "Data types supported by the raster package.")

## ---- eval=FALSE---------------------------------------------------------
## writeRaster(x = single_layer,
##             filename = "my_raster.tif",
##             datatype = "INT2U")

## ---- eval=FALSE---------------------------------------------------------
## writeRaster(x = single_layer,
##             filename = "my_raster.tif",
##             datatype = "INT2U",
##             options = c("COMPRESS=DEFLATE"),
##             overwrite = TRUE)

## ---- eval=FALSE---------------------------------------------------------
## png(filename = "lifeExp.png", width = 500, height = 350)
## plot(world["lifeExp"])
## dev.off()

## ---- eval=FALSE---------------------------------------------------------
## library(tmap)
## tmap_obj = tm_shape(world) +
##   tm_polygons(col = "lifeExp")
## tmap_save(tm  = tmap_obj, filename = "lifeExp_tmap.png")

## ---- eval=FALSE---------------------------------------------------------
## library(mapview)
## mapview_obj = mapview(world, zcol = "lifeExp", legend = TRUE)
## mapshot(mapview_obj, file = "my_interactive_map.html")

