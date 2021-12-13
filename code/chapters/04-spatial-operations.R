## ----04-spatial-operations-1, message=FALSE, results='hide'--------------
library(sf)
library(raster)
library(dplyr)
library(spData)

## It is important to note that spatial operations that use two spatial objects rely on both objects having the same coordinate reference system, a topic that was introduced in Section \@ref(crs-intro) and which will be covered in more depth in Chapter \@ref(reproj-geo-data).

## ----04-spatial-operations-3---------------------------------------------
canterbury = nz %>% filter(Name == "Canterbury")
canterbury_height = nz_height[canterbury, ]

## ----nz-subset, echo=FALSE, warning=FALSE, fig.cap="Illustration of spatial subsetting with red triangles representing 101 high points in New Zealand, clustered near the central Canterbuy region (left). The points in Canterbury were created with the `[` subsetting operator (highlighted in gray, right).", fig.scap="Illustration of spatial subsetting."----
library(tmap)
p_hpnz1 = tm_shape(nz) + tm_polygons(col = "white") +
  tm_shape(nz_height) + tm_symbols(shape = 2, col = "red", size = 0.25) +
  tm_layout(main.title = "High points in New Zealand", main.title.size = 1,
            bg.color = "lightblue")
p_hpnz2 = tm_shape(nz) + tm_polygons(col = "white") +
  tm_shape(canterbury) + tm_fill(col = "gray") + 
  tm_shape(canterbury_height) + tm_symbols(shape = 2, col = "red", size = 0.25) +
  tm_layout(main.title = "High points in Canterbury", main.title.size = 1,
            bg.color = "lightblue")
tmap_arrange(p_hpnz1, p_hpnz2, ncol = 2)

## ----04-spatial-operations-4, eval=FALSE---------------------------------
## nz_height[canterbury, , op = st_disjoint]

## Note the empty argument --- denoted with `, ,` --- in the preceding code chunk is included to highlight `op`, the third argument in `[` for `sf` objects.

## ----04-spatial-operations-6---------------------------------------------
sel_sgbp = st_intersects(x = nz_height, y = canterbury)
class(sel_sgbp)
sel_logical = lengths(sel_sgbp) > 0
canterbury_height2 = nz_height[sel_logical, ]

## Note: another way to return a logical output is by setting `sparse = FALSE` (meaning 'return a dense matrix not a sparse one') in operators such as `st_intersects()`. The command `st_intersects(x = nz_height, y = canterbury, sparse = FALSE)[, 1]`, for example, would return an output identical `sel_logical`.

## ------------------------------------------------------------------------
canterbury_height3 = nz_height %>%
  filter(st_intersects(x = ., y = canterbury, sparse = FALSE))

## ----04-spatial-operations-8---------------------------------------------
# create a polygon
a_poly = st_polygon(list(rbind(c(-1, -1), c(1, -1), c(1, 1), c(-1, -1))))
a = st_sfc(a_poly)
# create a line
l_line = st_linestring(x = matrix(c(-1, -1, -0.5, 1), ncol = 2))
l = st_sfc(l_line)
# create points
p_matrix = matrix(c(0.5, 1, -1, 0, 0, 1, 0.5, 1), ncol = 2)
p_multi = st_multipoint(x = p_matrix)
p = st_cast(st_sfc(p_multi), "POINT")

## ----relation-objects, echo=FALSE, fig.cap="Points (p 1 to 4), line and polygon objects arranged to illustrate topological relations.", fig.asp=1, out.width="50%", fig.scap="Demonstration of topological relations."----
par(pty = "s")
plot(a, border = "red", col = "gray", axes = TRUE)
plot(l, add = TRUE)
plot(p, add = TRUE, lab = 1:4)
text(p_matrix[, 1] + 0.04, p_matrix[, 2] - 0.06, 1:4, cex = 1.3)

## ----04-spatial-operations-9, eval=FALSE---------------------------------
## st_intersects(p, a)
## #> Sparse geometry binary ..., where the predicate was `intersects'
## #> 1: 1
## #> 2: 1
## #> 3: (empty)
## #> 4: (empty)

## ----04-spatial-operations-10--------------------------------------------
st_intersects(p, a, sparse = FALSE)

## ----04-spatial-operations-11--------------------------------------------
st_disjoint(p, a, sparse = FALSE)[, 1]

## ----04-spatial-operations-12--------------------------------------------
st_within(p, a, sparse = FALSE)[, 1]

## ----04-spatial-operations-13--------------------------------------------
st_touches(p, a, sparse = FALSE)[, 1]

## ----04-spatial-operations-14--------------------------------------------
sel = st_is_within_distance(p, a, dist = 0.9) # can only return a sparse matrix
lengths(sel) > 0

## Functions for calculating topological relations use spatial indices to largely speed up spatial query performance.

## ----04-spatial-operations-16, eval=FALSE, echo=FALSE--------------------
## # other tests
## st_overlaps(p, a, sparse = FALSE)
## st_covers(p, a, sparse = FALSE)
## st_covered_by(p, a, sparse = FALSE)

