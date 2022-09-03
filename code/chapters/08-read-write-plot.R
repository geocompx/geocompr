## ----07-read-write-plot-1, message=FALSE------------------------------------------------------------------------------------------------------------------
library(sf)
library(terra)
library(dplyr)
library(spData)


## ----07-read-write-plot-2, eval=FALSE---------------------------------------------------------------------------------------------------------------------
## download.file(url = "https://hs.pangaea.de/Maps/PeRL/PeRL_permafrost_landscapes.zip",
##               destfile = "PeRL_permafrost_landscapes.zip",
##               mode = "wb")
## unzip("PeRL_permafrost_landscapes.zip")
## canada_perma_land = read_sf("PeRL_permafrost_landscapes/canada_perma_land.shp")


## ----datapackages, echo=FALSE, warning=FALSE--------------------------------------------------------------------------------------------------------------
datapackages = tibble::tribble(
  ~`Package`, ~Description,
  "osmdata", "Download and import small OpenStreetMap datasets.",
  "osmextract", "Download and import large OpenStreetMap datasets.",
  "geodata", "Download and import imports administrative, elevation, WorldClim data.",
  "rnaturalearth", "Access to Natural Earth vector and raster data.",
  "rnoaa", "Imports National Oceanic and Atmospheric Administration (NOAA) climate data."
)
knitr::kable(datapackages, 
             caption = "Selected R packages for geographic data retrieval.", 
             caption.short = "Selected R packages for geographic data retrieval.",
             booktabs = TRUE) |>
  kableExtra::kable_styling(latex_options="scale_down")


## ----07-read-write-plot-3---------------------------------------------------------------------------------------------------------------------------------
library(rnaturalearth)
usa = ne_countries(country = "United States of America") # United States borders
class(usa)
# alternative way of accessing the data, with geodata
# geodata::gadm("USA", level = 0, path = tempdir())


## ----07-read-write-plot-4---------------------------------------------------------------------------------------------------------------------------------
usa_sf = st_as_sf(usa)


## ----07-read-write-plot-5, eval=FALSE---------------------------------------------------------------------------------------------------------------------
## library(geodata)
## worldclim_prec = worldclim_global("prec", res = 10, path = tempdir())
## class(worldclim_prec)


## ----07-read-write-plot-6, eval=FALSE---------------------------------------------------------------------------------------------------------------------
## library(osmdata)
## parks = opq(bbox = "leeds uk") |>
##   add_osm_feature(key = "leisure", value = "park") |>
##   osmdata_sf()


## ----07-read-write-plot-7, eval=FALSE---------------------------------------------------------------------------------------------------------------------
## world2 = spData::world
## world3 = read_sf(system.file("shapes/world.gpkg", package = "spData"))


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## library(tidygeocoder)
## geo_df = data.frame(address = "54 Frith St, London W1D 4SJ, UK")
## geo_df = geocode(geo_df, address, method = "osm")
## geo_df


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## geo_sf = st_as_sf(geo_df, coords = c("lat", "long"), crs = "EPSG:4326")


## ----07-read-write-plot-8---------------------------------------------------------------------------------------------------------------------------------
library(httr)
base_url = "http://www.fao.org"
endpoint = "/figis/geoserver/wfs"
q = list(request = "GetCapabilities")
res = GET(url = modify_url(base_url, path = endpoint), query = q)
res$url


## ----07-read-write-plot-9, eval=FALSE---------------------------------------------------------------------------------------------------------------------
## txt = content(res, "text")
## xml = xml2::read_xml(txt)


## ----07-read-write-plot-10, eval=FALSE--------------------------------------------------------------------------------------------------------------------
## xml
## #> {xml_document} ...
## #> [1] <ows:ServiceIdentification>\n  <ows:Title>GeoServer WFS...
## #> [2] <ows:ServiceProvider>\n  <ows:ProviderName>UN-FAO Fishe...
## #> ...


