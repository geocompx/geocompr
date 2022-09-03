## ----04-spatial-operations-1, message=FALSE, results='hide'-----------------------------------------------------------------------------------------------
library(sf)
library(terra)
library(dplyr)
library(spData)


## ----04-spatial-operations-1-1----------------------------------------------------------------------------------------------------------------------------
elev = rast(system.file("raster/elev.tif", package = "spData"))
grain = rast(system.file("raster/grain.tif", package = "spData"))


## It is important to note that spatial operations that use two spatial objects rely on both objects having the same coordinate reference system, a topic that was introduced in Section \@ref(crs-intro) and which will be covered in more depth in Chapter \@ref(reproj-geo-data).


## ----04-spatial-operations-3------------------------------------------------------------------------------------------------------------------------------
canterbury = nz |> filter(Name == "Canterbury")
canterbury_height = nz_height[canterbury, ]


## ----nz-subset, echo=FALSE, warning=FALSE, fig.cap="Illustration of spatial subsetting with red triangles representing 101 high points in New Zealand, clustered near the central Canterbuy region (left). The points in Canterbury were created with the `[` subsetting operator (highlighted in gray, right).", fig.scap="Illustration of spatial subsetting.", message=FALSE----
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


## ----04-spatial-operations-4, eval=FALSE------------------------------------------------------------------------------------------------------------------
## nz_height[canterbury, , op = st_disjoint]


## Note the empty argument --- denoted with `, ,` --- in the preceding code chunk is included to highlight `op`, the third argument in `[` for `sf` objects.

## One can use this to change the subsetting operation in many ways.

## `nz_height[canterbury, 2, op = st_disjoint]`, for example, returns the same rows but only includes the second attribute column (see `` sf:::`[.sf` `` and the `?sf` for details).


## ----04-spatial-operations-6------------------------------------------------------------------------------------------------------------------------------
sel_sgbp = st_intersects(x = nz_height, y = canterbury)
class(sel_sgbp)
sel_sgbp
sel_logical = lengths(sel_sgbp) > 0
canterbury_height2 = nz_height[sel_logical, ]


## Note: another way to return a logical output is by setting `sparse = FALSE` (meaning 'return a dense matrix not a sparse one') in operators such as `st_intersects()`. The command `st_intersects(x = nz_height, y = canterbury, sparse = FALSE)[, 1]`, for example, would return an output identical to `sel_logical`.

## Note: the solution involving `sgbp` objects is more generalisable though, as it works for many-to-many operations and has lower memory requirements.


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
canterbury_height3 = nz_height |>
  st_filter(y = canterbury, .predicate = st_intersects)


## ----04-spatial-operations-7b-old, eval=FALSE, echo=FALSE-------------------------------------------------------------------------------------------------
## # Additional tests of subsetting
## canterbury_height4 = nz_height |>
##   filter(st_intersects(x = _, y = canterbury, sparse = FALSE))
## canterbury_height5 = nz_height |>
##   filter(sel_logical)
## identical(canterbury_height3, canterbury_height4)
## identical(canterbury_height3, canterbury_height5)
## identical(canterbury_height2, canterbury_height4)
## identical(canterbury_height, canterbury_height4)
## waldo::compare(canterbury_height2, canterbury_height4)


