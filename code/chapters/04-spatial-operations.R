## ---- message=FALSE, results='hide'--------------------------------------
library(sf)
library(raster)
library(tidyverse)
library(spData)

## It is important to note that spatial operations that use two spatial objects rely on both objects having the same coordinate reference system, a topic that was introduced in \@ref(crs-intro) and which will be covered in more depth in Chapter \@ref(transform).

## ------------------------------------------------------------------------
canterbury = nz %>% filter(REGC2017_NAME == "Canterbury Region")
canterbury_height = nz_height[canterbury, ]

## ----nz-subset, echo=FALSE, warning=FALSE, fig.cap="Illustration of spatial subsetting with red triangles representing 101 high points in New Zealand, clustered near the central Canterbuy region (left). The points in Canterbury were created with the `[` subsetting operator (highlighted in grey, right)."----
par_old = par(mfrow = c(1, 2), mar = c(0, 0, 1, 0))
plot(nz$geometry, col = "white", bgc = "lightblue", main = "High points in New Zealand")
plot(nz_height$geometry, add = TRUE, pch = 2, col = "red")
par(mar=c(0, 0, 1, 0))
plot(nz$geometry, col = "white", bgc = "lightblue", main = "High points in Canterbury")
plot(canterbury$geometry, col = "grey", add = TRUE)
plot(canterbury_height$geometry, add = TRUE, pch = 2, col = "red")
par(par_old)

## ---- eval=FALSE---------------------------------------------------------
## nz_height[canterbury, , op = st_disjoint]

## Note the empty argument --- donoted with `, ,` --- in the preceding code chunk is not necessary (`nz_height[canterbury, op = st_disjoint]` returns the same result) but is included to emphasise the fact that `op` is the third argument in `[` for `sf` objects, after arguments for subsetting rows and columns.

## ------------------------------------------------------------------------
sel = st_intersects(x = nz_height, y = canterbury, sparse = FALSE)
canterbury_height2 = nz_height[sel, ]

## ------------------------------------------------------------------------
canterbury_height3 = nz_height %>% filter(sel)

## ------------------------------------------------------------------------
identical(x = canterbury_height, y = canterbury_height2)
identical(x = canterbury_height, y = canterbury_height3)

## ------------------------------------------------------------------------
row.names(canterbury_height)[1:3]
row.names(canterbury_height3)[1:3]

## ------------------------------------------------------------------------
attr(canterbury_height3, "row.names") = attr(x = canterbury_height, "row.names")
identical(canterbury_height, canterbury_height3)

## This discarding of row names is not something that is specific to spatial

## ------------------------------------------------------------------------
class(sel)
typeof(sel)
dim(sel)

## ------------------------------------------------------------------------
co = filter(nz, grepl("Canter|Otag", REGC2017_NAME))
sel_sparse = st_intersects(nz_height, co)
sel_vector = lengths(sel_sparse) > 0
heights_co = nz_height[sel_vector, ]

## ------------------------------------------------------------------------
a_poly = st_polygon(list(rbind(c(-1, -1), c(1, -1), c(1, 1), c(-1, -1))))
a = st_sfc(a_poly)

l_line = st_linestring(x = matrix(c(-1, -1, -0.5, 1), , 2))
l = st_sfc(l_line)

p_matrix = matrix(c(0.5, 1, -1, 0, 0, 1, 0.5, 1), ncol = 2)
p_multi = st_multipoint(x = p_matrix)
p = st_sf(st_cast(st_sfc(p_multi), "POINT"))

## ----relation-objects, echo=FALSE, fig.cap="Points (p 1 to 4), line and polygon objects arranged to demonstrate spatial relations.",fig.asp=1----
par(pty = "s")
plot(a, border = "red", col = "grey", axes = TRUE)
plot(l, add = TRUE)
plot(p, add = TRUE, lab = 1:4)
text(p_matrix[, 1] + 0.02, p_matrix[, 2] - 0.05, 1:4)

## ------------------------------------------------------------------------
st_intersects(p, a)

## ------------------------------------------------------------------------
st_intersects(p, a, sparse = FALSE)

## ------------------------------------------------------------------------
st_disjoint(p, a, sparse = FALSE)[, 1]

## ------------------------------------------------------------------------
st_within(p, a, sparse = FALSE)[, 1]

## ------------------------------------------------------------------------
st_touches(p, a, sparse = FALSE)[, 1]

