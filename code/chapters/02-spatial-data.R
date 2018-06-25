## ---- eval=FALSE---------------------------------------------------------
## install.packages("sf")

## On Mac and Linux a few requirements must be met to install **sf**.

## ---- eval=FALSE---------------------------------------------------------
## install.packages("raster")
## install.packages("spData")
## install.packages("spDataLarge", repos = "https://nowosad.github.io/drat/",
##                  type = "source")

## ---- message=FALSE------------------------------------------------------
library(sf)          # classes and functions for vector data
library(raster)      # classes and functions for raster data

## ---- results='hide'-----------------------------------------------------
library(spData)        # load geographic data
library(spDataLarge)   # load larger geographic data

## Take care when using the word 'vector' as it can have two meanings in this book:

## ----vectorplots-source, include=FALSE, eval=FALSE-----------------------
## source("code/02-vectorplots.R") # generate subsequent figure

## ----vectorplots, fig.cap="Illustration of vector (point) data in which location of London (the red X) is represented with reference to an origin (the blue circle). The left plot represents a geographic CRS with an origin at 0° longitude and latitude. The right plot represents a projected CRS with an origin located in the sea west of the South West Peninsula.", out.width="49%", fig.show='hold', echo=FALSE----
knitr::include_graphics(c("figures/vector_lonlat.png", "figures/vector_projected.png"))

## ----sf-ogc, fig.cap="The subset of the Simple Features class hierarchy supported by sf.", out.width="100%", echo=FALSE----
knitr::include_graphics("figures/sf-classes.png")

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## vignette("sf1") # for an introduction to the package
## vignette("sf2") # for reading, writing and converting Simple Features
## vignette("sf3") # for manipulating Simple Features

## ------------------------------------------------------------------------
names(world)

## ----world-all, fig.cap="A spatial plot of the world using the sf package, with a facet for each attribute.", warning=FALSE----
plot(world)

## ------------------------------------------------------------------------
summary(world["lifeExp"])

## The word `MULTIPOLYGON` in the summary output above refers to the geometry type of features (countries) in the `world` object.

## ------------------------------------------------------------------------
world[1:2, 1:3]

## ---- eval=FALSE---------------------------------------------------------
## library(sp)
## world_sp = as(world, Class = "Spatial")
## # sp functions ...

## ---- eval=FALSE---------------------------------------------------------
## world_sf = st_as_sf(world_sp, "sf")

## ----sfplot, fig.cap="Plotting with sf, with multiple variables (left) and a single variable (right).", out.width="49%", fig.show='hold', warning=FALSE----
plot(world[3:4])
plot(world["pop"])

## ---- warning=FALSE------------------------------------------------------
asia = world[world$continent == "Asia", ]
asia = st_union(asia)

## ----asia, out.width='50%', fig.cap="A plot of Asia added as a layer on top of countries worldwide."----
plot(world["pop"], reset = FALSE)
plot(asia, add = TRUE, col = "red")

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## plot(africa[0], lwd = 3, main = "Nigeria in context", border = "lightgrey")

## ---- eval=FALSE---------------------------------------------------------
## plot(world["continent"], reset = FALSE)
## cex = sqrt(world$pop) / 10000
## plot(st_geometry(world_centroids), add = TRUE, cex = cex)

## ----contpop, fig.cap="Country continents (represented by fill color) and 2015 populations (represented by points, with point area proportional to population) worldwide.", echo=FALSE, warning=FALSE----
source("code/02-contpop.R")

## ----sfcs, echo=FALSE, fig.cap="Illustration of point, linestring and polygon geometries."----
old_par = par(mfrow = c(1, 3), pty = "s", mar = c(0, 3, 1, 0))
plot(st_as_sfc(c("POINT(5 2)")), axes = TRUE, main = "POINT")
plot(st_as_sfc("LINESTRING(1 5, 4 4, 4 1, 2 2, 3 2)"), axes = TRUE, main = "LINESTRING")
plot(st_as_sfc("POLYGON((1 5, 2 2, 4 1, 4 4, 1 5))"), col="gray", axes = TRUE, main = "POLYGON")
par(old_par)

## ----polygon_hole, echo=FALSE, out.width="30%", eval=FALSE---------------
## # not printed - enough of these figures already (RL)
## par(pty = "s")
## plot(st_as_sfc("POLYGON((1 5, 2 2, 4 1, 4 4, 1 5), (2 4, 3 4, 3 3, 2 3, 2 4))"), col="gray", axes = TRUE, main = "POLYGON with a hole")