## ----relations, echo=FALSE, fig.cap="Topological relations between vector geometries, inspired by Figures 1 and 2 in Egenhofer and Herring (1990). The relations for which the function(x, y) is true are printed for each geometry pair, with x represented in pink and y represented in blue. The nature of the spatial relationship for each pair is described by the Dimensionally Extended 9-Intersection Model string.", fig.show='hold', message=FALSE, fig.asp=0.66, warning=FALSE----
# source("https://github.com/Robinlovelace/geocompr/raw/c4-v2-updates-rl/code/de_9im.R")
source("code/de_9im.R")
library(sf)
xy2sfc = function(x, y) st_sfc(st_polygon(list(cbind(x, y))))
p1 = xy2sfc(x = c(0, 0, 1, 1,   0), y = c(0, 1, 1, 0.5, 0))
p2 = xy2sfc(x = c(0, 1, 1, 0), y = c(0, 0, 0.5, 0))
p3 = xy2sfc(x = c(0, 1, 1, 0), y = c(0, 0, 0.7, 0))
p4 = xy2sfc(x = c(0.7, 0.7, 0.9, 0.7), y = c(0.8, 0.5, 0.5, 0.8))
p5 = xy2sfc(x = c(0.6, 0.7, 1, 0.6), y = c(0.7, 0.5, 0.5, 0.7))
p6 = xy2sfc(x = c(0.1, 1, 1, 0.1), y = c(0, 0, 0.3, 0))
p7 = xy2sfc(x = c(0.05, 0.05, 0.6, 0.5, 0.05), y = c(0.4, 0.97, 0.97, 0.4, 0.4))

# todo: add 3 more with line/point relations?
tmap::tmap_arrange(de_9im(p1, p2), de_9im(p1, p3), de_9im(p1, p4),
                   de_9im(p7, p1), de_9im(p1, p5), de_9im(p1, p6), nrow = 2)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
polygon_matrix = cbind(
  x = c(0, 0, 1, 1,   0),
  y = c(0, 1, 1, 0.5, 0)
)
polygon_sfc = st_sfc(st_polygon(list(polygon_matrix)))


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
line_sfc = st_sfc(st_linestring(cbind(
  x = c(0.4, 1),
  y = c(0.2, 0.5)
)))
# create points
point_df = data.frame(
  x = c(0.2, 0.7, 0.4),
  y = c(0.1, 0.2, 0.8)
)
point_sf = st_as_sf(point_df, coords = c("x", "y"))


## ----relation-objects, echo=FALSE, fig.cap="Points (`point_df` 1 to 3), line and polygon objects arranged to illustrate topological relations.", fig.asp=1, out.width="50%", fig.scap="Demonstration of topological relations."----
par(pty = "s")
plot(polygon_sfc, border = "red", col = "gray", axes = TRUE)
plot(line_sfc, lwd = 5, add = TRUE)
plot(point_sf, add = TRUE, lab = 1:4, cex = 2)
text(point_df[, 1] + 0.02, point_df[, 2] + 0.04, 1:3, cex = 1.3)


## ----04-spatial-operations-9, eval=FALSE------------------------------------------------------------------------------------------------------------------
## st_intersects(point_sf, polygon_sfc)
## #> Sparse geometry binary predicate... `intersects'
## #>  1: 1
## #>  2: (empty)
## #>  3: 1


## ----04-spatial-operations-10-----------------------------------------------------------------------------------------------------------------------------
st_intersects(point_sf, polygon_sfc, sparse = FALSE)


## ----04-spatial-operations-9-2, eval=FALSE----------------------------------------------------------------------------------------------------------------
## st_within(point_sf, polygon_sfc)
## st_touches(point_sf, polygon_sfc)


## ----04-spatial-operations-11-----------------------------------------------------------------------------------------------------------------------------
st_disjoint(point_sf, polygon_sfc, sparse = FALSE)[, 1]


## ----04-spatial-operations-14-----------------------------------------------------------------------------------------------------------------------------
st_is_within_distance(point_sf, polygon_sfc, dist = 0.2, sparse = FALSE)[, 1]


## ---- eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
## # verify distances to the polygon with reference to paragraph above:
## st_distance(point_sf, polygon_sfc)
## #           [,1]
## # [1,] 0.0000000
## # [2,] 0.1341641
## # [3,] 0.0000000


## Functions for calculating topological relations use spatial indices to largely speed up spatial query performance.

## They achieve that using the Sort-Tile-Recursive (STR) algorithm.

## The `st_join` function, mentioned in the next section, also uses the spatial indexing.

