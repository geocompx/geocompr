## ----02-spatial-data-1, eval=FALSE------------------------------------------------------------------------------------------------------------------------
## install.packages("sf")
## install.packages("terra")
## install.packages("spData")
## install.packages("spDataLarge", repos = "https://nowosad.r-universe.dev")


## We recommend following R instructions on [CRAN](https://cran.r-project.org/).

## If you're running Mac or Linux, the previous command to install **sf** may not work first time.

## These operating systems (OSs) have 'systems requirements' that are described in the package's [README](https://github.com/r-spatial/sf).

## Other OS-specific instructions can be found online, including the article *Installation of R 4.2 on Ubuntu 22.04.1 LTS and tips for spatial packages* on the [rtask.thinkr.fr](https://rtask.thinkr.fr/installation-of-r-4-2-on-ubuntu-22-04-lts-and-tips-for-spatial-packages/) website.


## ----02-spatial-data-3-1, message=TRUE--------------------------------------------------------------------------------------------------------------------
library(sf)          # classes and functions for vector data


## ----02-spatial-data-3-2, message=FALSE-------------------------------------------------------------------------------------------------------------------
library(terra)      # classes and functions for raster data


## ----02-spatial-data-4, results='hide'--------------------------------------------------------------------------------------------------------------------
library(spData)        # load geographic data
library(spDataLarge)   # load larger geographic data


## Take care when using the word 'vector' as it can have two meanings in this book:

## geographic vector data and the `vector` class (note the `monospace` font) in R.

## The former is a data model, the latter is an R class just like `data.frame` and `matrix`.

## Still, there is a link between the two: the spatial coordinates which are at the heart of the geographic vector data model can be represented in R using `vector` objects.


## ----vectorplots-source, include=FALSE, eval=FALSE--------------------------------------------------------------------------------------------------------
## source("https://github.com/Robinlovelace/geocompr/raw/main/code/02-vectorplots.R") # generate subsequent figure


## ----vectorplots, fig.cap="Illustration of vector (point) data in which location of London (the red X) is represented with reference to an origin (the blue circle). The left plot represents a geographic CRS with an origin at 0° longitude and latitude. The right plot represents a projected CRS with an origin located in the sea west of the South West Peninsula.", out.width="49%", fig.show='hold', echo=FALSE, fig.scap="Illustration of vector (point) data."----
knitr::include_graphics(c("figures/vector_lonlat.png", "figures/vector_projected.png"))


## ----sf-ogc, fig.cap="Simple feature types fully supported by sf.", out.width="60%", echo=FALSE-----------------------------------------------------------
knitr::include_graphics("figures/sf-classes.png")


## ----02-spatial-data-6, eval=FALSE------------------------------------------------------------------------------------------------------------------------
## vignette(package = "sf") # see which vignettes are available
## vignette("sf1")          # an introduction to the package


## ----02-spatial-data-7, eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------------------------
## vignette("sf1") # an introduction to the package
## vignette("sf2") # reading, writing and converting simple features
## vignette("sf3") # manipulating simple feature geometries
## vignette("sf4") # manipulating simple features
## vignette("sf5") # plotting simple features
## vignette("sf6") # miscellaneous long-form documentation
## vignette("sf7") # spherical geometry operations


## ----02-spatial-data-8------------------------------------------------------------------------------------------------------------------------------------
class(world)
names(world)


## ----world-all, fig.cap="A spatial plot of the world using the sf package, with a facet for each attribute.", warning=FALSE, fig.scap="A spatial plot of the world using the sf package."----
plot(world)


## ----02-spatial-data-9------------------------------------------------------------------------------------------------------------------------------------
summary(world["lifeExp"])


## The word `MULTIPOLYGON` in the summary output above refers to the geometry type of features (countries) in the `world` object.

## This representation is necessary for countries with islands such as Indonesia and Greece.

## Other geometry types are described in Section \@ref(geometry).


## ----02-spatial-data-11-----------------------------------------------------------------------------------------------------------------------------------
world_mini = world[1:2, 1:3]
world_mini


## The preceding code chunk uses `=` to create a new object called `world_mini` in the command `world_mini = world[1:2, 1:3]`.

