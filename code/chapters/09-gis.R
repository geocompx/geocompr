## ---- message=FALSE------------------------------------------------------
library(sf)
library(raster)
library(dplyr)
library(spData)
library(RQGIS)
library(RSAGA)
library(rgrass7)
library(tmap)

## ----gis-comp, echo=FALSE, message=FALSE---------------------------------
library(tidyverse)
d = tibble("GIS" = c("GRASS", "QGIS", "SAGA"),
            "first release" = c("1984", "2002", "2004"),
            "no. functions" = c(">500", ">1000", ">600"),
            "support" = c("hybrid", "hybrid", "hybrid"))
knitr::kable(x = d, caption = "Comparison between three open-source GIS. Hybrid refers to the support of vector and raster operations.") %>%
  kableExtra::add_footnote(label = "Comparing downloads of different providers is rather difficult (see [http://spatialgalaxy.net/2011/12/19/qgis-users-around-the-world/](http://spatialgalaxy.net/2011/12/19/qgis-users-around-the-world/)), and here also useless since every Windows QGIS download automatically also downloads SAGA and GRASS.", notation = "alphabet")

## ----qgis_setup, eval=FALSE----------------------------------------------
## devtools::install_github("jannes-m/RQGIS") # use dev version (for now)
## library(RQGIS)
## set_env(dev = FALSE)
## 
## #> $`root`
## #> [1] "C:/OSGeo4W64"
## #> $qgis_prefix_path
## #> [1] "C:/OSGeo4W64/apps/qgis-ltr"
## #> $python_plugins
## #> [1] "C:/OSGeo4W64/apps/qgis-ltr/python/plugins"

## ---- eval=FALSE---------------------------------------------------------
## open_app()

## ------------------------------------------------------------------------
data("incongruent", package = "spData")
data("aggregating_zones", package = "spData")
incongruent = st_transform(incongruent, 4326)
aggregating_zones = st_transform(aggregating_zones, 4326)

## ---- eval=FALSE---------------------------------------------------------
## find_algorithms("union", name_only = TRUE)
## #> [1] "qgis:union"        "saga:fuzzyunionor" "saga:union"

## ---- eval=FALSE---------------------------------------------------------
## alg = "qgis:union"
## open_help(alg)
## get_usage(alg)
## #>ALGORITHM: Union
## #>	INPUT <ParameterVector>
## #>	INPUT2 <ParameterVector>
## #>	OUTPUT <OutputVector>

## ---- eval=FALSE---------------------------------------------------------
## union = run_qgis(alg, INPUT = incongruent, INPUT2 = aggregating_zones,
##                  OUTPUT = file.path(tempdir(), "union.shp"),
##                  load_output = TRUE)
## #> $`OUTPUT`
## #> [1] "C:/Users/pi37pat/AppData/Local/Temp/RtmpcJlnUx/union.shp"

## ---- eval=FALSE---------------------------------------------------------
## # remove empty geometries
## union = union[!is.na(st_dimension(union)), ]

## ---- eval=FALSE, message=FALSE, warning=FALSE---------------------------
## # multipart polygons to single polygons
## single = st_cast(union, "POLYGON")

## ---- eval=FALSE---------------------------------------------------------
## single$area = st_area(single)
## # find polygons which are smaller than 25000 m^2
## x = 25000
## units(x) = "m^2"
## sub = dplyr::filter(single, area < x)
## tm_shape(single) +
##   tm_borders() +
##   tm_shape(sub) +
##   tm_fill(col = "blue") +
##   tm_borders(col = "blue", lwd = 1.5)

## ---- eval=FALSE---------------------------------------------------------
## find_algorithms("sliver", name_only = TRUE)
## #> [1] "qgis:eliminatesliverpolygons"

## ---- eval=FALSE---------------------------------------------------------
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

## ---- eval=FALSE---------------------------------------------------------
## clean = run_qgis("qgis:eliminatesliverpolygons",
##                  INPUT = single,
##                  ATTRIBUTE = "area",
##                  COMPARISON = "<=",
##                  COMPARISONVALUE = 25000,
##                  OUTPUT = file.path(tempdir(), "clean.shp"),
##                  load_output = TRUE)
## #> $`OUTPUT`
## #> [1] "C:/Users/pi37pat/AppData/Local/Temp/RtmpcJlnUx/clean.shp"