## You can learn more at https://www.r-spatial.org/r/2017/06/22/spatial-index.html.


## ----04-spatial-operations-16, eval=FALSE, echo=FALSE-----------------------------------------------------------------------------------------------------
## # other tests
## st_overlaps(point_sf, polygon_sfc, sparse = FALSE)
## st_covers(point_sf, polygon_sfc, sparse = FALSE)
## st_covered_by(point_sf, polygon_sfc, sparse = FALSE)


## ----04-spatial-operations-17, eval=FALSE, echo=FALSE-----------------------------------------------------------------------------------------------------
## st_contains(a, p[2, ], sparse = TRUE)


## ----04-spatial-operations-18, eval=FALSE, echo=FALSE-----------------------------------------------------------------------------------------------------
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


## ----de-9im, echo=FALSE, eval=FALSE-----------------------------------------------------------------------------------------------------------------------
## # Todo one day: revive this
## b = st_sfc(st_point(c(0, 1)), st_point(c(1, 1))) # create 2 points
## b = st_buffer(b, dist = 1) # convert points to circles
## bsf = sf::st_sf(data.frame(Object = c("a", "b")), geometry = b)
## b9 = replicate(bsf, n = 9, simplify = FALSE)
## b9sf = do.call(rbind, b9)
## domains = c("Interior", "Boundary", "Exterior")
## b9sf$domain_a = rep(rep(domains, 3), each = 2)
## b9sf$domain_b = rep(rep(domains, each = 3), each = 2)
## library(ggplot2)
## ggplot(b9sf) +
##   geom_sf() +
##   facet_grid(domain_a ~ domain_b)
## 
## plot(b9sf)
## tmap_arrange(
##   tm_shape(b) + tm_polygons(alpha = 0.5) + tm_layout(title = "Interior-Interior"),
##   tm_shape(b) + tm_polygons(alpha = 0.5) + tm_layout(title = "Interior-Boundary"),
##   tm_shape(b) + tm_polygons(alpha = 0.5),
##   tm_shape(b) + tm_polygons(alpha = 0.5),
##   tm_shape(b) + tm_polygons(alpha = 0.5),
##   tm_shape(b) + tm_polygons(alpha = 0.5),
##   tm_shape(b) + tm_polygons(alpha = 0.5),
##   tm_shape(b) + tm_polygons(alpha = 0.5),
##   tm_shape(b) + tm_polygons(alpha = 0.5),
##   nrow = 3
## )
## 
## plot(b)
## text(x = c(-0.5, 1.5), y = 1, labels = c("x", "y")) # add text


## ----de9imgg, echo=FALSE, warning=FALSE, fig.cap="Illustration of how the Dimensionally Extended 9 Intersection Model (DE-9IM) works. Colors not in the legend represent the overlap between different components. The thick lines highlight 2 dimensional intesections, e.g. between the boundary of object x and the interior of object y, shown in the middle top facet.", message=FALSE----
p1_2 = st_as_sf(c(p1, p3))
ii = st_as_sf(st_intersection(p1, p3))
ii$Object = "Intersection"
ii$domain_a = "Interior"
ii$domain_b = "Interior"

bi = st_sf(x = st_intersection(
  st_cast(p1, "LINESTRING"),
  st_difference(p3, st_buffer(st_cast(p3, "LINESTRING"), dist = 0.01))
  ))
bi = st_buffer(bi, dist = 0.01)
bi$Object = "Intersection"
bi$domain_a = "Boundary"
bi$domain_b = "Interior"

ei = st_sf(x = st_difference(p3, p1))
ei$Object = "Intersection"
ei$domain_a = "Exterior"
ei$domain_b = "Interior"

ib = st_sf(x = st_intersection(
  st_cast(p3, "LINESTRING"),
  st_difference(p1, st_buffer(st_cast(p1, "LINESTRING"), dist = 0.005))
  ))
ib = st_buffer(ib, dist = 0.01)
ib$Object = "Intersection"
ib$domain_a = "Interior"
ib$domain_b = "Boundary"

