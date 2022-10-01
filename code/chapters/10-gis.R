## ----09-gis-1, message=FALSE------------------------------------------------------------------------------------------------------------------------------
library(sf)
library(terra)


## ----09-gis-1-2, message=FALSE, eval=FALSE----------------------------------------------------------------------------------------------------------------
## # remotes::install_github("paleolimbot/qgisprocess")
## library(qgisprocess)
## library(Rsagacmd)
## library(rgrass)
## library(rstac)
## library(gdalcubes)


## A command-line interface is a means of interacting with computer programs in which the user issues commands via successive lines of text (command lines).

## `bash` in Linux and `PowerShell` in Windows are its common examples.

## CLIs can be augmented with IDEs such as RStudio for R, which provides code auto-completion and other features to improve the user experience.


## ----gis-comp, echo=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------
library(dplyr)
d = tibble("GIS" = c("GRASS", "QGIS", "SAGA"),
            "First release" = c("1984", "2002", "2004"),
            "No. functions" = c(">500", ">1000", ">600"),
            "Support" = c("hybrid", "hybrid", "hybrid"))
knitr::kable(x = d, 
             caption = paste("Comparison between three open-source GIS.", 
                             "Hybrid refers to the support of vector and", 
                             "raster operations."),
             caption.short = "Comparison between three open-source GIS.", 
             booktabs = TRUE) #|>
  # kableExtra::add_footnote(label = "Comparing downloads of different providers is rather difficult (see http://spatialgalaxy.net/2011/12/19/qgis-users-around-the-world), and here also useless since every Windows QGIS download automatically also downloads SAGA and GRASS.", notation = "alphabet")


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## library(qgisprocess)
## #> Using 'qgis_process' at 'qgis_process'.
## #> QGIS version: 3.20.3-Odense
## #> ...


## ----providers, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## qgis_providers()
## #> # A tibble: 6 × 2
## #>   provider provider_title
## #>   <chr>    <chr>
## #> 1 3d       QGIS (3D)
## #> 2 gdal     GDAL
## #> 3 grass7   GRASS
## #> 4 native   QGIS (native c++)
## #> 5 qgis     QGIS
## #> 6 saga     SAGA


## ----09-gis-4---------------------------------------------------------------------------------------------------------------------------------------------
data("incongruent", "aggregating_zones", package = "spData")
incongr_wgs = st_transform(incongruent, "EPSG:4326")
aggzone_wgs = st_transform(aggregating_zones, "EPSG:4326")


## ----uniondata, echo=FALSE, fig.cap="Illustration of two areal units: incongruent (black lines) and aggregating zones (red borders). "--------------------
library(tmap)
tm_shape(incongr_wgs) +
  tm_polygons(border.col = "grey5") +
  tm_shape(aggzone_wgs) +
  tm_borders(alpha = 0.5, col = "red") +
  tm_add_legend(type = "line",
                labels = c("incongr_wgs", "aggzone_wgs"),
                col = c("grey5", "red"),
                lwd = 3) +
  tm_scale_bar(position = c("left", "bottom"),
               breaks = c(0, 0.5, 1)) +
  tm_layout(frame = FALSE,
            legend.text.size = 1)


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## qgis_algo = qgis_algorithms()


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## grep("union", qgis_algo$algorithm, value = TRUE)
## #> [1] "native:union"      "saga:fuzzyunionor" "saga:polygonunion"


## ----09-gis-6, eval=FALSE---------------------------------------------------------------------------------------------------------------------------------
## alg = "native:union"
## qgis_show_help(alg)


## ----09-gis-7, eval=FALSE---------------------------------------------------------------------------------------------------------------------------------
## union = qgis_run_algorithm(alg, INPUT = incongr_wgs, OVERLAY = aggzone_wgs)
## union


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## union_sf = st_as_sf(union)


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## grep("clean", qgis_algo$algorithm, value = TRUE)


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## qgis_show_help("grass7:v.clean")


## ----09-gis-7c, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## clean = qgis_run_algorithm("grass7:v.clean", input = union_sf,
##                            tool = 10, threshold = 25000)
## clean_sf = st_as_sf(clean)