## ----04-spatial-operations-17, eval=FALSE, echo=FALSE--------------------
## st_contains(a, p[2, ], sparse = TRUE)

## ----04-spatial-operations-18, eval=FALSE, echo=FALSE--------------------
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

## ----04-spatial-operations-19--------------------------------------------
set.seed(2018) # set seed for reproducibility
(bb = st_bbox(world)) # the world's bounds
random_df = tibble(
  x = runif(n = 10, min = bb[1], max = bb[3]),
  y = runif(n = 10, min = bb[2], max = bb[4])
)
random_points = random_df %>% 
  st_as_sf(coords = c("x", "y")) %>% # set coordinates
  st_set_crs(4326) # set geographic CRS

## ----04-spatial-operations-20, message=FALSE-----------------------------
world_random = world[random_points, ]
nrow(world_random)
random_joined = st_join(random_points, world["name_long"])

## ----spatial-join, echo=FALSE, fig.cap="Illustration of a spatial join. A new attribute variable is added to random points (top left) from source world object (top right) resulting in the data represented in the final panel.", fig.asp=0.5, warning=FALSE, message=FALSE, out.width="100%", fig.scap="Illustration of a spatial join."----
source("https://github.com/Robinlovelace/geocompr/raw/main/code/04-spatial-join.R")
tmap_arrange(jm1, jm2, jm3, jm4, nrow = 2, ncol = 2)

## ----04-spatial-operations-21, eval=FALSE--------------------------------
## plot(st_geometry(cycle_hire), col = "blue")
## plot(st_geometry(cycle_hire_osm), add = TRUE, pch = 3, col = "red")

## ----04-spatial-operations-22, message=FALSE-----------------------------
any(st_touches(cycle_hire, cycle_hire_osm, sparse = FALSE))

## ----04-spatial-operations-23, echo=FALSE, eval=FALSE--------------------
## # included to show alternative ways of showing there's no overlap
## sum(st_geometry(cycle_hire) %in% st_geometry(cycle_hire_osm))
## sum(st_coordinates(cycle_hire)[, 1] %in% st_coordinates(cycle_hire_osm)[, 1])

## ----cycle-hire, fig.cap="The spatial distribution of cycle hire points in London based on official data (blue) and OpenStreetMap data (red).", echo=FALSE, warning=FALSE, fig.scap="The spatial distribution of cycle hire points in London."----
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
  addProviderTiles(providers$OpenStreetMap.BlackAndWhite) %>%
  addCircles(data = cycle_hire) %>%
  addCircles(data = cycle_hire_osm, col = "red")

## ----04-spatial-operations-24--------------------------------------------
cycle_hire_P = st_transform(cycle_hire, 27700)
cycle_hire_osm_P = st_transform(cycle_hire_osm, 27700)
sel = st_is_within_distance(cycle_hire_P, cycle_hire_osm_P, dist = 20)
summary(lengths(sel) > 0)

## ----04-spatial-operations-25--------------------------------------------
z = st_join(cycle_hire_P, cycle_hire_osm_P, st_is_within_distance, dist = 20)
nrow(cycle_hire)
nrow(z)

## ----04-spatial-operations-26--------------------------------------------
z = z %>% 
  group_by(id) %>% 
  summarize(capacity = mean(capacity))
nrow(z) == nrow(cycle_hire)

## ----04-spatial-operations-27, eval=FALSE--------------------------------
## plot(cycle_hire_osm["capacity"])
## plot(z["capacity"])

## ----04-spatial-operations-28--------------------------------------------
nz_avheight = aggregate(x = nz_height, by = nz, FUN = mean)

## ----spatial-aggregation, echo=FALSE, fig.cap="Average height of the top 101 high points across the regions of New Zealand.", fig.asp=1, message=FALSE, out.width="50%"----
library(tmap)
tm_shape(nz_avheight) +
  tm_fill("elevation", breaks = seq(27, 29, by = 0.5) * 1e2) +
  tm_borders()

## ----04-spatial-operations-29--------------------------------------------
nz_avheight2 = nz %>%
  st_join(nz_height) %>%
  group_by(Name) %>%
  summarize(elevation = mean(elevation, na.rm = TRUE))

## ----areal-example, echo=FALSE, fig.cap="Illustration of congruent (left) and incongruent (right) areal units with respect to larger aggregating zones (translucent blue borders).", fig.asp=0.5, out.width="100%", fig.scap="Illustration of congruent and incongruent areal units."----
source("https://github.com/Robinlovelace/geocompr/raw/main/code/04-areal-example.R", print.eval = TRUE)

## ----04-spatial-operations-30--------------------------------------------
agg_aw = st_interpolate_aw(incongruent[, "value"], aggregating_zones,
                           extensive = TRUE)
# show the aggregated result
agg_aw$value

## ----04-spatial-operations-31, warning=FALSE-----------------------------
nz_heighest = nz_height %>% top_n(n = 1, wt = elevation)
canterbury_centroid = st_centroid(canterbury)
st_distance(nz_heighest, canterbury_centroid)