bb = st_cast(ii, "POINT")
bb_line = st_sf(x = st_sfc(st_linestring(matrix(c(1, 0.5, 1, 0.7), nrow = 2, byrow = TRUE))))
bb_line_buffer = st_buffer(bb_line, dist = 0.01)
bb_buffer = st_buffer(bb, dist = 0.01)
bb = st_union(bb_buffer, bb_line_buffer)
bb$Object = "Intersection"
bb$domain_a = "Boundary"
bb$domain_b = "Boundary"

eb = st_sf(x = st_difference(
  st_cast(p3, "LINESTRING"),
  p1
  ))
eb = st_buffer(eb, dist = 0.01)
eb$Object = "Intersection"
eb$domain_a = "Exterior"
eb$domain_b = "Boundary"

ie = st_sf(x = st_difference(p1, p3))
ie$Object = "Intersection"
ie$domain_a = "Interior"
ie$domain_b = "Exterior"

be = st_sf(x = st_difference(
  st_cast(p1, "LINESTRING"),
  p3
  ))
be = st_buffer(be, dist = 0.01)
be$Object = "Intersection"
be$domain_a = "Boundary"
be$domain_b = "Exterior"

ee = st_sf(x = st_difference(
  st_buffer(st_union(p1, p3), 0.02),
  st_union(p1, p3)
  ))
ee$Object = "Intersection"
ee$domain_a = "Exterior"
ee$domain_b = "Exterior"

b9 = replicate(p1_2, n = 9, simplify = FALSE)
b9sf = do.call(rbind, b9)
b9sf$Object = rep(c("x", "y"), 9)
domains = c("Interior", "Boundary", "Exterior")
b9sf$domain_a = rep(rep(domains, 3), each = 2)
b9sf$domain_b = rep(rep(domains, each = 3), each = 2)
b9sf = rbind(b9sf, ii, bi, ei, ib, bb, eb, ie, be, ee)
b9sf$domain_a = ordered(b9sf$domain_a, levels = c("Interior", "Boundary", "Exterior"))
b9sf$domain_b = ordered(b9sf$domain_b, levels = c("Interior", "Boundary", "Exterior"))
b9sf = b9sf |> 
  mutate(alpha = case_when(
   Object == "x" ~ 0.1, 
   Object == "y" ~ 0.1, 
   TRUE ~ 0.2 
  ))
library(ggplot2)
ggplot(b9sf) +
  geom_sf(aes(fill = Object, alpha = alpha)) +
  facet_grid(domain_b ~ domain_a) +
  scale_fill_manual(values = c("red", "lightblue", "yellow"), position = "top", name = "") +
  scale_alpha_continuous(range = c(0.3, 0.9)) +
  guides(alpha = "none") +
  theme_void() +
  theme(legend.position = "top")


## ----de9emtable, echo=FALSE-------------------------------------------------------------------------------------------------------------------------------
# See https://github.com/Robinlovelace/geocompr/issues/699
pattern = st_relate(p1, p3)
matrix_de_9im = function(pattern) {
    string = unlist(strsplit(pattern , ""))
    matrix_de_9im = matrix(string, nrow = 3, byrow = TRUE)
    colnames(matrix_de_9im) = c("I", "B", "E")
    row.names(matrix_de_9im) = c("I", "B", "E")
    return(matrix_de_9im)
}

m = matrix_de_9im(pattern)
colnames(m) = c("Interior (x)", "Boundary (x)", "Exterior (x)")
rownames(m) = c("Interior (y)", "Boundary (y)", "Exterior (y)")
knitr::kable(m, caption = "Table showing relations between interiors, boundaries and exteriors of geometries x and y.")


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
xy2sfc = function(x, y) st_sfc(st_polygon(list(cbind(x, y))))
x = xy2sfc(x = c(0, 0, 1, 1,   0), y = c(0, 1, 1, 0.5, 0))
y = xy2sfc(x = c(0.7, 0.7, 0.9, 0.7), y = c(0.8, 0.5, 0.5, 0.8))
st_relate(x, y)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
st_queen = function(x, y) st_relate(x, y, pattern = "F***T****")
st_rook = function(x, y) st_relate(x, y, pattern = "F***1****")