## ------------------------------------------------------------------------
sel = st_is_within_distance(p, a, dist = 0.9) # can only return a sparse matrix
lengths(sel) > 0

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # other tests
## st_overlaps(p, a, sparse = FALSE)
## st_covers(p, a, sparse = FALSE)
## st_covered_by(p, a, sparse = FALSE)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## st_contains(a, p[2, ], sparse = TRUE)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # starting simpler so commented
## a1 = st_polygon(list(rbind(c(-1, -1), c(1, -1), c(1, 1), c(-1, -1))))
## a2 = st_polygon(list(rbind(c(2, 0), c(2, 2), c(3, 2), c(3, 0), c(2, 0))))
## a = st_sfc(a1, a2)
## 
## b1 = a1 * 0.5
## b2 = a2 * 0.4 + c(1, 0.5)
## b = st_sfc(b1, b2)
## 
## l1 = st_linestring(x = matrix(c(0, 3, -1, 1), , 2))
## l2 = st_linestring(x = matrix(c(-1, -1, -0.5, 1), , 2))
## l = st_sfc(l1, l2)
## 
## p = st_multipoint(x = matrix(c(0.5, 1, -1, 0, 1, 0.5), , 2))
## 
## plot(a, border = "red", axes = TRUE)
## plot(b, border = "green", add = TRUE)
## plot(l, add = TRUE)
## plot(p, add = TRUE)

## ------------------------------------------------------------------------
asia = world %>% 
  filter(continent == "Asia")
urb = urban_agglomerations %>% 
  filter(year == 2020) %>% 
  top_n(n = 3, wt = population_millions)

## ---- message=FALSE------------------------------------------------------
joined = st_join(x = asia, y = urb) %>% 
  na.omit()

## ----spatial-join, echo=FALSE, fig.cap="Illustration of a spatial join: the populations of the world's three largest agglomerations joined onto their respective countries.", fig.asp=0.4, warning=FALSE----
source("code/04-spatial-join.R")

## ---- eval=FALSE---------------------------------------------------------
## plot(cycle_hire$geometry, col = "blue")
## plot(cycle_hire_osm$geometry, add = TRUE, pch = 3, col = "red")

## ---- message=FALSE------------------------------------------------------
any(st_touches(cycle_hire, cycle_hire_osm, sparse = FALSE))

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## # included to show alternative ways of showing there's no overlap
## sum(cycle_hire$geometry %in% cycle_hire_osm$geometry)
## sum(st_coordinates(cycle_hire)[, 1] %in% st_coordinates(cycle_hire_osm)[, 1])

## ----cycle-hire, fig.cap="The spatial distribution of cycle hire points in London based on official data (blue) and OpenStreetMap data (red).", echo=FALSE, warning=FALSE----
# library(tmap)
# osm_tiles = tmaptools::read_osm(tmaptools::bb(cycle_hire, ext = 1.3), type = "https://korona.geog.uni-heidelberg.de/tiles/roadsg/x={x}&y={y}&z={z}")
# qtm(osm_tiles) +
  # tm_shape(cycle_hire) +
  # tm_bubbles(col = "blue", alpha = 0.5, size = 0.2) +
  # tm_shape(cycle_hire_osm) +
  # tm_bubbles(col = "red", alpha = 0.5, size = 0.2) +
  # tm_scale_bar()
library(leaflet)
leaflet() %>%
  addProviderTiles(providers$Esri.WorldGrayCanvas) %>%
  addCircles(data = cycle_hire) %>%
  addCircles(data = cycle_hire_osm, col = "red")

## ------------------------------------------------------------------------
cycle_hire_P = st_transform(cycle_hire, 27700)
cycle_hire_osm_P = st_transform(cycle_hire_osm, 27700)
sel = st_is_within_distance(cycle_hire_P, cycle_hire_osm_P, dist = 20)
summary(lengths(sel) > 0)

## ------------------------------------------------------------------------
z = st_join(cycle_hire_P, cycle_hire_osm_P, st_is_within_distance, dist = 20)
nrow(cycle_hire)
nrow(z)

## ------------------------------------------------------------------------
z = z %>% 
  group_by(id) %>% 
  summarize(capacity = mean(capacity))
nrow(z) == nrow(cycle_hire)

## ---- eval=FALSE---------------------------------------------------------
## plot(cycle_hire_osm["capacity"])
## plot(z["capacity"])

## ------------------------------------------------------------------------
nz_avheight = aggregate(x = nz_height, nz, FUN = mean)

