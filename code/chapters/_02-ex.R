## ----02-ex-e0, message=FALSE------------------------------------------------------------------------------------------------------------------------------
library(sf)
library(spData)
library(terra)


## ----02-ex-e1---------------------------------------------------------------------------------------------------------------------------------------------
summary(world)
# - Its geometry type?
#   multipolygon
# - The number of countries?
#   177
# - Its coordinate reference system (CRS)?
#   epsg:4326


## ----02-ex-e2---------------------------------------------------------------------------------------------------------------------------------------------
plot(world["continent"], reset = FALSE)
cex = sqrt(world$pop) / 10000
world_cents = st_centroid(world, of_largest = TRUE)
plot(st_geometry(world_cents), add = TRUE, cex = cex)
# - What does the `cex` argument do (see `?plot`)?
#   It specifies the size of the circles
# - Why was `cex` set to the `sqrt(world$pop) / 10000`?
#   So the circles would be visible for small countries but not too large for large countries, also because area increases as a linear function of the square route of the diameter defined by `cex`
# - Bonus: experiment with different ways to visualize the global population.
plot(st_geometry(world_cents), cex = world$pop / 1e9)
plot(st_geometry(world_cents), cex = world$pop / 1e8)
plot(world["pop"])
plot(world["pop"], logz = TRUE)

# Similarities: global extent, colorscheme, relative size of circles
# 
# Differences: projection (Antarctica is much smaller for example), graticules, location of points in the countries.
# 
# To understand these differences read-over, run, and experiment with different argument values in this script: https://github.com/Robinlovelace/geocompr/raw/main/code/02-contpop.R
# 
# `cex` refers to the diameter of symbols plotted, as explained by the help page `?graphics::points`. It is an acronym for 'Chacter symbol EXpansion'.
# It was set to the square route of the population divided by 10,000 because a) otherwise the symbols would not fit on the map and b) to make circle area proportional to population.


## ----02-ex-e3---------------------------------------------------------------------------------------------------------------------------------------------
nigeria = world[world$name_long == "Nigeria", ]
plot(st_geometry(nigeria), expandBB = c(0, 0.2, 0.1, 1), col = "gray", lwd = 3)
plot(world[0], add = TRUE)
world_coords = st_coordinates(world_cents)
text(world_coords, world$iso_a2)

# Alternative answer:
nigeria = world[world$name_long == "Nigeria", ]
africa = world[world$continent == "Africa", ]
plot(st_geometry(nigeria), col = "white", lwd = 3, main = "Nigeria in context", border = "lightgrey", expandBB = c(0.5, 0.2, 0.5, 0.2))
plot(st_geometry(world), lty = 3, add = TRUE, border = "grey")
plot(st_geometry(nigeria), col = "yellow", add = TRUE, border = "darkgrey")
a = africa[grepl("Niger", africa$name_long), ]
ncentre = st_centroid(a)
ncentre_num = st_coordinates(ncentre)
text(x = ncentre_num[, 1], y = ncentre_num[, 2], labels = a$name_long)


## ----02-ex-e4, message = FALSE----------------------------------------------------------------------------------------------------------------------------
my_raster = rast(ncol = 10, nrow = 10,
                 vals = sample(0:10, size = 10 * 10, replace = TRUE))
plot(my_raster)


## ----02-ex-e5, message = FALSE----------------------------------------------------------------------------------------------------------------------------
nlcd = rast(system.file("raster/nlcd.tif", package = "spDataLarge"))
dim(nlcd) # dimensions
res(nlcd) # resolution
ext(nlcd) # extent
nlyr(nlcd) # number of layers
cat(crs(nlcd)) # CRS


## ----02-ex-e6, message = FALSE----------------------------------------------------------------------------------------------------------------------------
cat(crs(nlcd))


## The WKT above describes a two-dimensional projected coordinate reference system.

## It is based on the GRS 1980 ellipsoid with  North American Datum 1983  and the Greenwich prime meridian.

## It used the Transverse Mercator projection to transform from geographic to projected CRS (UTM zone 12N).

## Its first axis is related to eastness, while the second one is related to northness, and both axes have units in meters.

## The SRID of the above CRS is "EPSG:26912".

