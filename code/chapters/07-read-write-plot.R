## ----07-read-write-plot-1, message=FALSE---------------------------------
library(sf)
library(raster)
library(dplyr)
library(spData)

## ----07-read-write-plot-2, eval=FALSE------------------------------------
## download.file(url = "http://nrdata.nps.gov/programs/lands/nps_boundary.zip",
##               destfile = "nps_boundary.zip")
## unzip(zipfile = "nps_boundary.zip")
## usa_parks = st_read(dsn = "nps_boundary.shp")

## ----datapackages, echo=FALSE, warning=FALSE-----------------------------
datapackages = tibble::tribble(
  ~`Package`, ~Description,
  "getlandsat", "Provides access to Landsat 8 data.",
  "osmdata", "Download and import of OpenStreetMap data.",
  "raster", "getData() imports administrative, elevation, WorldClim data.",
  "rnaturalearth", "Access to Natural Earth vector and raster data.",
  "rnoaa", "Imports National Oceanic and Atmospheric Administration (NOAA) climate data.",
  "rWBclimate", "Access World Bank climate data."
)
knitr::kable(datapackages, 
             caption = "Selected R packages for geographic data retrieval.", 
             caption.short = "Selected R packages for geographic data retrieval.",
             booktabs = TRUE) %>%
  kableExtra::kable_styling(latex_options="scale_down")

## ----07-read-write-plot-3------------------------------------------------
library(rnaturalearth)
usa = ne_countries(country = "United States of America") # United States borders
class(usa)
# alternative way of accessing the data, with raster::getData()
# getData("GADM", country = "USA", level = 0)

## ----07-read-write-plot-4------------------------------------------------
usa_sf = st_as_sf(usa)

## ----07-read-write-plot-5------------------------------------------------
library(raster)
worldclim_prec = getData(name = "worldclim", var = "prec", res = 10)
class(worldclim_prec)

## ----07-read-write-plot-6, eval=FALSE------------------------------------
## library(osmdata)
## parks = opq(bbox = "leeds uk") %>%
##   add_osm_feature(key = "leisure", value = "park") %>%
##   osmdata_sf()

## ----07-read-write-plot-7, eval=FALSE------------------------------------
## world2 = spData::world
## world3 = st_read(system.file("shapes/world.gpkg", package = "spData"))

## ----07-read-write-plot-8------------------------------------------------
base_url = "http://www.fao.org/figis/geoserver/wfs"
q = list(request = "GetCapabilities")
res = httr::GET(url = base_url, query = q)
res$url

## ----07-read-write-plot-9, eval=FALSE------------------------------------
## txt = httr::content(res, "text")
## xml = xml2::read_xml(txt)

## ----07-read-write-plot-10-----------------------------------------------
#> {xml_document} ...
#> [1] <ows:ServiceIdentification>\n  <ows:Title>GeoServer WFS...
#> [2] <ows:ServiceProvider>\n  <ows:ProviderName>Food and Agr...
#> ...

## ----07-read-write-plot-11, echo=FALSE, eval=FALSE-----------------------
## library(XML)
## library(RCurl)
## library(httr)
## base_url = "http://www.fao.org/figis/geoserver/wfs"
## q = list(request = "GetCapabilities")
## res = httr::GET(url = base_url, query = q)
## doc = xmlParse(res)
## root = xmlRoot(doc)
## names(root)
## names(root[["FeatureTypeList"]])
## root[["FeatureTypeList"]][["FeatureType"]][["Name"]]
## tmp = xmlSApply(root[["FeatureTypeList"]], function(x) xmlValue(x[["Name"]]))

## ----07-read-write-plot-12, eval=FALSE-----------------------------------
## qf = list(request = "GetFeature", typeName = "area:FAO_AREAS")
## file = tempfile(fileext = ".gml")
## httr::GET(url = base_url, query = qf, httr::write_disk(file))
## fao_areas = sf::read_sf(file)

## ----07-read-write-plot-13, eval=FALSE-----------------------------------
## library(ows4R)
## wfs = WFSClient$new("http://www.fao.org/figis/geoserver/wfs",
##                       serviceVersion = "1.0.0", logger = "INFO")
## fao_areas = wfs$getFeatures("area:FAO_AREAS")

## ----07-read-write-plot-14, echo=FALSE, eval=FALSE-----------------------
## # not shown as too verbose an example already
## area_27 = wfs$getFeatures("area:FAO_AREAS",
##                           cql_filter = URLencode("F_CODE= '27'"))

