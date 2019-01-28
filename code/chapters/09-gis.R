## ----09-gis-1, message=FALSE---------------------------------------------
library(sf)
library(raster)
library(RQGIS)
library(RSAGA)
library(rgrass7)

## A command-line interface is a means of interacting with computer programs in which the user issues commands via successive lines of text (command lines).

## ----gis-comp, echo=FALSE, message=FALSE---------------------------------
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
             booktabs = TRUE) #%>%
  # kableExtra::add_footnote(label = "Comparing downloads of different providers is rather difficult (see http://spatialgalaxy.net/2011/12/19/qgis-users-around-the-world), and here also useless since every Windows QGIS download automatically also downloads SAGA and GRASS.", notation = "alphabet")

## ----qgis_setup, eval=FALSE----------------------------------------------
## library(RQGIS)
## set_env(dev = FALSE)
## #> $`root`
## #> [1] "C:/OSGeo4W64"
## #> ...

## ----09-gis-3, eval=FALSE------------------------------------------------
## open_app()

## ----09-gis-4------------------------------------------------------------
data("incongruent", "aggregating_zones", package = "spData")
incongr_wgs = st_transform(incongruent, 4326)
aggzone_wgs = st_transform(aggregating_zones, 4326)

## ----09-gis-5, eval=FALSE------------------------------------------------
## find_algorithms("union", name_only = TRUE)
## #> [1] "qgis:union"        "saga:fuzzyunionor" "saga:union"

## ----09-gis-6, eval=FALSE------------------------------------------------
## alg = "qgis:union"
## open_help(alg)
## get_usage(alg)
## #>ALGORITHM: Union
## #>	INPUT <ParameterVector>
## #>	INPUT2 <ParameterVector>
## #>	OUTPUT <OutputVector>

## ----09-gis-7, eval=FALSE------------------------------------------------
## union = run_qgis(alg, INPUT = incongr_wgs, INPUT2 = aggzone_wgs,
##                  OUTPUT = file.path(tempdir(), "union.shp"),
##                  load_output = TRUE)
## #> $`OUTPUT`
## #> [1] "C:/Users/geocompr/AppData/Local/Temp/RtmpcJlnUx/union.shp"

## ----09-gis-8, eval=FALSE------------------------------------------------
## # remove empty geometries
## union = union[!is.na(st_dimension(union)), ]

## ----09-gis-9, eval=FALSE, message=FALSE, warning=FALSE------------------
## # multipart polygons to single polygons
## single = st_cast(union, "POLYGON")

## ----09-gis-10, eval=FALSE-----------------------------------------------
## # find polygons which are smaller than 25000 m^2
## x = 25000
## units(x) = "m^2"
## single$area = st_area(single)
## sub = dplyr::filter(single, area < x)

## ----09-gis-11, eval=FALSE-----------------------------------------------
## find_algorithms("sliver", name_only = TRUE)
## #> [1] "qgis:eliminatesliverpolygons"

## ----09-gis-12, eval=FALSE-----------------------------------------------
## alg = "qgis:eliminatesliverpolygons"
## get_usage(alg)
## #>ALGORITHM: Eliminate sliver polygons
## #>	INPUT <ParameterVector>
## #>	KEEPSELECTION <ParameterBoolean>
## #>	ATTRIBUTE <parameters from INPUT>
## #>	COMPARISON <ParameterSelection>
## #>	COMPARISONVALUE <ParameterString>
## #>	MODE <ParameterSelection>
## #>	OUTPUT <OutputVector>
## #>	...

## ----09-gis-13, eval=FALSE-----------------------------------------------
## clean = run_qgis("qgis:eliminatesliverpolygons",
##                  INPUT = single,
##                  ATTRIBUTE = "area",
##                  COMPARISON = "<=",
##                  COMPARISONVALUE = 25000,
##                  OUTPUT = file.path(tempdir(), "clean.shp"),
##                  load_output = TRUE)
## #> $`OUTPUT`
## #> [1] "C:/Users/geocompr/AppData/Local/Temp/RtmpcJlnUx/clean.shp"

## ----sliver-fig, echo=FALSE, fig.cap="Sliver polygons colored in blue (left panel). Cleaned polygons (right panel).", fig.scap="Sliver (left panel) and cleaned (right panel) polygons."----
knitr::include_graphics("figures/09_sliver.png")

## ----09-gis-14, warning=FALSE, message=FALSE, eval=FALSE-----------------
## library(RSAGA)
## rsaga.env()

## ----09-gis-15, warning=FALSE, message=FALSE, eval=FALSE-----------------
## library(link2GI)
## saga = linkSAGA()
## rsaga.env()

## ----09-gis-16, eval=FALSE-----------------------------------------------
## data(landslides)
## write.sgrd(data = dem, file = file.path(tempdir(), "dem"), header = dem$header)