## ----queenscode, fig.show='hide'--------------------------------------------------------------------------------------------------------------------------
grid = st_make_grid(x, n = 3)
grid_sf = st_sf(grid)
grid_sf$queens = lengths(st_queen(grid, grid[5])) > 0
plot(grid, col = grid_sf$queens)
grid_sf$rooks = lengths(st_rook(grid, grid[5])) > 0
plot(grid, col = grid_sf$rooks)


## ----queens, fig.cap="Demonstration of custom binary spatial predicates for finding 'queen' (left) and 'rook' (right) relations to the central square in a grid with 9 geometries.", echo=FALSE, warning=FALSE----
tm_shape(grid_sf) +
  tm_fill(col = c("queens", "rooks"), palette = c("white", "black")) +
  tm_shape(grid_sf) +
  tm_borders(col = "grey", lwd = 2) +
  tm_layout(frame = FALSE, legend.show = FALSE,
            panel.labels = c("queen", "rook"))


## ---- echo=FALSE, eval=FALSE------------------------------------------------------------------------------------------------------------------------------
## st_lineoverlap = function(x, y) st_relate(x, y, pattern = "T*1******")
## line1 = st_sfc(st_linestring(cbind(
##   x = c(0, 0.8),
##   y = c(0, 0)
## )))
## line2 = st_sfc(st_linestring(cbind(
##   x = c(0.1, 0.5),
##   y = c(0, 0)
## )))
## line3 = st_sfc(st_linestring(cbind(
##   x = c(0, 0.5),
##   y = c(0, 0.2)
## )))
## st_queen(line1, line2)
## st_relate(line1, line2)
## st_relate(line1, line3)
## st_lineoverlap(line1, line2)
## st_lineoverlap(line1, line3)
## de_9im(line1, line2)
## # test the function
## rnet = pct::get_pct_rnet(region = "isle-of-wight")
## osm_net = osmextract::oe_get_network(place = "isle-of-wight", mode = "driving")
## sel = st_relate(rnet, osm_net, pattern = "T*1******")
## summary(lengths(sel) > 0)
## rnet_joined1 = st_join(rnet, osm_net, join = st_lineoverlap)
## rnet_joined2 = st_join(rnet, osm_net, join = st_relate, pattern = "T*1******")
## rnet_joined3 = st_join(rnet, osm_net)
## summary(is.na(rnet_joined1$osm_id))
## summary(is.na(rnet_joined2$osm_id))
## summary(is.na(rnet_joined3$osm_id))
## sel_relates = st_relate(rnet[1, ], osm_net)
## dim(sel_relates)
## sel_table = table(sel_relates)
## sel_table
## dim(sel_table)
## sel_restrictive = sel_relates[1, ] == "0F1FF0102"
## summary(sel_restrictive)
## nrow(osm_net)
## mapview::mapview(rnet[1, ]) + mapview::mapview(osm_net[sel_restrictive, ])
## 
## rnet_approx = rnet
## st_precision(rnet_approx) = 100
## head(st_coordinates(rnet_approx))
## 
## sel_relates = st_relate(rnet_approx[1, ], osm_net)
## dim(sel_relates)
## sel_table = table(sel_relates)
## sel_table
## 


## ----04-spatial-operations-19-----------------------------------------------------------------------------------------------------------------------------
set.seed(2018) # set seed for reproducibility
(bb = st_bbox(world)) # the world's bounds
random_df = data.frame(
  x = runif(n = 10, min = bb[1], max = bb[3]),
  y = runif(n = 10, min = bb[2], max = bb[4])
)
random_points = random_df |> 
  st_as_sf(coords = c("x", "y")) |> # set coordinates
  st_set_crs("EPSG:4326") # set geographic CRS


