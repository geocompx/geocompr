## ---- eval=FALSE---------------------------------------------------------
## install.packages("sf")

## If you're running Mac or Linux the previous command to install **sf** may not workfirst time.

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

## ----sf-ogc, fig.cap="The subset of the Simple Features class hierarchy supported by sf.", out.width="60%", echo=FALSE----
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
plot(world[3:6])
plot(world["pop"])

## ---- warning=FALSE------------------------------------------------------
asia = world[world$continent == "Asia", ]
asia = st_union(asia)

## ----asia, out.width='50%', fig.cap="A plot of Asia added as a layer on top of countries worldwide.", eval=FALSE----
## plot(world["pop"], reset = FALSE)
## plot(asia, add = TRUE, col = "red")

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## plot(africa[0], lwd = 3, main = "Nigeria in context", border = "lightgrey")

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## # aim: show main
## plot(world$geom, main = "sf plot() method")

## ---- eval=FALSE---------------------------------------------------------
## plot(world["continent"], reset = FALSE)
## cex = sqrt(world$pop) / 10000
## world_cents = st_centroid(world, of_largest = TRUE)
## plot(st_geometry(world_cents), add = TRUE, cex = cex)

## ----contpop, fig.cap="Country continents (represented by fill color) and 2015 populations (represented by circles, with area proportional to population).", echo=FALSE, warning=FALSE----
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

## ----geomcollection, echo=FALSE, out.width="30%", fig.cap="Illustration of geometry collection."----
# Plotted - it is referenced in ch5 (st_cast)
plot(st_as_sfc("GEOMETRYCOLLECTION (MULTIPOINT (5 2, 1 3, 3 4, 3 2), LINESTRING (1 5, 4 4, 4 1, 2 2, 3 2))"),
     axes = TRUE, main = "GEOMETRYCOLLECTION", col = 1)

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

## ---- eval=FALSE---------------------------------------------------------
## ## GEOMETRYCOLLECTION
## gemetrycollection_list = list(st_multipoint(multipoint_matrix),
##                               st_linestring(linestring_matrix))
## st_geometrycollection(gemetrycollection_list)
## #> GEOMETRYCOLLECTION (MULTIPOINT (5 2, 1 3, 3 4, 3 2),
## #>   LINESTRING (1 5, 4 4, 4 1, 2 2, 3 2))

## ------------------------------------------------------------------------
# sfc POINT
point1 = st_point(c(5, 2))
point2 = st_point(c(1, 3))
points_sfc = st_sfc(point1, point2)
points_sfc

## ------------------------------------------------------------------------
# sfc POLYGON
polygon_list1 = list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5)))
polygon1 = st_polygon(polygon_list1)
polygon_list2 = list(rbind(c(0, 2), c(1, 2), c(1, 3), c(0, 3), c(0, 2)))
polygon2 = st_polygon(polygon_list2)
polygon_sfc = st_sfc(polygon1, polygon2)
st_geometry_type(polygon_sfc)

## ------------------------------------------------------------------------
# sfc MULTILINESTRING
multilinestring_list1 = list(rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2)), 
                            rbind(c(1, 2), c(2, 4)))
multilinestring1 = st_multilinestring((multilinestring_list1))
multilinestring_list2 = list(rbind(c(2, 9), c(7, 9), c(5, 6), c(4, 7), c(2, 7)), 
                            rbind(c(1, 7), c(3, 8)))
multilinestring2 = st_multilinestring((multilinestring_list2))
multilinestring_sfc = st_sfc(multilinestring1, multilinestring2)
st_geometry_type(multilinestring_sfc)

## ------------------------------------------------------------------------
# sfc GEOMETRY
point_multilinestring_sfc = st_sfc(point1, multilinestring1)
st_geometry_type(point_multilinestring_sfc)

## ------------------------------------------------------------------------
st_crs(points_sfc)

## ------------------------------------------------------------------------
# EPSG definition
points_sfc_wgs = st_sfc(point1, point2, crs = 4326)
st_crs(points_sfc_wgs)

## ---- eval=FALSE---------------------------------------------------------
## # PROJ4STRING definition
## st_sfc(point1, point2, crs = "+proj=longlat +datum=WGS84 +no_defs")

## Sometimes `st_crs()` will return a `proj4string` but not an `epsg` code.

## ------------------------------------------------------------------------
lnd_point = st_point(c(0.1, 51.5))                 # sfg object
lnd_geom = st_sfc(lnd_point, crs = 4326)           # sfc object
lnd_attrib = data.frame(                           # data.frame object
  name = "London",
  temperature = 25,
  date = as.Date("2017-06-21")
  )
lnd_sf = st_sf(lnd_attrib, geometry = lnd_geom)    # sf object