## This is called assignment.

## An equivalent command to achieve the same result is `world_mini <- world[1:2, 1:3]`.

## Although 'arrow assigment' is more commonly used, we use 'equals assignment' because it's slightly faster to type and easier to teach due to compatibility with commonly used languages such as Python and JavaScript.

## Which to use is largely a matter of preference as long as you're consistent (packages such as **styler** can be used to change style).


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
world_dfr = st_read(system.file("shapes/world.shp", package = "spData"))
world_tbl = read_sf(system.file("shapes/world.shp", package = "spData"))
class(world_dfr)
class(world_tbl)


## ----02-spatial-data-12, eval=FALSE-----------------------------------------------------------------------------------------------------------------------
## library(sp)
## world_sp = as(world, "Spatial") # from an sf object to sp
## # sp functions ...
## world_sf = st_as_sf(world_sp)           # from sp to sf


## ----sfplot, fig.cap="Plotting with sf, with multiple variables (left) and a single variable (right).", out.width="49%", fig.show='hold', warning=FALSE, fig.scap="Plotting with sf."----
plot(world[3:6])
plot(world["pop"])


## ----02-spatial-data-14, warning=FALSE--------------------------------------------------------------------------------------------------------------------
world_asia = world[world$continent == "Asia", ]
asia = st_union(world_asia)


## ----asia, out.width='50%', fig.cap="A plot of Asia added as a layer on top of countries worldwide.", eval=FALSE------------------------------------------
## plot(world["pop"], reset = FALSE)
## plot(asia, add = TRUE, col = "red")


## ----02-spatial-data-16, eval=FALSE-----------------------------------------------------------------------------------------------------------------------
## plot(world["continent"], reset = FALSE)
## cex = sqrt(world$pop) / 10000
## world_cents = st_centroid(world, of_largest = TRUE)
## plot(st_geometry(world_cents), add = TRUE, cex = cex)


## ----contpop, fig.cap="Country continents (represented by fill color) and 2015 populations (represented by circles, with area proportional to population).", echo=FALSE, warning=FALSE, fig.scap="Country continents and 2015 populations."----
source("https://github.com/Robinlovelace/geocompr/raw/main/code/02-contpop.R")


## ----02-spatial-data-17, eval=FALSE-----------------------------------------------------------------------------------------------------------------------
## india = world[world$name_long == "India", ]
## plot(st_geometry(india), expandBB = c(0, 0.2, 0.1, 1), col = "gray", lwd = 3)
## plot(st_geometry(world_asia), add = TRUE)


## ----china, fig.cap="India in context, demonstrating the expandBB argument.", warning=FALSE, echo=FALSE, out.width="50%"----------------------------------
old_par = par(mar = rep(0, 4))
india = world[world$name_long == "India", ]
indchi = world_asia[grepl("Indi|Chi", world_asia$name_long), ]
indchi_points = st_centroid(indchi)
indchi_coords = st_coordinates(indchi_points)
plot(st_geometry(india), expandBB = c(-0.2, 0.5, 0, 1), col = "gray", lwd = 3)
plot(world_asia[0], add = TRUE)
text(indchi_coords[, 1], indchi_coords[, 2], indchi$name_long)
par(old_par)


## ---- eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
## waldo::compare(st_geometry(world), world[0])


## ----sfcs, echo=FALSE, fig.cap="Illustration of point, linestring and polygon geometries.", fig.asp=0.4---------------------------------------------------
old_par = par(mfrow = c(1, 3), pty = "s", mar = c(0, 3, 1, 0))
plot(st_as_sfc(c("POINT(5 2)")), axes = TRUE, main = "POINT")
plot(st_as_sfc("LINESTRING(1 5, 4 4, 4 1, 2 2, 3 2)"), axes = TRUE, main = "LINESTRING")
plot(st_as_sfc("POLYGON((1 5, 2 2, 4 1, 4 4, 1 5))"), col="gray", axes = TRUE, main = "POLYGON")
par(old_par)