## ----sliver-fig, echo=FALSE, fig.cap="Sliver polygons colored in blue (left panel). Cleaned polygons (right panel)."----
knitr::include_graphics("figures/09_sliver.png")

## ---- warning=FALSE, message=FALSE, eval=FALSE---------------------------
## library(RSAGA)
## rsaga.env()

## ---- warning=FALSE, message=FALSE, eval=FALSE---------------------------
## library(link2GI)
## saga = linkSAGA()
## rsaga.env()

## ---- eval=FALSE---------------------------------------------------------
## data(landslides)
## write.sgrd(data = dem, file = file.path(tempdir(), "dem"), header = dem$header)

## ---- eval=FALSE---------------------------------------------------------
## rsaga.get.libraries()

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

## ----saga-twi, fig.cap="SAGA wetness index of Mount Mongón, Peru.", echo=FALSE----
knitr::include_graphics("figures/09_twi.png")

## ---- eval=FALSE---------------------------------------------------------
## library(raster)
## twi = raster::raster(file.path(tempdir(), "twi.sdat"))
## # shown is a version using tmap
## plot(twi, col = RColorBrewer::brewer.pal(n = 9, name = "Blues"))

## ---- include=FALSE------------------------------------------------------
# or using mapview
# proj4string(twi) = paste0("+proj=utm +zone=17 +south +ellps=WGS84 +towgs84=", 
#                           "0,0,0,0,0,0,0 +units=m +no_defs")
# mapview(twi, col.regions = RColorBrewer::brewer.pal(n = 9, "Blues"), 
#         at = seq(cellStats(twi, "min") - 0.01, cellStats(twi, "max") + 0.01, 
#                  length.out = 9))

## ------------------------------------------------------------------------
data("cycle_hire", package = "spData")
points = cycle_hire[1:25, ]

## ---- eval=FALSE---------------------------------------------------------
## library(sf)
## library(osmdata)
## b_box = sf::st_bbox(cycle_hire)
## london_streets = opq(b_box) %>%
##   add_osm_feature(key = "highway") %>%
##   osmdata_sf() %>%
##   `[[`("osm_lines")
## london_streets = dplyr::select(london_streets, 1)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## data("london_streets", package = "spDataLarge")

## ---- eval=FALSE---------------------------------------------------------
## library(link2GI)
## link = findGRASS()

## ---- eval=FALSE---------------------------------------------------------
## library(rgrass7)
## # find a GRASS7 installation, and use the first one
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

## ---- eval=FALSE---------------------------------------------------------
## execGRASS("g.proj", flags = c("c", "quiet"),
##           proj4 = sf::st_crs(london_streets)$proj4string)
## b_box = sf::st_bbox(london_streets)
## execGRASS("g.region", flags = c("quiet"),
##           n = as.character(b_box["ymax"]), s = as.character(b_box["ymin"]),
##           e = as.character(b_box["xmax"]), w = as.character(b_box["xmin"]),
##           res = "1")

## ---- eval=FALSE---------------------------------------------------------
## link2GI::linkGRASS7(london_streets, ver_select = TRUE)

## ---- eval=FALSE---------------------------------------------------------
## writeVECT(SDF = as(london_streets, "Spatial"), vname = "london_streets")
## writeVECT(SDF = as(points[, 1], "Spatial"), vname = "points")

## ---- eval=FALSE---------------------------------------------------------
## execGRASS(cmd = "v.clean", input = "london_streets", output = "streets_clean",
##           tool = "break", flags = "overwrite")
## execGRASS(cmd = "v.net", input = "streets_clean", output = "streets_points_con",
##           points = "points", operation = "connect", threshold = 0.001,
##           flags = c("overwrite", "c"))

## ---- eval=FALSE---------------------------------------------------------
## execGRASS(cmd = "v.net.salesman", input = "streets_points_con",
##           output = "shortest_route", center_cats = paste0("1-", nrow(points)),
##           flags = c("overwrite"))

## ----grass-mapview, fig.cap="Shortest route between 25 cycle hire station on the OSM street network of London.", echo=FALSE----
knitr::include_graphics("figures/09_shortest_route.png")

## ---- eval=FALSE---------------------------------------------------------
## library(mapview)
## route = readVECT("shortest_route") %>%
##   st_as_sf %>%
##   st_geometry
## mapview(route, map.types = "OpenStreetMap.BlackAndWhite", lwd = 7) +
##   mapview(points)