## ----09-gis-17, eval=FALSE-----------------------------------------------
## rsaga.get.libraries()

## ----09-gis-18, eval=FALSE-----------------------------------------------
## rsaga.get.modules(libs = "ta_hydrology")

## ----09-gis-19, eval=FALSE-----------------------------------------------
## rsaga.get.usage(lib = "ta_hydrology", module = "SAGA Wetness Index")

## ----09-gis-20, eval=FALSE-----------------------------------------------
## params = list(DEM = file.path(tempdir(), "dem.sgrd"),
##               TWI = file.path(tempdir(), "twi.sdat"))
## rsaga.geoprocessor(lib = "ta_hydrology", module = "SAGA Wetness Index",
##                    param = params)

## ----09-gis-21, eval=FALSE-----------------------------------------------
## rsaga.wetness.index(in.dem = file.path(tempdir(), "dem"),
##                     out.wetness.index = file.path(tempdir(), "twi"))

## ----09-gis-22, eval=FALSE-----------------------------------------------
## library(raster)
## twi = raster::raster(file.path(tempdir(), "twi.sdat"))
## # shown is a version using tmap
## plot(twi, col = RColorBrewer::brewer.pal(n = 9, name = "Blues"))

## ----saga-twi, fig.cap="SAGA wetness index of Mount Mongón, Peru.", echo=FALSE, out.width="50%"----
knitr::include_graphics("figures/09_twi.png")

## ----09-gis-23, include=FALSE--------------------------------------------
# or using mapview
# proj4string(twi) = paste0("+proj=utm +zone=17 +south +ellps=WGS84 +towgs84=", 
#                           "0,0,0,0,0,0,0 +units=m +no_defs")
# mapview(twi, col.regions = RColorBrewer::brewer.pal(n = 9, "Blues"), 
#         at = seq(cellStats(twi, "min") - 0.01, cellStats(twi, "max") + 0.01, 
#                  length.out = 9))

## ----09-gis-24-----------------------------------------------------------
data("cycle_hire", package = "spData")
points = cycle_hire[1:25, ]

## ----09-gis-25, eval=FALSE-----------------------------------------------
## library(osmdata)
## b_box = st_bbox(points)
## london_streets = opq(b_box) %>%
##   add_osm_feature(key = "highway") %>%
##   osmdata_sf() %>%
##   `[[`("osm_lines")
## london_streets = dplyr::select(london_streets, osm_id)

## ----09-gis-26, eval=FALSE, echo=FALSE-----------------------------------
## data("london_streets", package = "spDataLarge")

## ----09-gis-27, eval=FALSE-----------------------------------------------
## library(link2GI)
## link = findGRASS()

## ----09-gis-28, eval=FALSE-----------------------------------------------
## library(rgrass7)
## # find a GRASS 7 installation, and use the first one
## ind = grep("7", link$version)[1]
## # next line of code only necessary if we want to use GRASS as installed by
## # OSGeo4W. Among others, this adds some paths to PATH, which are also needed
## # for running GRASS.
## link2GI::paramGRASSw(link[ind, ])
## grass_path =
##   ifelse(test = !is.null(link$installation_type) &&
##            link$installation_type[ind] == "osgeo4W",
##          yes = file.path(link$instDir[ind], "apps/grass", link$version[ind]),
##          no = link$instDir)
## initGRASS(gisBase = grass_path,
##           # home parameter necessary under UNIX-based systems
##           home = tempdir(),
##           gisDbase = tempdir(), location = "london",
##           mapset = "PERMANENT", override = TRUE)

## ----09-gis-29, eval=FALSE-----------------------------------------------
## execGRASS("g.proj", flags = c("c", "quiet"),
##           proj4 = st_crs(london_streets)$proj4string)
## b_box = st_bbox(london_streets)
## execGRASS("g.region", flags = c("quiet"),
##           n = as.character(b_box["ymax"]), s = as.character(b_box["ymin"]),
##           e = as.character(b_box["xmax"]), w = as.character(b_box["xmin"]),
##           res = "1")

## ----09-gis-30, eval=FALSE-----------------------------------------------
## link2GI::linkGRASS7(london_streets, ver_select = TRUE)

## ----09-gis-31, eval=FALSE-----------------------------------------------
## writeVECT(SDF = as(london_streets, "Spatial"), vname = "london_streets")
## writeVECT(SDF = as(points[, 1], "Spatial"), vname = "points")

## ----09-gis-32, eval=FALSE-----------------------------------------------
## # clean street network
## execGRASS(cmd = "v.clean", input = "london_streets", output = "streets_clean",
##           tool = "break", flags = "overwrite")
## # connect points with street network
## execGRASS(cmd = "v.net", input = "streets_clean", output = "streets_points_con",
##           points = "points", operation = "connect", threshold = 0.001,
##           flags = c("overwrite", "c"))