## ----polygon_hole, echo=FALSE, out.width="30%", eval=FALSE------------------------------------------------------------------------------------------------
## # not printed - enough of these figures already (RL)
## par(pty = "s")
## plot(st_as_sfc("POLYGON((1 5, 2 2, 4 1, 4 4, 1 5), (2 4, 3 4, 3 3, 2 3, 2 4))"), col = "gray", axes = TRUE, main = "POLYGON with a hole")


## ----multis, echo=FALSE, fig.cap="Illustration of multi* geometries.", fig.asp=0.4------------------------------------------------------------------------
old_par = par(mfrow = c(1, 3), pty = "s", mar = c(0, 3, 1, 0))
plot(st_as_sfc("MULTIPOINT (5 2, 1 3, 3 4, 3 2)"), axes = TRUE, main = "MULTIPOINT")
plot(st_as_sfc("MULTILINESTRING ((1 5, 4 4, 4 1, 2 2, 3 2), (1 2, 2 4))"), axes = TRUE, main = "MULTILINESTRING")
plot(st_as_sfc("MULTIPOLYGON (((1 5, 2 2, 4 1, 4 4, 1 5), (0 2, 1 2, 1 3, 0 3, 0 2)))"), col = "gray", axes = TRUE, main = "MULTIPOLYGON")
par(old_par)


## ----geomcollection, echo=FALSE, fig.asp=1, fig.cap="Illustration of a geometry collection.", out.width="33%"---------------------------------------------
# Plotted - it is referenced in ch5 (st_cast)
old_par = par(pty = "s", mar = c(2, 3, 3, 0))
plot(st_as_sfc("GEOMETRYCOLLECTION (MULTIPOINT (5 2, 1 3, 3 4, 3 2), LINESTRING (1 5, 4 4, 4 1, 2 2, 3 2))"),
     axes = TRUE, main = "GEOMETRYCOLLECTION", col = 1)
par(old_par)


## ----02-sfdiagram, fig.cap="Building blocks of sf objects.", echo=FALSE-----------------------------------------------------------------------------------
# source("code/02-sfdiagram.R")
knitr::include_graphics("figures/02-sfdiagram.png")


## ----02-spatial-data-33-----------------------------------------------------------------------------------------------------------------------------------
lnd_point = st_point(c(0.1, 51.5))                 # sfg object
lnd_geom = st_sfc(lnd_point, crs = 4326)           # sfc object
lnd_attrib = data.frame(                           # data.frame object
  name = "London",
  temperature = 25,
  date = as.Date("2017-06-21")
  )
lnd_sf = st_sf(lnd_attrib, geometry = lnd_geom)    # sf object


## ----02-spatial-data-34, eval=FALSE-----------------------------------------------------------------------------------------------------------------------
## lnd_sf
## #> Simple feature collection with 1 features and 3 fields
## #> ...
## #>     name temperature       date         geometry
## #> 1 London          25 2017-06-21 POINT (0.1 51.5)


## ----02-spatial-data-35-----------------------------------------------------------------------------------------------------------------------------------
class(lnd_sf)


## ----02-spatial-data-36, eval=FALSE, echo=FALSE-----------------------------------------------------------------------------------------------------------
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


## ----02-spatial-data-18-----------------------------------------------------------------------------------------------------------------------------------
st_point(c(5, 2))                 # XY point
st_point(c(5, 2, 3))              # XYZ point
st_point(c(5, 2, 1), dim = "XYM") # XYM point
st_point(c(5, 2, 3, 1))           # XYZM point


## ----02-spatial-data-19-----------------------------------------------------------------------------------------------------------------------------------
# the rbind function simplifies the creation of matrices
## MULTIPOINT
multipoint_matrix = rbind(c(5, 2), c(1, 3), c(3, 4), c(3, 2))
st_multipoint(multipoint_matrix)
## LINESTRING
linestring_matrix = rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2))
st_linestring(linestring_matrix)


## ----02-spatial-data-20-----------------------------------------------------------------------------------------------------------------------------------
## POLYGON
polygon_list = list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5)))
st_polygon(polygon_list)


## ----02-spatial-data-21-----------------------------------------------------------------------------------------------------------------------------------
## POLYGON with a hole
polygon_border = rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5))
polygon_hole = rbind(c(2, 4), c(3, 4), c(3, 3), c(2, 3), c(2, 4))
polygon_with_hole_list = list(polygon_border, polygon_hole)
st_polygon(polygon_with_hole_list)