## ----04-spatial-operations-20, message=FALSE--------------------------------------------------------------------------------------------------------------
world_random = world[random_points, ]
nrow(world_random)
random_joined = st_join(random_points, world["name_long"])


## ----spatial-join, echo=FALSE, fig.cap="Illustration of a spatial join. A new attribute variable is added to random points (top left) from source world object (top right) resulting in the data represented in the final panel.", fig.asp=0.5, warning=FALSE, message=FALSE, out.width="100%", fig.scap="Illustration of a spatial join."----
# source("https://github.com/Robinlovelace/geocompr/raw/main/code/04-spatial-join.R")
source("code/04-spatial-join.R")
tmap_arrange(jm1, jm2, jm3, jm4, nrow = 2, ncol = 2)


## ----04-spatial-operations-21, eval=FALSE-----------------------------------------------------------------------------------------------------------------
## plot(st_geometry(cycle_hire), col = "blue")
## plot(st_geometry(cycle_hire_osm), add = TRUE, pch = 3, col = "red")


## ----04-spatial-operations-22, message=FALSE--------------------------------------------------------------------------------------------------------------
any(st_touches(cycle_hire, cycle_hire_osm, sparse = FALSE))


## ----04-spatial-operations-23, echo=FALSE, eval=FALSE-----------------------------------------------------------------------------------------------------
## # included to show alternative ways of showing there's no overlap
## sum(st_geometry(cycle_hire) %in% st_geometry(cycle_hire_osm))
## sum(st_coordinates(cycle_hire)[, 1] %in% st_coordinates(cycle_hire_osm)[, 1])


## ----cycle-hire, fig.cap="The spatial distribution of cycle hire points in London based on official data (blue) and OpenStreetMap data (red).", echo=FALSE, warning=FALSE, fig.scap="The spatial distribution of cycle hire points in London."----
if (knitr::is_latex_output()){
  knitr::include_graphics("figures/cycle-hire-1.png")
} else if (knitr::is_html_output()){
  # library(tmap)
  # osm_tiles = tmaptools::read_osm(tmaptools::bb(cycle_hire, ext = 1.3), type =   "https://korona.geog.uni-heidelberg.de/tiles/roadsg/x={x}&y={y}&z={z}")
  # qtm(osm_tiles) +
    # tm_shape(cycle_hire) +
    # tm_bubbles(col = "blue", alpha = 0.5, size = 0.2) +
    # tm_shape(cycle_hire_osm) +
    # tm_bubbles(col = "red", alpha = 0.5, size = 0.2) +
    # tm_scale_bar()
  library(leaflet)
  leaflet() |>
    # addProviderTiles(providers$OpenStreetMap.BlackAndWhite) |>
    addCircles(data = cycle_hire) |>
    addCircles(data = cycle_hire_osm, col = "red")  
}


## ----04-spatial-operations-24-----------------------------------------------------------------------------------------------------------------------------
sel = st_is_within_distance(cycle_hire, cycle_hire_osm, dist = 20)
summary(lengths(sel) > 0)


## ----04-spatial-operations-24-without-s2-test, eval=FALSE, echo=FALSE-------------------------------------------------------------------------------------
## sf::sf_use_s2(FALSE)
## sel = st_is_within_distance(cycle_hire, cycle_hire_osm, dist = 20)
## summary(lengths(sel) > 0)
## # still works: must be lwgeom or some other magic!


## ----04-spatial-operations-24-projected, eval=FALSE, echo=FALSE-------------------------------------------------------------------------------------------
## # This chunk contains the non-overlapping join on projected data, a step that is no longer needed:
## # Note that, before performing the relation, both objects are transformed into a projected CRS.
## # These projected objects are created below (note the affix `_P`, short for projected):
## cycle_hire_P = st_transform(cycle_hire, 27700)
## cycle_hire_osm_P = st_transform(cycle_hire_osm, 27700)
## sel = st_is_within_distance(cycle_hire_P, cycle_hire_osm_P, dist = 20)
## summary(lengths(sel) > 0)