## ----09-gis-33, eval=FALSE-----------------------------------------------
## execGRASS(cmd = "v.net.salesman", input = "streets_points_con",
##           output = "shortest_route", center_cats = paste0("1-", nrow(points)),
##           flags = c("overwrite"))

## ----grass-mapview, fig.cap="Shortest route (blue line) between 24 cycle hire stations (blue dots) on the OSM street network of London.", fig.scap="Shortest route between 24 cycle hire stations.", echo=FALSE, out.width="80%"----
knitr::include_graphics("figures/09_shortest_route.png")

## ----09-gis-34, eval=FALSE-----------------------------------------------
## route = readVECT("shortest_route") %>%
##   st_as_sf() %>%
##   st_geometry()
## mapview::mapview(route, map.types = "OpenStreetMap.BlackAndWhite", lwd = 7) +
##   points

## ----09-gis-35, eval=FALSE, echo=FALSE-----------------------------------
## library("mapview")
## m_1 = mapview(route, map.types = "OpenStreetMap.BlackAndWhite", lwd = 7) +
##   points
## mapview::mapshot(m_1,
##                  file = file.path(getwd(), "figures/09_shortest_route.png"),
##                  remove_controls = c("homeButton", "layersControl",
##                                      "zoomControl"))

## ----09-gis-36, eval=FALSE, message=FALSE--------------------------------
## link2GI::linkGDAL()
## cmd = paste("ogrinfo -ro -so -al", system.file("shape/nc.shp", package = "sf"))
## system(cmd)
## #> INFO: Open of `C:/Users/geocompr/Documents/R/win-library/3.5/sf/shape/nc.shp'
## #>     using driver `ESRI Shapefile' successful.
## #>
## #> Layer name: nc
## #> Metadata:
## #>  DBF_DATE_LAST_UPDATE=2016-10-26
## #> Geometry: Polygon
## #> Feature Count: 100
## #> Extent: (-84.323853, 33.881992) - (-75.456978, 36.589649)
## #> Layer SRS WKT:
## #> ...

## ----09-gis-37, eval=FALSE-----------------------------------------------
## library(RPostgreSQL)
## conn = dbConnect(drv = PostgreSQL(), dbname = "rtafdf_zljbqm",
##                  host = "db.qgiscloud.com",
##                  port = "5432", user = "rtafdf_zljbqm",
##                  password = "d3290ead")

## ----09-gis-38, eval=FALSE-----------------------------------------------
## dbListTables(conn)
## #> [1] "spatial_ref_sys" "topology"        "layer"           "restaurants"
## #> [5] "highways"

## ----09-gis-39, eval=FALSE-----------------------------------------------
## dbListFields(conn, "highways")
## #> [1] "qc_id"        "wkb_geometry" "gid"          "feature"
## #> [5] "name"         "state"

## ----09-gis-40, eval=FALSE-----------------------------------------------
## query = paste(
##   "SELECT *",
##   "FROM highways",
##   "WHERE name = 'US Route 1' AND state = 'MD';")
## us_route = st_read(conn, query = query, geom = "wkb_geometry")

## ----09-gis-41, eval=FALSE-----------------------------------------------
## query = paste(
##   "SELECT ST_Union(ST_Buffer(wkb_geometry, 1609 * 20))::geometry",
##   "FROM highways",
##   "WHERE name = 'US Route 1' AND state = 'MD';")
## buf = st_read(conn, query = query)

## ----09-gis-42, eval=FALSE, warning=FALSE--------------------------------
## query = paste(
##   "SELECT r.wkb_geometry",
##   "FROM restaurants r",
##   "WHERE EXISTS (",
##   "SELECT gid",
##   "FROM highways",
##   "WHERE",
##   "ST_DWithin(r.wkb_geometry, wkb_geometry, 1609 * 20) AND",
##   "name = 'US Route 1' AND",
##   "state = 'MD' AND",
##   "r.franchise = 'HDE');"
## )
## hardees = st_read(conn, query = query)

## ----09-gis-43, eval=FALSE-----------------------------------------------
## RPostgreSQL::postgresqlCloseConnection(conn)

## ----09-gis-44, echo=FALSE-----------------------------------------------
load("extdata/postgis_data.Rdata")

## ----postgis, echo=FALSE, fig.cap="Visualization of the output of previous PostGIS commands showing the highway (black line), a buffer (light yellow) and three restaurants (light blue points) within the buffer.", fig.scap="Visualization of the output of previous PostGIS commands.", out.width="60%"----
# plot the results of the queries
par(mar = rep(0, 4))
plot(buf$st_union, col = "lightyellow")
plot(st_geometry(us_route), add = TRUE, lwd = 2)
plot(st_geometry(hardees), pch = 21, cex = 1.5,
     bg = "lightblue", fill = "black", add = TRUE)