## ----sliver, echo=FALSE, fig.cap="Sliver polygons colored in red (left panel). Cleaned polygons (right panel)."-------------------------------------------
knitr::include_graphics("figures/10-sliver.png")


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## library(qgisprocess)
## library(terra)
## dem = rast(system.file("raster/dem.tif", package = "spDataLarge"))


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## dem_slope = terrain(dem, unit = "radians")
## dem_aspect = terrain(dem, v = "aspect", unit = "radians")


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## qgis_algo = qgis_algorithms()
## grep("wetness", qgis_algo$algorithm, value = TRUE)


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## qgis_show_help("saga:sagawetnessindex")


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## dem_wetness = qgis_run_algorithm("saga:sagawetnessindex", DEM = dem)


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## dem_wetness_twi = qgis_as_terra(dem_wetness$TWI)


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## grep("geomorphon", qgis_algo$algorithm, value = TRUE)
## qgis_show_help("grass7:r.geomorphon")


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## dem_geomorph = qgis_run_algorithm("grass7:r.geomorphon", elevation = dem,
##                                     `-m` = TRUE, search = 120)


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## dem_geomorph_terra = qgis_as_terra(dem_geomorph$forms)


## ----qgis-raster-map, echo=FALSE, fig.cap="Topographic wetness index (TWI, left panel) and geomorphons (right panel) derived for the Mongón study area."----
knitr::include_graphics("figures/10-qgis-raster-map.png")


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## library(Rsagacmd)


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## saga = saga_gis(raster_backend = "terra", vector_backend = "sf")


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## ndvi = rast(system.file("raster/ndvi.tif", package = "spDataLarge"))


## ---- eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
## sg = saga$imagery_segmentation$seed_generation
## ndvi_seeds = sg(ndvi, band_width = 2)
## plot(ndvi_seeds$seed_grid)


## ---- eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
## srg = saga$imagery_segmentation$seeded_region_growing
## ndvi_srg = srg(ndvi_seeds$seed_grid, ndvi, method = 1)
## plot(ndvi_srg$segments)


## ---- eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
## ndvi_segments = st_as_sf(as.polygons(ndvi_srg$segments))


## ---- eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
## library(tmap)
## tm_shape(ndvi) +
##   tm_raster(style = "order") +
##   tm_shape(ndvi_segments) +
##   tm_borders()


## ---- eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
## library(supercells)
## library(regional)
## ndvi_sc = supercells(ndvi, k = 400, compactness = 0.2)


## ---- eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
## library(tmap)
## tm_shape(ndvi) +
##   tm_raster(style = "order") +
##   tm_shape(ndvi_sc) +
##   tm_borders()


## ----09-gis-24--------------------------------------------------------------------------------------------------------------------------------------------
data("cycle_hire", package = "spData")
points = cycle_hire[1:25, ]


## ----09-gis-25, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## library(osmdata)
## b_box = st_bbox(points)
## london_streets = opq(b_box) |>
##   add_osm_feature(key = "highway") |>
##   osmdata_sf()
## london_streets = london_streets[["osm_lines"]]
## london_streets = dplyr::select(london_streets, osm_id)


## ----09-gis-30, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## library(rgrass)
## link2GI::linkGRASS(london_streets, ver_select = TRUE)


## ----09-gis-31, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## write_VECT(terra::vect(london_streets), vname = "london_streets")
## write_VECT(terra::vect(points[, 1]), vname = "points")


## ----09-gis-32, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## execGRASS(cmd = "v.clean", input = "london_streets", output = "streets_clean",
##           tool = "break", flags = "overwrite")


## To learn about the possible arguments and flags of the GRASS GIS modules you can you the `help` flag.

## For example, try `execGRASS("g.region", flags = "help")`.


## ----09-gis-32b, eval=FALSE-------------------------------------------------------------------------------------------------------------------------------
## execGRASS(cmd = "v.net", input = "streets_clean", output = "streets_points_con",
##           points = "points", operation = "connect", threshold = 0.001,
##           flags = c("overwrite", "c"))