## ----04-spatial-operations-25-----------------------------------------------------------------------------------------------------------------------------
z = st_join(cycle_hire, cycle_hire_osm, st_is_within_distance, dist = 20)
nrow(cycle_hire)
nrow(z)


## ----04-spatial-operations-26-----------------------------------------------------------------------------------------------------------------------------
z = z |> 
  group_by(id) |> 
  summarize(capacity = mean(capacity))
nrow(z) == nrow(cycle_hire)


## ----04-spatial-operations-27, eval=FALSE-----------------------------------------------------------------------------------------------------------------
## plot(cycle_hire_osm["capacity"])
## plot(z["capacity"])


## ----04-spatial-operations-28-----------------------------------------------------------------------------------------------------------------------------
nz_agg = aggregate(x = nz_height, by = nz, FUN = mean)


## ----spatial-aggregation, echo=FALSE, fig.cap="Average height of the top 101 high points across the regions of New Zealand.", fig.asp=1, message=FALSE, out.width="50%"----
library(tmap)
tm_shape(nz_agg) +
  tm_fill("elevation", breaks = seq(27, 30, by = 0.5) * 1e2) +
  tm_borders()


## ----04-spatial-operations-29-----------------------------------------------------------------------------------------------------------------------------
nz_agg2 = st_join(x = nz, y = nz_height) |>
  group_by(Name) |>
  summarize(elevation = mean(elevation, na.rm = TRUE))


## ----test-tidy-spatial-join, eval=FALSE, echo=FALSE-------------------------------------------------------------------------------------------------------
## plot(nz_agg)
## plot(nz_agg2)
## # aggregate looses the name of aggregating objects


## ----areal-example, echo=FALSE, fig.cap="Illustration of congruent (left) and incongruent (right) areal units with respect to larger aggregating zones (translucent blue borders).", fig.asp=0.2, fig.scap="Illustration of congruent and incongruent areal units."----
source("https://github.com/Robinlovelace/geocompr/raw/main/code/04-areal-example.R", print.eval = TRUE)


## ----04-spatial-operations-30-----------------------------------------------------------------------------------------------------------------------------
iv = incongruent["value"] # keep only the values to be transferred
agg_aw = st_interpolate_aw(iv, aggregating_zones, extensive = TRUE)
agg_aw$value


## ----04-spatial-operations-31, warning=FALSE--------------------------------------------------------------------------------------------------------------
nz_highest = nz_height |> slice_max(n = 1, order_by = elevation)
canterbury_centroid = st_centroid(canterbury)
st_distance(nz_highest, canterbury_centroid)


## ----04-spatial-operations-32-----------------------------------------------------------------------------------------------------------------------------
co = filter(nz, grepl("Canter|Otag", Name))
st_distance(nz_height[1:3, ], co)


## ----04-spatial-operations-33, eval=FALSE-----------------------------------------------------------------------------------------------------------------
## plot(st_geometry(co)[2])
## plot(st_geometry(nz_height)[2:3], add = TRUE)


## ----04-spatial-operations-34, eval = FALSE---------------------------------------------------------------------------------------------------------------
## id = cellFromXY(elev, xy = matrix(c(0.1, 0.1), ncol = 2))
## elev[id]
## # the same as
## terra::extract(elev, matrix(c(0.1, 0.1), ncol = 2))


## ----04-spatial-operations-35, eval=FALSE-----------------------------------------------------------------------------------------------------------------
## clip = rast(xmin = 0.9, xmax = 1.8, ymin = -0.45, ymax = 0.45,
##             resolution = 0.3, vals = rep(1, 9))
## elev[clip]
## # we can also use extract
## # terra::extract(elev, ext(clip))