## ----multis, echo=FALSE, fig.cap="Illustration of multipoint, mutlilinestring and multipolygon geometries."----
old_par = par(mfrow = c(1, 3), pty = "s", mar = c(0, 3, 1, 0))
plot(st_as_sfc("MULTIPOINT (5 2, 1 3, 3 4, 3 2)"), axes = TRUE, main = "MULTIPOINT")
plot(st_as_sfc("MULTILINESTRING ((1 5, 4 4, 4 1, 2 2, 3 2), (1 2, 2 4))"), axes = TRUE, main = "MULTILINESTRING")
plot(st_as_sfc("MULTIPOLYGON (((1 5, 2 2, 4 1, 4 4, 1 5), (0 2, 1 2, 1 3, 0 3, 0 2)))"), col="gray", axes = TRUE, main = "MULTIPOLYGON")
par(old_par)

## ----geom_collection, echo=FALSE, out.width="30%", eval=FALSE------------
## # Again not plotted - adds little (RL)
## par(pty = "s")
## plot(st_as_sfc("GEOMETRYCOLLECTION (MULTIPOINT (5 2, 1 3, 3 4, 3 2), LINESTRING (1 5, 4 4, 4 1, 2 2, 3 2)))"),
##      axes = TRUE, main = "GEOMETRYCOLLECTION")

## ------------------------------------------------------------------------
# note that we use a numeric vector for points
st_point(c(5, 2)) # XY point
st_point(c(5, 2, 3)) # XYZ point
st_point(c(5, 2, 1), dim = "XYM") # XYM point
st_point(c(5, 2, 3, 1)) # XYZM point

## ------------------------------------------------------------------------
# the rbind function simplifies the creation of matrices
## MULTIPOINT
multipoint_matrix = rbind(c(5, 2), c(1, 3), c(3, 4), c(3, 2))
st_multipoint(multipoint_matrix)
## LINESTRING
linestring_matrix = rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2))
st_linestring(linestring_matrix)

## ------------------------------------------------------------------------
## POLYGON
polygon_list = list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5)))
st_polygon(polygon_list)

## ------------------------------------------------------------------------
## POLYGON with a hole
polygon_border = rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5))
polygon_hole = rbind(c(2, 4), c(3, 4), c(3, 3), c(2, 3), c(2, 4))
polygon_with_hole_list = list(polygon_border, polygon_hole)
st_polygon(polygon_with_hole_list)

## ------------------------------------------------------------------------
## MULTILINESTRING
multilinestring_list = list(rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2)), 
                            rbind(c(1, 2), c(2, 4)))
st_multilinestring((multilinestring_list))

## ------------------------------------------------------------------------
## MULTIPOLYGON
multipolygon_list = list(list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5))),
                         list(rbind(c(0, 2), c(1, 2), c(1, 3), c(0, 3), c(0, 2))))
st_multipolygon(multipolygon_list)

## ------------------------------------------------------------------------
## GEOMETRYCOLLECTION
gemetrycollection_list = list(st_multipoint(multipoint_matrix),
                              st_linestring(linestring_matrix))
st_geometrycollection(gemetrycollection_list)

## ------------------------------------------------------------------------
# sfc POINT
point1 = st_point(c(5, 2))
point2 = st_point(c(1, 3))
st_sfc(point1, point2)

## ------------------------------------------------------------------------
# sfc POLYGON
polygon_list1 = list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5)))
polygon1 = st_polygon(polygon_list1)
polygon_list2 = list(rbind(c(0, 2), c(1, 2), c(1, 3), c(0, 3), c(0, 2)))
polygon2 = st_polygon(polygon_list2)
st_sfc(polygon1, polygon2)

## ------------------------------------------------------------------------
# sfc MULTILINESTRING
multilinestring_list1 = list(rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2)), 
                            rbind(c(1, 2), c(2, 4)))
multilinestring1 = st_multilinestring((multilinestring_list1))
multilinestring_list2 = list(rbind(c(2, 9), c(7, 9), c(5, 6), c(4, 7), c(2, 7)), 
                            rbind(c(1, 7), c(3, 8)))
multilinestring2 = st_multilinestring((multilinestring_list2))
st_sfc(multilinestring1, multilinestring2)

## ------------------------------------------------------------------------
# sfc GEOMETRY
st_sfc(point1, multilinestring1)

## ------------------------------------------------------------------------
st_sfc(point1, point2)

## ------------------------------------------------------------------------
# EPSG definition
st_sfc(point1, point2, crs = 4326)

## ------------------------------------------------------------------------
# PROJ4STRING definition
st_sfc(point1, point2, crs = "+proj=longlat +datum=WGS84 +no_defs")

## ------------------------------------------------------------------------
st_sfc(point1, point2, crs = 2955)

## ------------------------------------------------------------------------
crs_utm = "+proj=utm +zone=11 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
st_sfc(point1, point2, crs = crs_utm)

## ------------------------------------------------------------------------
# sfg objects
london_point = st_point(c(0.1, 51.5))
ruan_point = st_point(c(-9, 53))
# sfc object
our_geometry = st_sfc(london_point, ruan_point, crs = 4326)
# data.frame object
our_attributes = data.frame(name = c("London", "Ruan"),
                            temperature = c(25, 13),
                            date = c(as.Date("2017-06-21"), as.Date("2017-06-22")),
                            category = c("city", "village"),
                            automatic = c(FALSE, TRUE))