## ----09-gis-33, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## execGRASS(cmd = "v.net.salesman", input = "streets_points_con",
##           output = "shortest_route", center_cats = paste0("1-", nrow(points)),
##           flags = "overwrite")


## ----09-gis-34, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## route = read_VECT("shortest_route") |>
##   st_as_sf() |>
##   st_geometry()
## mapview::mapview(route) + points


## ----grass-mapview, fig.cap="Shortest route (blue line) between 24 cycle hire stations (blue dots) on the OSM street network of London.", fig.scap="Shortest route between 24 cycle hire stations.", echo=FALSE, out.width="80%"----
knitr::include_graphics("figures/10_shortest_route.png")


## ----09-gis-35, eval=FALSE, echo=FALSE--------------------------------------------------------------------------------------------------------------------
## library(mapview)
## m_1 = mapview(route) +  points
## mapview::mapshot(m_1,
##                  file = file.path(getwd(), "figures/09_shortest_route.png"),
##                  remove_controls = c("homeButton", "layersControl",
##                                      "zoomControl"))


## ----09-gis-27, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## library(link2GI)
## link = findGRASS()


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## library(rgrass)
## grass_path = link$instDir[[1]]
## initGRASS(gisBase = grass_path, gisDbase = tempdir(),
##           location = "london", mapset = "PERMANENT", override = TRUE)


## ----09-gis-29, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## execGRASS("g.proj", flags = c("c", "quiet"), srid = "EPSG:4326")
## b_box = st_bbox(london_streets)
## execGRASS("g.region", flags = c("quiet"),
##           n = as.character(b_box["ymax"]), s = as.character(b_box["ymin"]),
##           e = as.character(b_box["xmax"]), w = as.character(b_box["xmin"]),
##           res = "1")


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## link2GI::linkGDAL()


## ----09-gis-36, eval=FALSE, message=FALSE-----------------------------------------------------------------------------------------------------------------
## our_filepath = system.file("shapes/world.gpkg", package = "spData")
## cmd = paste("ogrinfo -al -so", our_filepath)
## system(cmd)
## #> INFO: Open of `.../spData/shapes/world.gpkg'
## #>       using driver `GPKG' successful.
## #>
## #> Layer name: world
## #> Geometry: Multi Polygon
## #> Feature Count: 177
## #> Extent: (-180.000000, -89.900000) - (179.999990, 83.645130)
## #> Layer SRS WKT:
## #> ...


## ----09-gis-37, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## library(RPostgreSQL)
## conn = dbConnect(drv = PostgreSQL(),
##                  dbname = "rtafdf_zljbqm", host = "db.qgiscloud.com",
##                  port = "5432", user = "rtafdf_zljbqm", password = "d3290ead")


## ----09-gis-38, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## dbListTables(conn)
## #> [1] "spatial_ref_sys" "topology"        "layer"           "restaurants"
## #> [5] "highways"


## ----09-gis-39, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## dbListFields(conn, "highways")
## #> [1] "qc_id"        "wkb_geometry" "gid"          "feature"
## #> [5] "name"         "state"


## ----09-gis-40, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## query = paste(
##   "SELECT *",
##   "FROM highways",
##   "WHERE name = 'US Route 1' AND state = 'MD';")
## us_route = read_sf(conn, query = query, geom = "wkb_geometry")


## ----09-gis-41, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## query = paste(
##   "SELECT ST_Union(ST_Buffer(wkb_geometry, 35000))::geometry",
##   "FROM highways",
##   "WHERE name = 'US Route 1' AND state = 'MD';")
## buf = read_sf(conn, query = query)


## ----09-gis-42, eval=FALSE, warning=FALSE-----------------------------------------------------------------------------------------------------------------
## query = paste(
##   "SELECT *",
##   "FROM restaurants r",
##   "WHERE EXISTS (",
##   "SELECT gid",
##   "FROM highways",
##   "WHERE",
##   "ST_DWithin(r.wkb_geometry, wkb_geometry, 35000) AND",
##   "name = 'US Route 1' AND",
##   "state = 'MD' AND",
##   "r.franchise = 'HDE');"
## )
## hardees = read_sf(conn, query = query)