## ----02-spatial-data-22-----------------------------------------------------------------------------------------------------------------------------------
## MULTILINESTRING
multilinestring_list = list(rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2)), 
                            rbind(c(1, 2), c(2, 4)))
st_multilinestring((multilinestring_list))


## ----02-spatial-data-23-----------------------------------------------------------------------------------------------------------------------------------
## MULTIPOLYGON
multipolygon_list = list(list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5))),
                         list(rbind(c(0, 2), c(1, 2), c(1, 3), c(0, 3), c(0, 2))))
st_multipolygon(multipolygon_list)


## ----02-spatial-data-24, eval=FALSE-----------------------------------------------------------------------------------------------------------------------
## ## GEOMETRYCOLLECTION
## geometrycollection_list = list(st_multipoint(multipoint_matrix),
##                               st_linestring(linestring_matrix))
## st_geometrycollection(geometrycollection_list)
## #> GEOMETRYCOLLECTION (MULTIPOINT (5 2, 1 3, 3 4, 3 2),
## #>   LINESTRING (1 5, 4 4, 4 1, 2 2, 3 2))


## ----02-spatial-data-25-----------------------------------------------------------------------------------------------------------------------------------
# sfc POINT
point1 = st_point(c(5, 2))
point2 = st_point(c(1, 3))
points_sfc = st_sfc(point1, point2)
points_sfc


## ----02-spatial-data-26-----------------------------------------------------------------------------------------------------------------------------------
# sfc POLYGON
polygon_list1 = list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5)))
polygon1 = st_polygon(polygon_list1)
polygon_list2 = list(rbind(c(0, 2), c(1, 2), c(1, 3), c(0, 3), c(0, 2)))
polygon2 = st_polygon(polygon_list2)
polygon_sfc = st_sfc(polygon1, polygon2)
st_geometry_type(polygon_sfc)


## ----02-spatial-data-27-----------------------------------------------------------------------------------------------------------------------------------
# sfc MULTILINESTRING
multilinestring_list1 = list(rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2)), 
                            rbind(c(1, 2), c(2, 4)))
multilinestring1 = st_multilinestring((multilinestring_list1))
multilinestring_list2 = list(rbind(c(2, 9), c(7, 9), c(5, 6), c(4, 7), c(2, 7)), 
                            rbind(c(1, 7), c(3, 8)))
multilinestring2 = st_multilinestring((multilinestring_list2))
multilinestring_sfc = st_sfc(multilinestring1, multilinestring2)
st_geometry_type(multilinestring_sfc)


## ----02-spatial-data-28-----------------------------------------------------------------------------------------------------------------------------------
# sfc GEOMETRY
point_multilinestring_sfc = st_sfc(point1, multilinestring1)
st_geometry_type(point_multilinestring_sfc)


## ----02-spatial-data-29-----------------------------------------------------------------------------------------------------------------------------------
st_crs(points_sfc)


## ----02-spatial-data-30, eval=FALSE-----------------------------------------------------------------------------------------------------------------------
## # Set the CRS with an identifier referring to an 'EPSG' CRS code:
## points_sfc_wgs = st_sfc(point1, point2, crs = "EPSG:4326")
## st_crs(points_sfc_wgs) # print CRS (only first 4 lines of output shown)
## #> Coordinate Reference System:
## #>   User input: EPSG:4326
## #>   wkt:
## #> GEOGCRS["WGS 84",
## #> ...


## ----sfheaers-setup, echo=FALSE---------------------------------------------------------------------------------------------------------------------------
## Detatch {sf} to remove 'print' methods
## because I want to show the underlying structure 
##
## library(sf) will be called later
# unloadNamespace("sf") # errors
# pkgload::unload("sf")


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
v = c(1, 1)
v_sfg_sfh = sfheaders::sfg_point(obj = v)


## ----sfheaders-sfg_point, eval=FALSE----------------------------------------------------------------------------------------------------------------------
## v_sfg_sfh # printing without sf loaded
## #>      [,1] [,2]
## #> [1,]    1    1
## #> attr(,"class")
## #> [1] "XY"    "POINT" "sfg"