## ----07-read-write-plot-11, echo=FALSE, eval=FALSE--------------------------------------------------------------------------------------------------------
## library(xml2)
## library(curl)
## library(httr)
## base_url = "http://www.fao.org/figis/geoserver/wfs"
## q = list(request = "GetCapabilities")
## res = GET(url = base_url, query = q)
## doc = xmlParse(res)
## root = xmlRoot(doc)
## names(root)
## names(root[["FeatureTypeList"]])
## root[["FeatureTypeList"]][["FeatureType"]][["Name"]]
## tmp = xmlSApply(root[["FeatureTypeList"]], function(x) xmlValue(x[["Name"]]))


## ----07-read-write-plot-12, eval=FALSE--------------------------------------------------------------------------------------------------------------------
## qf = list(request = "GetFeature", typeName = "area:FAO_AREAS")
## file = tempfile(fileext = ".gml")
## GET(url = base_url, path = endpoint, query = qf, write_disk(file))
## fao_areas = read_sf(file)


## ----formats, echo=FALSE----------------------------------------------------------------------------------------------------------------------------------
file_formats = tibble::tribble(~Name, ~Extension, ~Info, ~Type, ~Model, 
                         "ESRI Shapefile", ".shp (the main file)", "Popular format consisting of at least three files. No support for: files > 2GB;  mixed types; names > 10 chars; cols > 255.", "Vector", "Partially open",
                         "GeoJSON", ".geojson", "Extends the JSON exchange format by including a subset of the simple feature representation; mostly used for storing coordinates in longitude and latitude; it is extended by the TopoJSON format", "Vector", "Open",
                         "KML", ".kml", "XML-based format for spatial visualization, developed for use with Google Earth. Zipped KML file forms the KMZ format.", "Vector", "Open",
                         "GPX", ".gpx", "XML schema created for exchange of GPS data.", "Vector", "Open",
                         "FlatGeobuf", ".fgb", "Single file format allowing for quick reading and writing of vector data. Has streaming capabilities.", "Vector", "Open",
                         "GeoTIFF", ".tif/.tiff", "Popular raster format. A TIFF file containing additional spatial metadata.", "Raster", "Open",
                         "Arc ASCII", ".asc", "Text format where the first six lines represent the raster header, followed by the raster cell values arranged in rows and columns.", "Raster", "Open",
                         "SQLite/SpatiaLite", ".sqlite", "Standalone  relational database, SpatiaLite is the spatial extension of SQLite.", "Vector and raster", "Open",
                         "ESRI FileGDB", ".gdb", "Spatial and nonspatial objects created by ArcGIS. Allows: multiple feature classes; topology. Limited support from GDAL.", "Vector and raster", "Proprietary",
                         "GeoPackage", ".gpkg", "Lightweight database container based on SQLite allowing an easy and platform-independent exchange of geodata", "Vector and (very limited) raster", "Open"
                         )
knitr::kable(file_formats, 
             caption = "Selected spatial file formats.",
             caption.short = "Selected spatial file formats.",
             booktabs = TRUE) |> 
  kableExtra::column_spec(2, width = "7em") |> 
  kableExtra::column_spec(3, width = "14em") |> 
  kableExtra::column_spec(5, width = "7em")


## ----07-read-write-plot-17, eval=FALSE--------------------------------------------------------------------------------------------------------------------
## sf_drivers = st_drivers()
## head(sf_drivers, n = 3)
## summary(sf_drivers[-c(1:2)])


## ----drivers, echo=FALSE----------------------------------------------------------------------------------------------------------------------------------
sf_drivers = st_drivers() |>
  dplyr::filter(name %in% c("ESRI Shapefile", "GeoJSON", "KML", "GPX", "GPKG", "FlatGeobuf")) |> 
  tibble::as_tibble() # remove unhelpful row names
knitr::kable(head(sf_drivers, n = 6),
             caption = paste("Popular drivers/formats for reading/writing", 
                             "vector data."),
             caption.short = "Sample of available vector drivers.",
             booktabs = TRUE) |> 
  kableExtra::column_spec(2, width = "7em")


## ----07-read-write-plot-19--------------------------------------------------------------------------------------------------------------------------------
f = system.file("shapes/world.gpkg", package = "spData")
world = read_sf(f, quiet = TRUE)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
tanzania = read_sf(f, query = 'SELECT * FROM world WHERE name_long = "Tanzania"')