## ----09-gis-43, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## RPostgreSQL::postgresqlCloseConnection(conn)


## ----09-gis-44, echo=FALSE--------------------------------------------------------------------------------------------------------------------------------
load("extdata/postgis_data.Rdata")


## ----postgis, echo=FALSE, fig.cap="Visualization of the output of previous PostGIS commands showing the highway (black line), a buffer (light yellow) and four restaurants (red points) within the buffer.", fig.scap="Visualization of the output of previous PostGIS commands."----
# plot the results of the queries
library(tmap)
tm_shape(buf) +
  tm_polygons(col = "#FFFDD0", border.alpha = 0.3) +
  tm_shape(us_route) +
  tm_lines(col = "black", lwd = 3) +
  tm_shape(hardees) +
  tm_symbols(col = "#F10C26") +
  tm_add_legend(type = "line", col = "black", lwd = 3,
                labels = "The US Route 1 highway") +
  tm_add_legend(type = "fill", col = "#FFFDD0",
                border.alpha = 0.3, label = "35km buffer") +
  tm_add_legend(type = "symbol", col = "#F10C26",
                labels = "Restaurants") +
  tm_layout(frame = FALSE,
            legend.outside = TRUE,
            legend.outside.size = 0.3) 


## ----09-stac-example, eval = FALSE------------------------------------------------------------------------------------------------------------------------
## library(rstac)
## # Connect to the STAC-API endpoint for Sentinel-2 data
## # and search for images intersecting our AOI
## s = stac("https://earth-search.aws.element84.com/v0")
## items = s |>
##   stac_search(collections = "sentinel-s2-l2a-cogs",
##               bbox = c(7.1, 51.8, 7.2, 52.8),
##               datetime = "2020-01-01/2020-12-31") |>
##   post_request() |> items_fetch()


## ----09-gdalcubes-example, eval = FALSE-------------------------------------------------------------------------------------------------------------------
## library(gdalcubes)
## # Filter images from STAC response by cloud cover
## # and create an image collection object
## collection = stac_image_collection(items$features,
##                   property_filter = function(x) {x[["eo:cloud_cover"]] < 10})
## # Define extent, resolution (250m, daily) and CRS of the target data cube
## v = cube_view(srs = "EPSG:3857", extent = collection, dx = 250, dy = 250,
##               dt = "P1D") # "P1D" is an ISO 8601 duration string
## # Create and process the data cube
## cube = raster_cube(collection, v) |>
##   select_bands(c("B04", "B08")) |>
##   apply_pixel("(B08-B04)/(B08+B04)", "NDVI") |>
##   reduce_time("max(NDVI)")
## # gdalcubes_options(parallel = 8)
## # plot(cube, zlim = c(0,1))


## ----09-openeo-example, eval=FALSE------------------------------------------------------------------------------------------------------------------------
## library(openeo)
## con = connect(host = "https://openeo.cloud")
## p = processes() # load available processes
## collections = list_collections() # load available collections
## formats = list_file_formats() # load available output formats
## # Load Sentinel-2 collection
## s2 = p$load_collection(id = "SENTINEL2_L2A",
##                        spatial_extent = list(west = 7.5, east = 8.5,
##                                              north = 51.1, south = 50.1),
##                        temporal_extent = list("2021-01-01", "2021-01-31"),
##                        bands = list("B04","B08"))
## # Compute NDVI vegetation index
## compute_ndvi = p$reduce_dimension(data = s2, dimension = "bands",
##                                   reducer = function(data, context) {
##                                     (data[2] - data[1]) / (data[2] + data[1])
##                                   })
## # Compute maximum over time
## reduce_max = p$reduce_dimension(data = compute_ndvi, dimension = "t",
##                                 reducer = function(x, y) {max(x)})
## # Export as GeoTIFF
## result = p$save_result(reduce_max, formats$output$GTiff)
## # Login, see https://docs.openeo.cloud/getting-started/r/#authentication
## login(login_type = "oidc",
##       provider = "egi",
##       config = list(
##         client_id= "...",
##         secret = "..."))
## # Execute processes
## compute_result(graph = result, output_file = tempfile(fileext = ".tif"))