## ---- eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
## v_sfg_sfh = sf::st_point(v)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
v_sfg_sf = st_point(v)
print(v_sfg_sf) == print(v_sfg_sfh)


## ---- echo=FALSE, eval=FALSE------------------------------------------------------------------------------------------------------------------------------
## # (although `sfg` objects created with **sfheaders** have a dimension while `sfg` objects created with the **sf** package do not)
## waldo::compare(v_sfg_sf, v_sfg_sfh)
## dim(v_sfg_sf)
## dim(v_sfg_sfh)
## attr(v_sfg_sfh, "dim")


## ----sfheaders-sfg_linestring-----------------------------------------------------------------------------------------------------------------------------
# matrices
m = matrix(1:8, ncol = 2)
sfheaders::sfg_linestring(obj = m)
# data.frames
df = data.frame(x = 1:4, y = 4:1)
sfheaders::sfg_polygon(obj = df)


## ----sfheaders-sfc_point2, eval=FALSE---------------------------------------------------------------------------------------------------------------------
## sfheaders::sfc_point(obj = v)
## sfheaders::sfc_linestring(obj = m)
## sfheaders::sfc_polygon(obj = df)


## ----sfheaders-sfc_point, eval=FALSE----------------------------------------------------------------------------------------------------------------------
## sfheaders::sf_point(obj = v)
## sfheaders::sf_linestring(obj = m)
## sfheaders::sf_polygon(obj = df)


## ----sfheaders-crs----------------------------------------------------------------------------------------------------------------------------------------
df_sf = sfheaders::sf_polygon(obj = df)
st_crs(df_sf) = "EPSG:4326"


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
sf_use_s2()


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
india_buffer_with_s2 = st_buffer(india, 1)
sf_use_s2(FALSE)
india_buffer_without_s2 = st_buffer(india, 1)


## ----s2example, echo=FALSE, fig.cap="Example of the consequences of turning off the S2 geometry engine. Both representations of a buffer around India were created with the same command but the purple polygon object was created with S2 switched on, resulting in a buffer of 1 m. The larger light green polygon was created with S2 switched off, resulting in a buffer with inaccurate units of degrees longitude/latitude.", fig.asp=0.75----
library(tmap)
tm1 = tm_shape(india_buffer_with_s2) +
  tm_fill(col = hcl.colors(4, palette = "purple green")[3]) +
  tm_shape(india) +
  tm_fill(col = "grey95") +
  tm_layout(main.title = "st_buffer() with dist = 1",
            title = "s2 switched on (default)")

tm2 = tm_shape(india_buffer_without_s2) +
  tm_fill(col = hcl.colors(4, palette = "purple green")[3]) +
  tm_shape(india) +
  tm_fill(col = "grey95") +
  tm_layout(main.title = " ",
            title = "s2 switched off")

tmap_arrange(tm1, tm2, ncol = 2)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
sf_use_s2(TRUE)


## Although the **sf**'s used of S2 makes sense in many cases, in some cases there are good reasons for turning S2 off for the duration of an R session or even for an entire project.

## As documented in issue [1771](https://github.com/r-spatial/sf/issues/1771) in **sf**'s GitHub repo, the default behavior can make code that would work with S2 turned off (and with older versions of **sf**) fail.

## These edge cases include operations on polygons that are not valid according to S2's stricter definition.

## If you see error message such as `#> Error in s2_geography_from_wkb ...` it may be worth trying the command that generated the error message again, after turning off S2.

## To turn off S2 for the entirety of a project you can create a file called .Rprofile in the root directory (the main folder) of your project containing the command `sf::sf_use_s2(FALSE)`.


## ----raster-intro-plot, echo = FALSE, fig.cap = "Raster data types: (A) cell IDs, (B) cell values, (C) a colored raster map.", fig.scap="Raster data types.", fig.asp=0.5, message=FALSE----
source("https://github.com/Robinlovelace/geocompr/raw/main/code/02-raster-intro-plot.R", print.eval = TRUE)