# sf object
sf_points = st_sf(our_attributes, geometry = our_geometry)

## ------------------------------------------------------------------------
sf_points

## ------------------------------------------------------------------------
class(sf_points)

## ----raster-intro-plot, echo = FALSE, fig.cap = "Raster data: A - cell IDs; B - cell values; C - a colored raster map."----
source("code/02_raster_intro_plot.R")

## ----raster-intro-plot2, echo=FALSE, fig.cap="Examples of continuous (left) and categorical (right) raster."----
source("code/02_raster_intro_plot2.R")

## ---- message=FALSE------------------------------------------------------
raster_filepath = system.file("raster/srtm.tif", package = "spDataLarge")
new_raster = raster(raster_filepath)

## ------------------------------------------------------------------------
new_raster

## ------------------------------------------------------------------------
# numerical summary of the data
summary(new_raster)

## ----new_raster-hist-----------------------------------------------------
# histogram of the values
hist(new_raster)

## ------------------------------------------------------------------------
new_raster_values = getValues(new_raster)
head(new_raster_values)

## ------------------------------------------------------------------------
inMemory(new_raster)

## The **raster** package is not yet fully compatible with objects from the **sf** package.

## ----basic-new-raster-plot-----------------------------------------------
plot(new_raster)

## ------------------------------------------------------------------------
raster_filepath = system.file("raster/srtm.tif", package = "spDataLarge")
new_raster = raster(raster_filepath)

## ------------------------------------------------------------------------
new_raster2 = raster(nrow = 6, ncol = 6, res = 0.5, 
                     xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
                     vals = 1:36)

## ---- eval=FALSE---------------------------------------------------------
## # adding random values to the raster object
## new_random_values = sample(seq_len(ncell(new_raster4)))
## setValues(new_raster4, new_random_values)

## ---- eval=FALSE---------------------------------------------------------
## # change the value of 15th cell to 826
## new_raster4[15] = 826
## # change the value of the cell in the second row and forth column to 826
## new_raster4[2, 4] = 826

## ------------------------------------------------------------------------
multilayer_raster_filepath = system.file("raster/landsat.tif", package = "spDataLarge")
r_brick = brick(multilayer_raster_filepath)
r_brick

## ------------------------------------------------------------------------
nlayers(r_brick)

## ------------------------------------------------------------------------
raster_on_disk = raster(r_brick, layer = 1)
raster_in_memory = raster(xmn = 301905, xmx = 335745,
                          ymn = 4111245, ymx = 4154085, 
                          res = 30)
values(raster_in_memory) = sample(seq_len(ncell(raster_in_memory)))
crs(raster_in_memory) = crs(raster_on_disk)

## ------------------------------------------------------------------------
r_stack = stack(raster_in_memory, raster_on_disk)
r_stack

## Operations on `RasterBrick` and `RasterStack` objects will typically return a `RasterBrick`.

## ---- eval=FALSE---------------------------------------------------------
## crs_data = rgdal::make_EPSG()
## View(crs_data)

## ---- message=FALSE, results='hide'--------------------------------------
vector_filepath = system.file("vector/zion.gpkg", package="spDataLarge")
new_vector = st_read(vector_filepath)

## ------------------------------------------------------------------------
st_crs(new_vector) # get CRS

## ------------------------------------------------------------------------
new_vector = st_set_crs(new_vector, 26912) # set CRS

## ----vector-crs, echo=FALSE, fig.cap="Examples of geographic (WGS 84; left) and projected (NAD83 / UTM zone 12N; right) and coordinate systems for a vector data type."----
knitr::include_graphics("figures/02_vector_crs.png")

## ------------------------------------------------------------------------
projection(new_raster) # get CRS

## ------------------------------------------------------------------------
projection(new_raster) = "+proj=utm +zone=12 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 
                            +units=m +no_defs" # set CRS

## ----raster-crs, echo=FALSE, fig.cap="Examples of geographic (WGS 84; left) and projected (NAD83 / UTM zone 12N; right) and coordinate systems for a raster data type"----
knitr::include_graphics("figures/02_raster_crs.png")

## ------------------------------------------------------------------------
nigeria = world[world$name_long == "Nigeria", ]

## ------------------------------------------------------------------------
st_area(nigeria)

## ------------------------------------------------------------------------
st_area(nigeria) / 1000000

## ------------------------------------------------------------------------
units::set_units(st_area(nigeria), km^2)

## ------------------------------------------------------------------------
res(new_raster)

## ---- warning=FALSE, message=FALSE---------------------------------------
repr = projectRaster(new_raster, crs = "+init=epsg:4326")
res(repr)