## ---- eval=FALSE---------------------------------------------------------
## lnd_sf
## #> Simple feature collection with 1 features and 3 fields
## #> ...
## #>     name temperature       date         geometry
## #> 1 London          25 2017-06-21 POINT (0.1 51.5)

## ------------------------------------------------------------------------
class(lnd_sf)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## ruan_point = st_point(c(-9, 53))
## # sfc object
## our_geometry = st_sfc(lnd_point, ruan_point, crs = 4326)
## # data.frame object
## our_attributes = data.frame(
##   name = c("London", "Ruan"),
##                             temperature = c(25, 13),
##                             date = c(as.Date("2017-06-21"), as.Date("2017-06-22")),
##                             category = c("city", "village"),
##                             automatic = c(FALSE, TRUE))
## # sf object
## sf_points = st_sf(our_attributes, geometry = our_geometry)

## ----raster-intro-plot, echo = FALSE, fig.cap = "Raster data: A - cell IDs; B - cell values; C - a colored raster map."----
source("code/02_raster_intro_plot.R")

## ----raster-intro-plot2, echo=FALSE, fig.cap="Examples of continuous (left) and categorical (right) raster."----
source("code/02_raster_intro_plot2.R", print.eval = TRUE)

## ---- message=FALSE------------------------------------------------------
raster_filepath = system.file("raster/srtm.tif", package = "spDataLarge")
new_raster = raster(raster_filepath)

## ---- eval=FALSE---------------------------------------------------------
## new_raster
## #> class       : RasterLayer
## #> dimensions  : 457, 465, 212505  (nrow, ncol, ncell)
## #> resolution  : 0.000833, 0.000833  (x, y)
## #> extent      : -113, -113, 37.1, 37.5  (xmin, xmax, ymin, ymax)
## #> coord. ref. : +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0
## #> data source : /home/robin/R/x86_64-pc-linux../3.5/spDataLarge/raster/srtm.tif
## #> names       : srtm
## #> values      : 1024, 2892  (min, max)

## ------------------------------------------------------------------------
# numerical summary of the data
summary(new_raster)

## ----new_raster-hist-----------------------------------------------------
# histogram of the values
hist(new_raster)

## ------------------------------------------------------------------------
new_raster_values = getValues(new_raster)
head(new_raster_values)

## The current version of **raster** (2.6.7) is not fully compatible with `sf` objects.

## ----basic-new-raster-plot, fig.cap="Basic raster plot."-----------------
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
multi_raster_file = system.file("raster/landsat.tif", package = "spDataLarge")
r_brick = brick(multi_raster_file)

## ---- eval=FALSE---------------------------------------------------------
## r_brick
## #> class       : RasterBrick
## #> resolution  : 30, 30  (x, y)
## #> ...
## #> names       : landsat.1, landsat.2, landsat.3, landsat.4
## #> min values  :      7550,      6404,      5678,      5252
## #> max values  :     19071,     22051,     25780,     31961

## ------------------------------------------------------------------------
nlayers(r_brick)

## ------------------------------------------------------------------------
raster_on_disk = raster(r_brick, layer = 1)
raster_in_memory = raster(xmn = 301905, xmx = 335745,
                          ymn = 4111245, ymx = 4154085, 
                          res = 30)
values(raster_in_memory) = sample(seq_len(ncell(raster_in_memory)))
crs(raster_in_memory) = crs(raster_on_disk)

## ---- eval=FALSE---------------------------------------------------------
## r_stack = stack(raster_in_memory, raster_on_disk)
## r_stack
## #> class : RasterStack
## #> dimensions : 1428, 1128, 1610784, 2
## #> resolution : 30, 30
## #> ...
## #> names       :   layer, landsat.1
## #> min values  :       1,      7550
## #> max values  : 1610784,     19071

## Operations on `RasterBrick` and `RasterStack` objects will typically return a `RasterBrick`.

## ---- eval=FALSE---------------------------------------------------------
## crs_data = rgdal::make_EPSG()
## View(crs_data)

## ---- message=FALSE, results='hide'--------------------------------------
vector_filepath = system.file("vector/zion.gpkg", package="spDataLarge")
new_vector = st_read(vector_filepath)

## ---- eval=FALSE---------------------------------------------------------
## st_crs(new_vector) # get CRS
## #> Coordinate Reference System:
## #> No EPSG code
## #> proj4string: "+proj=utm +zone=12 +ellps=GRS80 ... +units=m +no_defs"

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
luxembourg = world[world$name_long == "Luxembourg", ]

## ------------------------------------------------------------------------
st_area(luxembourg)

## ------------------------------------------------------------------------
st_area(luxembourg) / 1000000

## ------------------------------------------------------------------------
units::set_units(st_area(luxembourg), km^2)

## ------------------------------------------------------------------------
res(new_raster)

## ---- warning=FALSE, message=FALSE---------------------------------------
repr = projectRaster(new_raster, crs = "+init=epsg:4326")
res(repr)