## ----07-read-write-plot-15, eval=FALSE, echo=FALSE-----------------------
## # checking out WFS using German datasets
## library(ows4R)
## library(sf)
## base_url = "http://www.lfu.bayern.de/gdi/wfs/naturschutz/schutzgebiete?"
## wfs = WFSClient$new(base_url, "1.0.0", logger = "INFO")
## # wfs$getUrl()
## # wfs$getClassName()
## 
## caps = wfs$getCapabilities()
## caps
## tmp = caps$findFeatureTypeByName("")
## # find out about the available feature types
## sapply(tmp, function(x) x$getName())
## # ok, let's download the national parcs of Bavaria
## ft = caps$findFeatureTypeByName("lfu:nationalpark")
## ft$getDescription()  # some problem here, I guess due to German spelling (umlaut, etc.). BTW the same happens when using the data from the Netherlands
## ft$getBoundingBox()  # no bounding box
## ft$getDefaultCRS()  # default CRS
## nps = ft$getFeatures()
## # this does not work properly, however, it downloads the data to the temporary
## # directory, hence, we can load them into R ourselves
## file = grep("gml", dir(tempdir()), value = TRUE)
## file = file.path(tempdir(), file)
## # assuming there is only one file
## layer = read_sf(file)
## plot(layer$geometry)

## ----07-read-write-plot-16, eval=FALSE, echo=FALSE-----------------------
## library(ows4R)
## library(sf)
## # data gathered from https://catalog.data.gov/dataset?res_format=WFS
## # downloading US national parks
## base_url = paste0("http://gstore.unm.edu/apps/rgis/datasets/",
##                   "7bbe8af5-029b-4adf-b06c-134f0dd57226/services/ogc/wfs?")
## # downloading public US airports
## base_url = paste0("http://gstore.unm.edu/apps/rgis/datasets/",
##                  "7387537d-dff6-48d1-9004-4f089f48dea1/services/ogc/wfs?")
## # establish the connection
## wfs = WFSClient$new(base_url, "1.0.0", logger = "INFO")
## # wfs$getUrl()
## # wfs$getClassName()
## 
## caps = wfs$getCapabilities()
## caps
## # find out about the available feature types
## tmp = caps$findFeatureTypeByName("")
## tmp$getName()
## # ok, let's download all US national parcs
## ft = caps$findFeatureTypeByName("nps_boundary")
## # ft = caps$findFeatureTypeByName("tra2shp")  # airports
## ft$getDescription()
## ft$getBoundingBox()
## ft$getDefaultCRS()
## nps = ft$getFeatures()
## # this returns an sf object
## plot(nps$msGeometry)

## ----formats, echo=FALSE-------------------------------------------------
file_formats = tibble::tribble(~Name, ~Extension, ~Info, ~Type, ~Model, 
                         "ESRI Shapefile", ".shp (the main file)", "Popular format consisting of at least three files. No support for: files > 2GB;  mixed types; names > 10 chars; cols > 255.", "Vector", "Partially open",
                         "GeoJSON", ".geojson", "Extends the JSON exchange format by including a subset of the simple feature representation.", "Vector", "Open",
                         "KML", ".kml", "XML-based format for spatial visualization, developed for use with Google Earth. Zipped KML file forms the KMZ format.", "Vector", "Open",
                         "GPX", ".gpx", "XML schema created for exchange of GPS data.", "Vector", "Open",
                         "GeoTIFF", ".tiff", "Popular raster format similar to `.tif` format but stores raster header.", "Raster", "Open",
                         "Arc ASCII", ".asc", "Text format where the first six lines represent the raster header, followed by the raster cell values arranged in rows and columns.", "Raster", "Open",
                         "R-raster", ".gri, .grd", "Native raster format of the R-package raster.", "Raster", "Open",
                         "SQLite/SpatiaLite", ".sqlite", "Standalone  relational database, SpatiaLite is the spatial extension of SQLite.", "Vector and raster", "Open",
                         "ESRI FileGDB", ".gdb", "Spatial and nonspatial objects created by ArcGIS. Allows: multiple feature classes; topology. Limited support from GDAL.", "Vector and raster", "Proprietary",
                         "GeoPackage", ".gpkg", "Lightweight database container based on SQLite allowing an easy and platform-independent exchange of geodata", "Vector and raster", "Open"
                         )
knitr::kable(file_formats, 
             caption = "Selected spatial file formats.",
             caption.short = "Selected spatial file formats.",
             booktabs = TRUE) %>% 
  kableExtra::column_spec(2, width = "7em") %>% 
  kableExtra::column_spec(3, width = "14em") %>% 
  kableExtra::column_spec(5, width = "7em")

## ----07-read-write-plot-17, eval=FALSE-----------------------------------
## sf_drivers = st_drivers()
## head(sf_drivers, n = 5)

## ----drivers, echo=FALSE-------------------------------------------------
sf_drivers = st_drivers() %>%
  dplyr::filter(name %in% c("ESRI Shapefile", "GeoJSON", "KML", "GPX", "GPKG"))
knitr::kable(head(sf_drivers, n = 5),
             caption = paste("Sample of available drivers for reading/writing", 
                             "vector data (it could vary between different", 
                             "GDAL versions)."),
             caption.short = "Sample of available vector drivers.",
             booktabs = TRUE) %>% 
  kableExtra::column_spec(2, width = "7em")