## ---- eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
## tanzania = read_sf(f, query = 'SELECT * FROM world WHERE FID = 0')


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
tanzania_buf = st_buffer(tanzania, 50000)
tanzania_buf_geom = st_geometry(tanzania_buf)
tanzania_buf_wkt = st_as_text(tanzania_buf_geom)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
tanzania_neigh = read_sf(f, wkt_filter = tanzania_buf_wkt)


## ----readsfquery, echo=FALSE, message=FALSE, fig.cap="Reading a subset of the vector data using a query (A) and a wkt filter (B)."------------------------
library(tmap)
tm1 = tm_shape(tanzania) +
  tm_polygons(lwd = 2) +
  tm_text(text = "name_long") + 
  tm_scale_bar(c(0, 200, 400), position = c("left", "bottom")) +
  tm_layout(main.title = "A. query")
tanzania_neigh[tanzania_neigh$iso_a2 == "CD", "name_long"] = "Democratic\nRepublic\nof the Congo"
tm2 = tm_shape(tanzania_neigh) +
  tm_polygons() +
  tm_text(text = "name_long", size = "AREA",
          auto.placement = FALSE, remove.overlap = FALSE,
          root = 6, legend.size.show = FALSE) +
  tm_shape(tanzania_buf) +
  tm_polygons(col = "red", border.col = "red", alpha = 0.05) +
  tm_add_legend(type = "fill", labels = "50km buffer around Tanzania",
                col = "red", alpha = 0.1, border.col = "red")  +
  tm_scale_bar(c(0, 200, 400), position = c("right", "bottom")) +
  tm_layout(legend.width = 0.5,
            legend.position = c("left", "bottom"),
            main.title = "B. wkt_filter")
tmap_arrange(tm1, tm2)


## ----07-read-write-plot-20, results='hide'----------------------------------------------------------------------------------------------------------------
cycle_hire_txt = system.file("misc/cycle_hire_xy.csv", package = "spData")
cycle_hire_xy = read_sf(cycle_hire_txt,
  options = c("X_POSSIBLE_NAMES=X", "Y_POSSIBLE_NAMES=Y"))


## ----07-read-write-plot-21, results='hide'----------------------------------------------------------------------------------------------------------------
world_txt = system.file("misc/world_wkt.csv", package = "spData")
world_wkt = read_sf(world_txt, options = "GEOM_POSSIBLE_NAMES=WKT")
# the same as
world_wkt2 = st_read(world_txt, options = "GEOM_POSSIBLE_NAMES=WKT", 
                    quiet = TRUE, stringsAsFactors = FALSE, as_tibble = TRUE)


## ---- echo=FALSE, eval=FALSE------------------------------------------------------------------------------------------------------------------------------
## identical(world_wkt, world_wkt2)


## Not all of the supported vector file formats store information about their coordinate reference system.

## In these situations, it is possible to add the missing information using the `st_set_crs()` function.

## Please refer also to Section \@ref(crs-intro) for more information.


## ----07-read-write-plot-23--------------------------------------------------------------------------------------------------------------------------------
u = "https://developers.google.com/kml/documentation/KML_Samples.kml"
download.file(u, "KML_Samples.kml")
st_layers("KML_Samples.kml")
kml = read_sf("KML_Samples.kml", layer = "Placemarks")


## ---- echo=FALSE, results='hide'--------------------------------------------------------------------------------------------------------------------------
file.remove("KML_Samples.kml")


## ----07-read-write-plot-24, message=FALSE-----------------------------------------------------------------------------------------------------------------
raster_filepath = system.file("raster/srtm.tif", package = "spDataLarge")
single_layer = rast(raster_filepath)


## ----07-read-write-plot-25--------------------------------------------------------------------------------------------------------------------------------
multilayer_filepath = system.file("raster/landsat.tif", package = "spDataLarge")
multilayer_rast = rast(multilayer_filepath)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
myurl = "/vsicurl/https://zenodo.org/record/5774954/files/clm_snow.prob_esacci.dec_p.90_500m_s0..0cm_2000..2012_v2.0.tif"
snow = rast(myurl)
snow


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
rey = data.frame(lon = -21.94, lat = 64.15)
snow_rey = extract(snow, rey)
snow_rey