## ----04-spatial-operations-32--------------------------------------------
co = filter(nz, grepl("Canter|Otag", Name))
st_distance(nz_height[1:3, ], co)

## ----04-spatial-operations-33, eval=FALSE--------------------------------
## plot(st_geometry(co)[2])
## plot(st_geometry(nz_height)[2:3], add = TRUE)

## ----04-spatial-operations-34, eval = FALSE------------------------------
## id = cellFromXY(elev, xy = c(0.1, 0.1))
## elev[id]
## # the same as
## raster::extract(elev, data.frame(x = 0.1, y = 0.1))

## ----04-spatial-operations-35--------------------------------------------
clip = raster(xmn = 0.9, xmx = 1.8, ymn = -0.45, ymx = 0.45,
              res = 0.3, vals = rep(1, 9))
elev[clip]
# we can also use extract
# extract(elev, extent(clip))

## ----raster-subset, echo = FALSE, fig.cap = "Subsetting raster values with the help of another raster (left). Raster mask (middle). Output of masking a raster (right).", fig.scap="Subsetting raster values."----
knitr::include_graphics("figures/04_raster_subset.png")

## ----04-spatial-operations-36, eval=FALSE--------------------------------
## elev[1:2, drop = FALSE]    # spatial subsetting with cell IDs
## elev[1, 1:2, drop = FALSE] # spatial subsetting by row,column indices
## #> class       : RasterLayer
## #> dimensions  : 1, 2, 2  (nrow, ncol, ncell)
## #> ...

## ----04-spatial-operations-37, echo=FALSE, eval=FALSE--------------------
## # aim: illustrate the result of previous spatial subsetting example
## x = elev[1, 1:2, drop = FALSE]
## plot(x)

## ----04-spatial-operations-38, eval=FALSE--------------------------------
## # create raster mask
## rmask = elev
## values(rmask) = sample(c(NA, TRUE), 36, replace = TRUE)
## 
## # spatial subsetting
## elev[rmask, drop = FALSE]           # with [ operator
## mask(elev, rmask)                   # with mask()
## overlay(elev, rmask, fun = "max")   # with overlay

## ----04-spatial-operations-39, eval=FALSE, echo=FALSE--------------------
## # aim: expand on previous code chunk to show how mask methods differ
## rmask = elev # create raster mask
## values(rmask) = sample(c(NA, TRUE), 36, replace = TRUE)
## 
## m1 = elev[rmask, drop = FALSE]           # with [ operator
## m2 = mask(elev, rmask)                   # with mask()
## m3 = overlay(elev, rmask, fun = "max")   # with overlay
## 
## all.equal(m1, m2)
## all.equal(m1, m3)
## all.equal(m3, m2)

## ----04-spatial-operations-40, eval = FALSE------------------------------
## rcl = matrix(c(0, 12, 1, 12, 24, 2, 24, 36, 3), ncol = 3, byrow = TRUE)
## recl = reclassify(elev, rcl = rcl)

## ----04-spatial-operations-41, eval = FALSE------------------------------
## elev + elev
## elev^2
## log(elev)
## elev > 5

## ----04-spatial-operations-42, eval = FALSE------------------------------
## r_focal = focal(elev, w = matrix(1, nrow = 3, ncol = 3), fun = min)

## ----focal-example, echo = FALSE, fig.cap = "Input raster (left) and resulting output raster (right) due to a focal operation - summing up 3-by-3 windows.", fig.scap="Illustration of a focal operation."----
knitr::include_graphics("figures/04_focal_example.png")

## ----04-spatial-operations-43--------------------------------------------
z = zonal(elev, grain, fun = "mean") %>%
  as.data.frame()
z

## ----04-spatial-operations-44, eval = FALSE------------------------------
## aut = getData("alt", country = "AUT", mask = TRUE)
## ch = getData("alt", country = "CHE", mask = TRUE)
## aut_ch = merge(aut, ch)

## ----04-spatial-operations-45, eval=FALSE, echo=FALSE--------------------
## library(tmap)
## tmap_mode("view")
## qtm(nz) + qtm(nz_height)
## canterbury = nz %>% filter(Name == "Canterbury")
## canterbury_height = nz_height[canterbury, ]
## nrow(canterbury_height) # answer: 70

## ----04-spatial-operations-46, eval=FALSE, echo=FALSE--------------------
## nz_height_count = aggregate(nz_height, nz, length)
## nz_height_combined = cbind(nz, count = nz_height_count$elevation)
## nz_height_combined %>%
##   st_set_geometry(NULL) %>%
##   dplyr::select(Name, count) %>%
##   arrange(desc(count)) %>%
##   slice(2)

## ----04-spatial-operations-47, echo=FALSE, eval=FALSE--------------------
## nz_height_count = aggregate(nz_height, nz, length)
## nz_height_combined = cbind(nz, count = nz_height_count$elevation)
## nz_height_combined %>%
##   st_set_geometry(NULL) %>%
##   dplyr::select(Name, count) %>%
##   arrange(desc(count)) %>%
##   na.omit()