## ----07-read-write-plot-18, eval=FALSE-----------------------------------
## vector_filepath = system.file("shapes/world.gpkg", package = "spData")
## world = st_read(vector_filepath)
## #> Reading layer `world' from data source `.../world.gpkg' using driver `GPKG'
## #> Simple feature collection with 177 features and 10 fields
## #> geometry type:  MULTIPOLYGON
## #> dimension:      XY
## #> bbox:           xmin: -180 ymin: -90 xmax: 180 ymax: 83.64513
## #> epsg (SRID):    4326
## #> proj4string:    +proj=longlat +datum=WGS84 +no_defs

## ----07-read-write-plot-19, echo=FALSE-----------------------------------
vector_filepath = system.file("shapes/world.gpkg", package = "spData")
world = st_read(vector_filepath, quiet = TRUE)

## ----07-read-write-plot-20, results='hide'-------------------------------
cycle_hire_txt = system.file("misc/cycle_hire_xy.csv", package = "spData")
cycle_hire_xy = st_read(cycle_hire_txt, options = c("X_POSSIBLE_NAMES=X",
                                                    "Y_POSSIBLE_NAMES=Y"))

## ----07-read-write-plot-21, results='hide'-------------------------------
world_txt = system.file("misc/world_wkt.csv", package = "spData")
world_wkt = read_sf(world_txt, options = "GEOM_POSSIBLE_NAMES=WKT")
# the same as
world_wkt = st_read(world_txt, options = "GEOM_POSSIBLE_NAMES=WKT", 
                    quiet = TRUE, stringsAsFactors = FALSE)

## Not all of the supported vector file formats store information about their coordinate reference system.

## ----07-read-write-plot-23-----------------------------------------------
u = "https://developers.google.com/kml/documentation/KML_Samples.kml"
download.file(u, "KML_Samples.kml")
st_layers("KML_Samples.kml")
kml = read_sf("KML_Samples.kml", layer = "Placemarks")

## ----07-read-write-plot-24, message=FALSE--------------------------------
raster_filepath = system.file("raster/srtm.tif", package = "spDataLarge")
single_layer = raster(raster_filepath)

## ----07-read-write-plot-25-----------------------------------------------
multilayer_filepath = system.file("raster/landsat.tif", package = "spDataLarge")
band3 = raster(multilayer_filepath, band = 3)

## ----07-read-write-plot-26-----------------------------------------------
multilayer_brick = brick(multilayer_filepath)
multilayer_stack = stack(multilayer_filepath)

## ----07-read-write-plot-27, echo=FALSE, results='hide'-------------------
world_files = list.files(pattern = "world\\.")
file.remove(world_files)

## ----07-read-write-plot-28-----------------------------------------------
st_write(obj = world, dsn = "world.gpkg")

## ----07-read-write-plot-29, eval=FALSE-----------------------------------
## st_write(obj = world, dsn = "world.gpkg")
## #> Updating layer `world' to data source `world.gpkg' using driver `GPKG'
## #> Creating layer world failed.
## #> Error in CPL_write_ogr(obj, dsn, layer, driver, ...),  :
## #>   Layer creation failed.
## #> In addition: Warning message:
## #> In CPL_write_ogr(obj, dsn, layer, driver, ...),  :
## #>   GDAL Error 1: Layer world already exists, CreateLayer failed.
## #> Use the layer creation option OVERWRITE=YES to replace it.

## ----07-read-write-plot-30, results='hide'-------------------------------
st_write(obj = world, dsn = "world.gpkg", layer_options = "OVERWRITE=YES")

## ----07-read-write-plot-31, results='hide'-------------------------------
st_write(obj = world, dsn = "world.gpkg", delete_layer = TRUE)

## ----07-read-write-plot-32-----------------------------------------------
write_sf(obj = world, dsn = "world.gpkg")

## ----07-read-write-plot-33, eval=FALSE-----------------------------------
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
knitr::kable(dT, caption = "Data types supported by the raster package.",
             caption.short = "Data types supported by the raster package.",
             booktabs = TRUE)

## ----07-read-write-plot-34, eval=FALSE-----------------------------------
## writeRaster(x = single_layer,
##             filename = "my_raster.tif",
##             datatype = "INT2U")

## ----07-read-write-plot-35, eval=FALSE-----------------------------------
## writeRaster(x = single_layer,
##             filename = "my_raster.tif",
##             datatype = "INT2U",
##             options = c("COMPRESS=DEFLATE"),
##             overwrite = TRUE)

## ----07-read-write-plot-36, eval=FALSE-----------------------------------
## png(filename = "lifeExp.png", width = 500, height = 350)
## plot(world["lifeExp"])
## dev.off()

## ----07-read-write-plot-37, eval=FALSE-----------------------------------
## library(tmap)
## tmap_obj = tm_shape(world) +
##   tm_polygons(col = "lifeExp")
## tmap_save(tm  = tmap_obj, filename = "lifeExp_tmap.png")

## ----07-read-write-plot-38, eval=FALSE-----------------------------------
## library(mapview)
## mapview_obj = mapview(world, zcol = "lifeExp", legend = TRUE)
## mapshot(mapview_obj, file = "my_interactive_map.html")

