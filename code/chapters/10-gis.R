## ----gis-comp, echo = FALSE, message = FALSE-----------------------------
library(tidyverse)
d = tibble("GIS" = c("GRASS", "QGIS", "SAGA"),
            "first release" = c("1984", "2002", "2004"),
            "no. functions" = c(">500", ">1000", ">600"),
            "support" = c("hybrid", "hybrid", "hybrid"))
knitr::kable(x = d, caption = "Comparison between three open-source GIS. Hybrid refers to the support of vector and raster operations.") %>%
  kableExtra::add_footnote(label = "Comparing downloads of different providers is rather difficult (see [http://spatialgalaxy.net/2011/12/19/qgis-users-around-the-world/](http://spatialgalaxy.net/2011/12/19/qgis-users-around-the-world/)), and here also useless since every Windows QGIS download automatically also downloads SAGA and GRASS.", notation = "alphabet")

## ----qgis_setup, eval=FALSE----------------------------------------------
## library(RQGIS)
## set_env()
## open_app()

## ------------------------------------------------------------------------
library(spData)

## ---- eval=FALSE---------------------------------------------------------
## find_algorithms("points.*poly", name_only = TRUE)

## ---- eval=FALSE---------------------------------------------------------
## alg = "qgis:countpointsinpolygon"
## get_usage(alg)

## ---- eval=FALSE---------------------------------------------------------
## open_help(alg)

## ---- eval=FALSE---------------------------------------------------------
## bike_points = run_qgis(alg, POLYGONS = lnd, POINTS = cycle_hire, FIELD = "no_bikes",
##                        OUTPUT = "cycle.shp", load_output = TRUE)
## summary(bike_points$no_bikes)
## sum(bike_points$no_bikes > 0)

## ---- eval=FALSE---------------------------------------------------------
## get_args_man(alg)

## ---- warning=FALSE, message=FALSE, eval=FALSE---------------------------
## library(RSAGA)
## library(link2GI)
## saga = linkSAGA()
## rsaga.env()

## ---- eval=FALSE---------------------------------------------------------
## data(landslides)
## write.sgrd(data = dem, file = file.path(tempdir(), "dem"), header = dem$header)

## ---- eval=FALSE---------------------------------------------------------
## tail(rsaga.get.libraries(), 10)

## ---- eval=FALSE---------------------------------------------------------
## rsaga.get.modules(libs = "ta_hydrology")

## ---- eval=FALSE---------------------------------------------------------
## rsaga.get.usage(lib = "ta_hydrology", module = "SAGA Wetness Index")

## ---- eval=FALSE---------------------------------------------------------
## params = list(DEM = file.path(tempdir(), "dem.sgrd"),
##               TWI = file.path(tempdir(), "twi.sdat"))
## rsaga.geoprocessor(lib = "ta_hydrology", module = "SAGA Wetness Index",
##                    param = params)

## ---- eval=FALSE---------------------------------------------------------
## rsaga.wetness.index(in.dem = file.path(tempdir(), "dem"),
##                     out.wetness.index = file.path(tempdir(), "twi"))

## ----saga-twi, fig.cap = "SAGA wetness index of Mount Mongón, Peru.", eval=FALSE----
## library(raster)
## twi = raster::raster(file.path(tempdir(), "twi.sdat"))
## plot(twi, col = RColorBrewer::brewer.pal(n = 9, name = "Blues"))
## # or using mapview
## # proj4string(twi) = paste0("+proj=utm +zone=17 +south +ellps=WGS84 +towgs84=",
## #                           "0,0,0,0,0,0,0 +units=m +no_defs")
## # mapview(twi, col.regions = RColorBrewer::brewer.pal(n = 9, "Blues"),
## #         at = seq(cellStats(twi, "min") - 0.01, cellStats(twi, "max") + 0.01,
## #                  length.out = 9))

## ------------------------------------------------------------------------
library(spData)
data(cycle_hire)
points = cycle_hire[1:25, ]

## ------------------------------------------------------------------------
# plot(st_geometry(streets))
# plot(st_geometry(cycle_hire), col = "red", pch = 16, add = TRUE)

## ---- eval=FALSE---------------------------------------------------------
## library(sf)
## library(osmdata)
## 
## b_box = sf::st_bbox(cycle_hire)
## streets = opq(b_box) %>%
##   add_osm_feature(key = "highway") %>%
##   osmdata_sf() %>%
##   `[[`(., "osm_lines")

## ------------------------------------------------------------------------
library(link2GI)
link = findGRASS() 

## ---- eval=FALSE---------------------------------------------------------
## library(rgrass7)
## # find a GRASS7 installation, and use the first one
## ind = grep("7", link$version)[1]
## # next line of code only necessary if we want to use GRASS as installed by
## # OSGeo4W. Among others, this adds some paths to PATH, which are also needed
## # for running GRASS.
## link2GI::paramGRASSw(link[ind, ])
## grass_path = ifelse(!is.null(link$installation_type) &&
##                       link$installation_type[ind] == "osgeo4W",
##                     file.path(link$instDir[ind], "apps/grass", link$version[ind]),
##                     link$instDir)
## initGRASS(gisBase = grass_path,
##           # home parameter necessary under UNIX-based systems
##           home = tempdir(),
##           gisDbase = tempdir(), location = "london",
##           mapset = "PERMANENT", override = TRUE)

## ---- eval=FALSE---------------------------------------------------------
## execGRASS("g.proj", flags = c("c", "quiet"),
##           proj4 = sf::st_crs(streets)$proj4string)
## b_box = sf::st_bbox(streets)
## execGRASS("g.region", flags = c("quiet"),
##           n = as.character(b_box["ymax"]), s = as.character(b_box["ymin"]),
##           e = as.character(b_box["xmax"]), w = as.character(b_box["xmin"]),
##           res = "1")

## ---- eval=FALSE---------------------------------------------------------
## link2GI::linkGRASS7(streets, ver_select = TRUE)

## ---- eval=FALSE---------------------------------------------------------
## writeVECT(as(streets[, 1], "Spatial"), vname = "streets")
## writeVECT(SDF = as(points[, 1], "Spatial"), vname = "points")

## ---- eval=FALSE---------------------------------------------------------
## execGRASS(cmd = "v.clean", input = "streets", output = "streets_clean",
##           tool = "break", flags = "overwrite")
## execGRASS(cmd = "v.net", input = "streets_clean", output = "streets_points_con",
##           points = "points", operation = "connect", threshold = 0.001,
##           flags = c("overwrite", "c"))

## ---- eval=FALSE---------------------------------------------------------
## execGRASS(cmd = "v.net.salesman", input = "streets_points_con",
##           output = "shortest_route", center_cats = paste0("1-", nrow(points)),
##           flags = c("overwrite"))

## ----grass_mapview, fig.cap = "Shortest route between 25 cycle hire station on the OSM street network of London.", eval=FALSE----
## library(mapview)
## route = readVECT("shortest_route")
## mapview(route) +
##   mapview(points)