## ----spatial-aggregation, echo=FALSE, fig.cap="Average height of the top 101 high points across the regions of New Zealand."----
library(tmap)
tm_shape(nz_avheight) +
  tm_fill("elevation", breaks = seq(27, 29, by = 0.5) * 1e2) +
  tm_borders()

## ------------------------------------------------------------------------
nz_avheight2 = st_join(nz, nz_height) %>%
  group_by(REGC2017_NAME) %>%
  summarize(elevation = mean(elevation, na.rm = TRUE))

## ----areal-example, echo=FALSE, fig.cap="Illustration of congruent (left) and incongruent (right) areal units with respect to larger aggregating zones (translucent blue borders).", out.width="100%"----
# source("code/04-congruence.R")
knitr::include_graphics("figures/04-congruence.png")

## ------------------------------------------------------------------------
agg_aw = st_interpolate_aw(incongruent[, "value"], aggregating_zones, extensive = TRUE)

## ------------------------------------------------------------------------
nz_heighest = nz_height %>% top_n(n = 1, wt = elevation)
canterbury_centroid = st_centroid(canterbury)
st_distance(nz_heighest, canterbury_centroid)

## ------------------------------------------------------------------------
st_distance(nz_height[1:3, ], co)

## ---- eval=FALSE---------------------------------------------------------
## plot(co$geometry[2])
## plot(nz_height$geometry[2:3], add = TRUE)

## ---- eval = FALSE-------------------------------------------------------
## id = cellFromXY(elev, xy = c(0.1, 0.1))
## elev[id]
## # the same as
## raster::extract(elev, data.frame(x = 0.1, y = 0.1))

## ------------------------------------------------------------------------
clip = raster(nrow = 3, ncol = 3, res = 0.3, xmn = 0.9, xmx = 1.8, 
              ymn = -0.45, ymx = 0.45, vals = rep(1, 9))
elev[clip]
# we can also use extract
# extract(elev, extent(clip))

## ------------------------------------------------------------------------
elev[clip, drop = FALSE]

## ----raster-subset, echo = FALSE, fig.cap = "Subsetting raster values with the help of another raster (left). Raster mask (middle). Output of masking a raster."----
knitr::include_graphics("figures/04_raster_subset.png")

## ---- eval = FALSE-------------------------------------------------------
## rmask = raster(nrow = 6, ncol = 6, res = 0.5,
##                xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
##                vals = sample(c(FALSE, TRUE), 36, replace = TRUE))
## elev[rmask, drop = FALSE]
## # using the mask command
## mask(elev, rmask, maskvalue = TRUE)
## # using overlay
## # first we replace FALSE by NA
## rmask[rmask == FALSE] = NA
## # then we retrieve the maximum values
## overlay(elev, rmask, fun = "max")

## ---- eval = FALSE-------------------------------------------------------
## rcl = matrix(c(0, 12, 1, 12, 24, 2, 24, 36, 3), ncol = 3, byrow = TRUE)
## recl = reclassify(elev, rcl = rcl)

## ---- eval = FALSE-------------------------------------------------------
## elev + elev
## elev^2
## log(elev)
## elev > 5

## ---- eval = FALSE-------------------------------------------------------
## r_focal = focal(elev, w = matrix(1, nrow = 3, ncol = 3), fun = min)

## ----focal-example, echo = FALSE, fig.cap = "Input raster (left) and resulting output raster (right) due to a focal operation - summing up 3-by-3 windows."----
knitr::include_graphics("figures/04_focal_example.png")

## ------------------------------------------------------------------------
z = zonal(elev, grain, fun = "mean") %>%
  as.data.frame
z

## ---- eval = FALSE-------------------------------------------------------
## aut = getData("alt", country = "AUT", mask = TRUE)
## ch = getData("alt", country = "CHE", mask = TRUE)
## aut_ch = merge(aut, ch)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## library(tmap)
## tmap_mode("view")
## qtm(nz) + qtm(nz_height)
## canterbury = nz %>% filter(REGC2017_NAME == "Canterbury Region")
## canterbury_height = nz_height[canterbury, ]
## nrow(canterbury_height) # answer: 61

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## nz_height_count = aggregate(nz_height, nz, length)
## nz_height_combined = cbind(nz, count = nz_height_count$elevation)
## nz_height_combined %>%
##   st_set_geometry(NULL) %>%
##   dplyr::select(REGC2017_NAME, count) %>%
##   arrange(desc(count)) %>%
##   na.omit()