## ----raster-intro-plot2, echo=FALSE, fig.cap="Examples of continuous and categorical rasters.", warning=FALSE, message=FALSE------------------------------
source("code/02-raster-intro-plot2.R", print.eval = TRUE)
# knitr::include_graphics("https://user-images.githubusercontent.com/1825120/146617327-45919232-a6a3-4d9d-a158-afa87f47381b.png")


## ---- echo=FALSE, eval=FALSE------------------------------------------------------------------------------------------------------------------------------
## # # test raster/terra conversions
## # See https://github.com/rspatial/terra/issues/399


## ----02-spatial-data-37, message=FALSE--------------------------------------------------------------------------------------------------------------------
raster_filepath = system.file("raster/srtm.tif", package = "spDataLarge")
my_rast = rast(raster_filepath)
class(my_rast)


## ----02-spatial-data-38-----------------------------------------------------------------------------------------------------------------------------------
my_rast


## ----basic-new-raster-plot, fig.cap="Basic raster plot."--------------------------------------------------------------------------------------------------
plot(my_rast)


## ----02-spatial-data-41-----------------------------------------------------------------------------------------------------------------------------------
single_raster_file = system.file("raster/srtm.tif", package = "spDataLarge")
single_rast = rast(raster_filepath)


## ----02-spatial-data-42-----------------------------------------------------------------------------------------------------------------------------------
new_raster = rast(nrows = 6, ncols = 6, resolution = 0.5, 
                  xmin = -1.5, xmax = 1.5, ymin = -1.5, ymax = 1.5,
                  vals = 1:36)


## ----02-spatial-data-45-----------------------------------------------------------------------------------------------------------------------------------
multi_raster_file = system.file("raster/landsat.tif", package = "spDataLarge")
multi_rast = rast(multi_raster_file)
multi_rast


## ----02-spatial-data-47-----------------------------------------------------------------------------------------------------------------------------------
nlyr(multi_rast)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
multi_rast3 = subset(multi_rast, 3)
multi_rast4 = subset(multi_rast, "landsat_4")


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
multi_rast34 = c(multi_rast3, multi_rast4)


## Most `SpatRaster` objects do not store raster values, but rather a pointer to the file itself.

## This has a significant side-effect -- they cannot be directly saved to `".rds"` or `".rda"` files or used in cluster computing.

## In these cases, there are two possible solutions: (1) use of the `wrap()` function that creates a special kind of temporary object that can be saved as an R object or used in cluster computing, or (2) save the object as a regular raster with `writeRaster()`.


## ----datum-fig, echo=FALSE, message=FALSE, fig.cap="(ref:datum-fig)", fig.scap="Geocentric and local geodetic datums on a geoid."-------------------------
knitr::include_graphics("figures/02_datum_fig.png")


## ----vector-crs, echo=FALSE, fig.cap="Examples of geographic (WGS 84; left) and projected (NAD83 / UTM zone 12N; right) coordinate systems for a vector data type.", message=FALSE, fig.asp=0.56, fig.scap="Examples of geographic and projected CRSs (vector data)."----
# source("https://github.com/Robinlovelace/geocompr/raw/main/code/02-vector-crs.R")
knitr::include_graphics("figures/02_vector_crs.png")


## ----02-spatial-data-57-----------------------------------------------------------------------------------------------------------------------------------
luxembourg = world[world$name_long == "Luxembourg", ]


## ----02-spatial-data-58-----------------------------------------------------------------------------------------------------------------------------------
st_area(luxembourg) # requires the s2 package in recent versions of sf


## ----02-spatial-data-59-----------------------------------------------------------------------------------------------------------------------------------
st_area(luxembourg) / 1000000


## ----02-spatial-data-60-----------------------------------------------------------------------------------------------------------------------------------
units::set_units(st_area(luxembourg), km^2)


## ----02-spatial-data-61-----------------------------------------------------------------------------------------------------------------------------------
res(my_rast)


## ----02-spatial-data-62, warning=FALSE, message=FALSE-----------------------------------------------------------------------------------------------------
repr = project(my_rast, "EPSG:26912")
res(repr)


## ---- echo=FALSE, results='asis'--------------------------------------------------------------------------------------------------------------------------
res = knitr::knit_child('_02-ex.Rmd', quiet = TRUE, options = list(include = FALSE, eval = FALSE))
cat(res, sep = '\n')