## ----07-read-write-plot-27, echo=FALSE, results='hide'----------------------------------------------------------------------------------------------------
world_files = list.files(pattern = "world*")
file.remove(world_files)


## ----07-read-write-plot-28--------------------------------------------------------------------------------------------------------------------------------
write_sf(obj = world, dsn = "world.gpkg")


## ----07-read-write-plot-29, error=TRUE--------------------------------------------------------------------------------------------------------------------
write_sf(obj = world, dsn = "world.gpkg")


## ----07-read-write-plot-31, results='hide'----------------------------------------------------------------------------------------------------------------
write_sf(obj = world, dsn = "world_many_layers.gpkg", append = TRUE)


## ----07-read-write-plot-32--------------------------------------------------------------------------------------------------------------------------------
st_write(obj = world, dsn = "world2.gpkg")


## ----07-read-write-plot-33, eval=FALSE--------------------------------------------------------------------------------------------------------------------
## write_sf(cycle_hire_xy, "cycle_hire_xy.csv", layer_options = "GEOMETRY=AS_XY")
## write_sf(world_wkt, "world_wkt.csv", layer_options = "GEOMETRY=AS_WKT")


## ---- echo=FALSE, results='hide'--------------------------------------------------------------------------------------------------------------------------
file.remove(world_files)


## ----datatypes, echo=FALSE--------------------------------------------------------------------------------------------------------------------------------
dT = tibble::tribble(
               ~`Data type`,      ~`Minimum value`,        ~`Maximum value`,
               "INT1U",                     "0",                   "255",
               "INT2S",               "-32,767",                "32,767",
               "INT2U",                     "0",                "65,534",
               "INT4S",        "-2,147,483,647",         "2,147,483,647",
               "INT4U",                     "0",         "4,294,967,296",
               "FLT4S",              "-3.4e+38",               "3.4e+38",
               "FLT8S",             "-1.7e+308",              "1.7e+308"
  )
knitr::kable(dT, caption = "Data types supported by the terra package.",
             caption.short = "Data types supported by the terra package.",
             booktabs = TRUE)


## ----07-read-write-plot-34, eval=FALSE--------------------------------------------------------------------------------------------------------------------
## writeRaster(single_layer, filename = "my_raster.tif", datatype = "INT2U")


## ----07-read-write-plot-35, eval=FALSE--------------------------------------------------------------------------------------------------------------------
## writeRaster(x = single_layer, filename = "my_raster.tif",
##             gdal = c("COMPRESS=NONE"), overwrite = TRUE)


## ----07-read-write-plot-35b, eval=FALSE-------------------------------------------------------------------------------------------------------------------
## writeRaster(x = single_layer, filename = "my_raster.tif",
##             filetype = "COG", overwrite = TRUE)


## ----07-read-write-plot-36, eval=FALSE--------------------------------------------------------------------------------------------------------------------
## png(filename = "lifeExp.png", width = 500, height = 350)
## plot(world["lifeExp"])
## dev.off()


## ----07-read-write-plot-37, eval=FALSE--------------------------------------------------------------------------------------------------------------------
## library(tmap)
## tmap_obj = tm_shape(world) + tm_polygons(col = "lifeExp")
## tmap_save(tmap_obj, filename = "lifeExp_tmap.png")


## ----07-read-write-plot-38, eval=FALSE--------------------------------------------------------------------------------------------------------------------
## library(mapview)
## mapview_obj = mapview(world, zcol = "lifeExp", legend = TRUE)
## mapshot(mapview_obj, file = "my_interactive_map.html")


## ---- echo=FALSE, results='asis'--------------------------------------------------------------------------------------------------------------------------
res = knitr::knit_child('_08-ex.Rmd', quiet = TRUE, options = list(include = FALSE, eval = FALSE))
cat(res, sep = '\n')