## ----raster-subset, echo = FALSE, fig.cap = "Original raster (left). Raster mask (middle). Output of masking a raster (right).", fig.scap="Subsetting raster values."----
knitr::include_graphics("figures/04_raster_subset.png")


## ----04-spatial-operations-36, eval=FALSE-----------------------------------------------------------------------------------------------------------------
## elev[1:2, drop = FALSE]    # spatial subsetting with cell IDs
## #> class       : SpatRaster
## #> dimensions  : 1, 2, 1  (nrow, ncol, nlyr)
## #> ...


## ----04-spatial-operations-37, echo=FALSE, eval=FALSE-----------------------------------------------------------------------------------------------------
## # aim: illustrate the result of previous spatial subsetting example
## x = elev[1, 1:2, drop = FALSE]
## plot(x)


## ----04-spatial-operations-38, eval=FALSE-----------------------------------------------------------------------------------------------------------------
## # create raster mask
## rmask = elev
## values(rmask) = sample(c(NA, TRUE), 36, replace = TRUE)


## ----04-spatial-operations-38b, eval=FALSE----------------------------------------------------------------------------------------------------------------
## # spatial subsetting
## elev[rmask, drop = FALSE]           # with [ operator
## mask(elev, rmask)                   # with mask()


## ----04-spatial-operations-38c, eval=FALSE----------------------------------------------------------------------------------------------------------------
## elev[elev < 20] = NA


## ----04-spatial-operations-41, eval = FALSE---------------------------------------------------------------------------------------------------------------
## elev + elev
## elev^2
## log(elev)
## elev > 5


## ----04-local-operations, echo=FALSE, fig.cap="Examples of different local operations of the elev raster object: adding two rasters, squaring, applying logarithmic transformation, and performing a logical operation."----
knitr::include_graphics("figures/04-local-operations.png")


## ----04-spatial-operations-40-----------------------------------------------------------------------------------------------------------------------------
rcl = matrix(c(0, 12, 1, 12, 24, 2, 24, 36, 3), ncol = 3, byrow = TRUE)
rcl


## ----04-spatial-operations-40b, eval = FALSE--------------------------------------------------------------------------------------------------------------
## recl = classify(elev, rcl = rcl)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
multi_raster_file = system.file("raster/landsat.tif", package = "spDataLarge")
multi_rast = rast(multi_raster_file)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
ndvi_fun = function(nir, red){
  (nir - red) / (nir + red)
}


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
ndvi_rast = lapp(multi_rast[[c(4, 3)]], fun = ndvi_fun)


## ----04-ndvi, echo=FALSE, fig.cap="RGB image (left) and NDVI values (right) calculated for the example satellite file of the Zion National Park"----------
knitr::include_graphics("figures/04-ndvi.png")


## ----04-spatial-operations-42, eval = FALSE---------------------------------------------------------------------------------------------------------------
## r_focal = focal(elev, w = matrix(1, nrow = 3, ncol = 3), fun = min)


## ----focal-example, echo = FALSE, fig.cap = "Input raster (left) and resulting output raster (right) due to a focal operation - finding the minimum value in 3-by-3 moving windows.", fig.scap="Illustration of a focal operation."----
knitr::include_graphics("figures/04_focal_example.png")


## ----04-spatial-operations-43-----------------------------------------------------------------------------------------------------------------------------
z = zonal(elev, grain, fun = "mean")
z


## ----04-spatial-operations-44, eval = FALSE---------------------------------------------------------------------------------------------------------------
## aut = geodata::elevation_30s(country = "AUT", path = tempdir())
## ch = geodata::elevation_30s(country = "CHE", path = tempdir())
## aut_ch = merge(aut, ch)


## ---- echo=FALSE, results='asis'--------------------------------------------------------------------------------------------------------------------------
res = knitr::knit_child('_04-ex.Rmd', quiet = TRUE, options = list(include = FALSE, eval = FALSE))
cat(res, sep = '\n')

