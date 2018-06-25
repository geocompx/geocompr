## ---- message=FALSE------------------------------------------------------
library(sf)
library(raster)
library(tidyverse)
library(spData)
library(spDataLarge)

## ------------------------------------------------------------------------
seine_simp = st_simplify(seine, dTolerance = 2000)  # 2000 m

## ----seine-simp, echo=FALSE, fig.cap="Comparison of the original and simplified `seine` geometry.", warning=FALSE----
library(tmap)
p_simp1 = tm_shape(seine) + tm_lines() +
  tm_layout(title = "Original data")
p_simp2 = tm_shape(seine_simp) + tm_lines() +
  tm_layout(title = "st_simplify")
tmap_arrange(p_simp1, p_simp2, ncol = 2)

## ------------------------------------------------------------------------
object.size(seine)
object.size(seine_simp)

## ------------------------------------------------------------------------
us_states2163 = st_transform(us_states, 2163)

## ------------------------------------------------------------------------
us_states_simp1 = st_simplify(us_states2163, dTolerance = 100000)  # 100 km

## ---- warning=FALSE------------------------------------------------------
# proportion of points to retain (0-1; default 0.05)
us_states2163$AREA = as.numeric(us_states2163$AREA)    
us_states_simp2 = rmapshaper::ms_simplify(us_states2163, keep = 0.01,
                                          keep_shapes = TRUE)

## ----us-simp, echo=FALSE, fig.cap="Polygon simplification in action, comparing the original geometry of the contiguous United States with simplified versions, generated with functions from **sf** (center) and **rmapshaper** (right) packages.", warning=FALSE----
library(tmap)
p_ussimp1 = tm_shape(us_states2163) + tm_polygons() + tm_layout(title = "Original data")
p_ussimp2 = tm_shape(us_states_simp1) + tm_polygons() + tm_layout(title = "st_simplify")
p_ussimp3 = tm_shape(us_states_simp2) + tm_polygons() + tm_layout(title = "ms_simplify")
tmap_arrange(p_ussimp1, p_ussimp2, p_ussimp3, ncol = 3)

## ---- warning=FALSE------------------------------------------------------
nz_centroid = st_centroid(nz)
seine_centroid = st_centroid(seine)

## ---- warning=FALSE------------------------------------------------------
nz_pos = st_point_on_surface(nz)
seine_pos = st_point_on_surface(seine)

## ----centr, warning=FALSE, echo=FALSE, fig.cap="Centroids (black points) and 'points on surface' (red points) of New Zeleand's regions (left) and the Seine (right) datasets."----
p_centr1 = tm_shape(nz) + tm_borders() +
  tm_shape(nz_centroid) + tm_symbols(shape = 1, col = "black", size = 0.5) +
  tm_shape(nz_pos) + tm_symbols(shape = 1, col = "red", size = 0.5)  
p_centr2 = tm_shape(seine) + tm_lines() +
  tm_shape(seine_centroid) + tm_symbols(shape = 1, col = "black", size = 0.5) +
  tm_shape(seine_pos) + tm_symbols(shape = 1, col = "red", size = 0.5)  
tmap_arrange(p_centr1, p_centr2, ncol = 2)

## ------------------------------------------------------------------------
seine_buff_5km = st_buffer(seine, dist = 5000)
seine_buff_50km = st_buffer(seine, dist = 50000)

## ----buffs, echo=FALSE, fig.cap="Buffers around the `seine` datasets of 5km (left) and 50km (right). Note the colors, which reflect the fact that one buffer is created per geometry feature.", fig.show='hold', out.width="50%"----
p_buffs1 = tm_shape(seine_buff_5km) + tm_polygons(col = "name") +
  tm_shape(seine) + tm_lines() +
  tm_layout(title = "5 km buffer", legend.show = FALSE)
p_buffs2 = tm_shape(seine_buff_50km) + tm_polygons(col = "name") +
  tm_shape(seine) + tm_lines() +
  tm_layout(title = "50 km buffer", legend.show = FALSE)
tmap_arrange(p_buffs1, p_buffs2, ncol = 2)

## The third and final argument of `st_buffer()` is `nQuadSegs`, which means 'number of segments per quadrant' and is set by default to 30 (meaning circles created by buffers are composed of $4 \times 30 = 120$ lines).

## ----nQuadSegs, eval=FALSE, echo=FALSE-----------------------------------
## # Demonstrate nQuadSegs
## seine_buff_simple = st_buffer(seine, dist = 50000, nQuadSegs = 3)
## plot(seine_buff_simple, key.pos = NULL, main = "50 km buffer")
## plot(seine, key.pos = NULL, lwd = 3, pal = rainbow, add = TRUE)
## seine_points = st_cast(seine[1, ], "POINT")
## buff_single = st_buffer(seine_points[1, ], 50000, 2)
## buff_points = st_cast(buff_single, "POINT")
## plot(st_geometry(buff_single), add = TRUE)

## ------------------------------------------------------------------------
nz_sfc = st_geometry(nz)

## ------------------------------------------------------------------------
nz_shift = nz_sfc + c(0, 100000)

## ---- echo=FALSE,eval=FALSE----------------------------------------------
## nz_scale0 = nz_sfc * 0.5

## ------------------------------------------------------------------------
nz_centroid_sfc = st_centroid(nz_sfc)
nz_scale = (nz_sfc - nz_centroid_sfc) * 0.5 + nz_centroid_sfc

## ------------------------------------------------------------------------
rotation = function(a){
  r = a * pi/180 #degrees to radians
  matrix(c(cos(r), sin(r), -sin(r), cos(r)), nrow = 2, ncol = 2)
} 

## ------------------------------------------------------------------------
nz_rotate = (nz_sfc - nz_centroid_sfc) * rotation(30) + nz_centroid_sfc

## ----affine-trans, echo=FALSE, fig.cap="Illustrations of affine transformations: shift, scale and rotate.", warning=FALSE, eval=TRUE----
p_at1 = tm_shape(nz_sfc) + tm_polygons() +
  tm_shape(nz_shift) + tm_polygons(col = "red") +
  tm_layout(title = "Shift")
p_at2 = tm_shape(nz_sfc) + tm_polygons() +
  tm_shape(nz_scale) + tm_polygons(col = "red") +
  tm_layout(title = "Scale")
p_at3 = tm_shape(nz_sfc) + tm_polygons() +
  tm_shape(nz_rotate) + tm_polygons(col = "red") +
  tm_layout(title = "Rotate")
tmap_arrange(p_at1, p_at2, p_at3, ncol = 3)

## ---- echo=FALSE,eval=FALSE----------------------------------------------
## nz_scale_rotate = (nz_sfc - nz_centroid_sfc) * 0.25 * rotation(90) + nz_centroid_sfc

## ---- echo=FALSE,eval=FALSE----------------------------------------------
## shearing = function(hx, hy){
##   matrix(c(1, hy, hx, 1), nrow = 2, ncol = 2)
## }
## nz_shear = (nz_sfc - nz_centroid_sfc) * shearing(1.1, 0) + nz_centroid_sfc

## ---- echo=FALSE,eval=FALSE----------------------------------------------
## plot(nz_sfc)
## plot(nz_shear, add = TRUE, col = "red")

## ------------------------------------------------------------------------
nz_scale_sf = st_set_geometry(nz, nz_scale)

## ----points, fig.cap="Overlapping circles."------------------------------
b = st_sfc(st_point(c(0, 1)), st_point(c(1, 1))) # create 2 points
b = st_buffer(b, dist = 1) # convert points to circles
l = c("x", "y")
plot(b)
text(x = c(-0.5, 1.5), y = 1, labels = l) # add text

## ------------------------------------------------------------------------
x = b[1]
y = b[2]
x_and_y = st_intersection(x, y)
plot(b)
plot(x_and_y, col = "lightgrey", add = TRUE) # color intersecting area

## ----venn-clip, echo=FALSE, fig.cap="Spatial equivalents of logical operators.", warning=FALSE----
source("code/05-venn-clip.R")

## ----venn-subset, fig.cap="Randomly distributed points within the bounding box enclosing circles x and y."----
bb = st_bbox(st_union(x, y))
pmat = matrix(c(bb[c(1, 2, 3, 2, 3, 4, 1, 4, 1, 2)]), ncol = 2, byrow = TRUE)
box = st_polygon(list(pmat))
set.seed(2017)
p = st_sample(x = box, size = 10)
plot(box)
plot(x, add = TRUE)
plot(y, add = TRUE)
plot(p, add = TRUE)
text(x = c(-0.5, 1.5), y = 1, labels = l)

## ------------------------------------------------------------------------
sel_p_xy = st_intersects(p, x, sparse = FALSE)[, 1] &
  st_intersects(p, y, sparse = FALSE)[, 1]
p_xy1 = p[sel_p_xy]
p_xy2 = p[x_and_y]
identical(p_xy1, p_xy2)

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## # An alternative way to sample from the bb
## bb = st_bbox(st_union(x, y))
## pmulti = st_multipoint(pmat)
## box = st_convex_hull(pmulti)

## ------------------------------------------------------------------------
regions = aggregate(x = us_states[, "total_pop_15"], by = list(us_states$REGION),
                    FUN = sum, na.rm = TRUE)
regions2 = us_states %>% group_by(REGION) %>%
  summarize(pop = sum(total_pop_15, na.rm = TRUE))

## ---- echo=FALSE---------------------------------------------------------
# st_join(buff, africa[, "pop"]) %>%
#   summarize(pop = sum(pop, na.rm = TRUE))
# summarize(africa[buff, "pop"], pop = sum(pop, na.rm = TRUE))

## ----us-regions, fig.cap="Spatial aggregation on contiguous polygons, illustrated by aggregating the population of US states into regions, with population represented by color. Note the operation automatically dissolves boundaries between states.", echo=FALSE, warning=FALSE, fig.asp=0.2, out.width="100%"----
source("code/05-us-regions.R", print.eval = TRUE)

## ------------------------------------------------------------------------
us_west = us_states[us_states$REGION == "West", ]
us_west_union = st_union(us_west)

## ---- message=FALSE------------------------------------------------------
texas = us_states[us_states$NAME == "Texas", ]
texas_union = st_union(us_west_union, texas)

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## plot(texas_union)
## # aim: experiment with st_union
## us_south2 = st_union(us_west[1, ], us_west[6, ])
## plot(us_southhwest)

## ------------------------------------------------------------------------
multipoint = st_multipoint(matrix(c(1, 3, 5, 1, 3, 1), ncol = 2))

## ------------------------------------------------------------------------
linestring = st_cast(multipoint, "LINESTRING")
polyg = st_cast(multipoint, "POLYGON")

## ----single-cast, echo = FALSE, fig.cap="Examples of linestring and polygon 'casted' from a multipoint geometry.", warning=FALSE----
p_sc1 = tm_shape(st_sfc(multipoint)) + tm_symbols(shape = 1, col = "black", size = 0.5) +
  tm_layout(title = "MULTIPOINT", inner.margins = c(0.05, 0.05, 0.05, 0.05))
p_sc2 = tm_shape(st_sfc(linestring)) + tm_lines() +
  tm_layout(title = "LINESTRING")
p_sc3 = tm_shape(st_sfc(polyg)) + tm_polygons(border.col = "black") +
  tm_layout(title = "POLYGON")
tmap_arrange(p_sc1, p_sc2, p_sc3, ncol = 3)

## ------------------------------------------------------------------------
multipoint_2 = st_cast(linestring, "MULTIPOINT")
multipoint_3 = st_cast(polyg, "MULTIPOINT")
all.equal(multipoint, multipoint_2, multipoint_3)

## For single simple feature geometries (`sfg`), `st_cast` also provides geometry casting from non-multi to multi types (e.g. `POINT` to `MULTIPOINT`) and from multi types to non-multi types.

## ---- include=FALSE------------------------------------------------------
cast_all = function(xg) {
  lapply(c("MULTIPOLYGON", "MULTILINESTRING", "MULTIPOINT", "POLYGON", "LINESTRING", "POINT"), 
         function(x) st_cast(xg, x))
}
t = cast_all(multipoint)
t2 = cast_all(polyg)

## ------------------------------------------------------------------------
multilinestring_list = list(matrix(c(1, 4, 5, 3), ncol = 2), 
                            matrix(c(4, 4, 4, 1), ncol = 2),
                            matrix(c(2, 4, 2, 2), ncol = 2))
multilinestring = st_multilinestring((multilinestring_list))
multilinestring_sf = st_sf(geom = st_sfc(multilinestring))
multilinestring_sf

## ------------------------------------------------------------------------
linestring_sf2 = st_cast(multilinestring_sf, "LINESTRING")
linestring_sf2

## ----line-cast, echo=FALSE, fig.cap="Examples of type casting between MULTILINESTRING (left) and LINESTRING (right).", warning=FALSE----
p_lc1 = tm_shape(multilinestring_sf) + tm_lines(lwd = 2) +
  tm_layout(title = "MULTILINESTRING")
linestring_sf2$name = c("Riddle Rd", "Marshall Ave", "Foulke St")
p_lc2 = tm_shape(linestring_sf2) + tm_lines(lwd = 2, col = "name", palette = "Set2") +
  tm_layout(title = "LINESTRING", legend.show = FALSE)
tmap_arrange(p_lc1, p_lc2, ncol = 2)

## ------------------------------------------------------------------------
linestring_sf2$name = c("Riddle Rd", "Marshall Ave", "Foulke St")
linestring_sf2$length = st_length(linestring_sf2)
linestring_sf2

## ------------------------------------------------------------------------
data("elev", package = "spData")
clip = raster(nrow = 3, ncol = 3, res = 0.3, xmn = 0.9, xmx = 1.8, 
              ymn = -0.45, ymx = 0.45, vals = rep(1, 9))
elev[clip, drop = FALSE]

## ----extend-example, fig.cap = "Original raster extended by 1 one row on each side (top, bottom) and two columns on each side (right, left)."----
data(elev, package = "spData")
elev_2 = extend(elev, c(1, 2), value = 1000)
plot(elev_2)

## ------------------------------------------------------------------------
elev_3 = elev + elev_2

## ------------------------------------------------------------------------
elev_4 = extend(elev, elev_2)

## ------------------------------------------------------------------------
origin(elev_4)

## ----origin-example, fig.cap = "Plotting rasters with the same values but different origins."----
# change the origin
origin(elev_4) = c(0.25, 0.25)
plot(elev_4)
# and add the original raster
plot(elev, add = TRUE)

## ----aggregate-example, fig.cap = "Original raster (left). Aggregated raster (right)."----
data("dem", package = "RQGIS")
dem_agg = aggregate(dem, fact = 5, fun = mean)
par(mfrow = c(1, 2))
plot(dem)
plot(dem_agg)

## ------------------------------------------------------------------------
dem_disagg = disaggregate(dem_agg, fact = 5, method = "bilinear")
identical(dem, dem_disagg)

## ----bilinear, echo = FALSE, fig.width=8, fig.height=10, fig.cap="The distance-weighted average of the four closest input cells determine the output when using the bilinear method for disaggregation."----
data(elev, package = "spData")
elev_agg = aggregate(elev, fact = 2, fun = mean)
plot(extend(elev, 1, 0), col = NA, legend = FALSE)
plot(elev_agg, add = TRUE)
xy_1 = xyFromCell(elev, 1)
xy_2 = xyFromCell(elev_agg, c(1, 2, 4, 5))
arrows(xy_2[, 1], xy_2[, 2], xy_1[, 1], xy_1[, 2], length = 0.1)
points(xy_1, pch = 16, col = "black")
points(xy_2, pch = 21, bg = "salmon", col = "black")
plot(rasterToPolygons(elev[1, drop = FALSE]), add = TRUE)

# spplot(elev_agg, col.regions = rev(terrain.colors(9)),
#        colorkey = FALSE, at = c(0, values(elev_agg + 1)), 
#         sp.layout = list(
#           list("sp.polygons", rasterToPolygons(elev[1, drop = FALSE]),
#                first = FALSE),
#           list("sp.points", SpatialPoints(xy_1), pch = 21, first = FALSE),
#           list("sp.points", SpatialPoints(xy_2), pch = 21, bg = "salmon", 
#                col = "black")
#           ))


## ------------------------------------------------------------------------
# add 2 rows and columns, i.e. change the extent
dem_agg = extend(dem_agg, 2)
dem_disagg_2 = resample(dem_agg, dem)

## ---- results='hide'-----------------------------------------------------
srtm = raster(system.file("raster/srtm.tif", package = "spDataLarge"))
zion = read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))
zion = st_transform(zion, projection(srtm))

## ------------------------------------------------------------------------
srtm_cropped = crop(srtm, as(zion, "Spatial"))

## ------------------------------------------------------------------------
srtm_masked = mask(srtm, as(zion, "Spatial"))

## ------------------------------------------------------------------------
srtm_inv_masked = mask(srtm, as(zion, "Spatial"), inverse = TRUE)

## ----cropmask, echo = FALSE, fig.cap="Illustration of raster cropping and raster masking."----
# TODO: split into reproducible script, e.g. in code/09-cropmask.R
library(tmap)
library(rcartocolor)
terrain_colors = carto_pal(7, "TealRose")
pz1 = tm_shape(srtm) + tm_raster(palette = terrain_colors, title = "Elevation (m)", legend.show = TRUE, style = "cont") + 
  tm_shape(zion) + tm_borders(lwd = 2) + 
  tm_layout(title = "A. Original", legend.frame = TRUE, legend.position = c("left", "bottom"))
pz2 = tm_shape(srtm_cropped) + tm_raster(palette = terrain_colors, title = "Elevation (m)", legend.show = TRUE, style = "cont") + 
  tm_shape(zion) + tm_borders(lwd = 2) + 
  tm_layout(title = "B. Crop", legend.frame = TRUE, legend.position = c("left", "bottom"))
pz3 = tm_shape(srtm_masked) + tm_raster(palette = terrain_colors, title = "Elevation (m)", legend.show = TRUE, style = "cont") + 
  tm_shape(zion) + tm_borders(lwd = 2) + 
  tm_layout(title = "C. Mask", legend.frame = TRUE, legend.position = c("left", "bottom"))
pz4 = tm_shape(srtm_inv_masked) + tm_raster(palette = terrain_colors, title = "Elevation (m)", legend.show = TRUE, style = "cont") + 
  tm_shape(zion) + tm_borders(lwd = 2) + 
  tm_layout(title = "D. Inverse\nmask", legend.frame = TRUE, legend.position = c("left", "bottom"))
tmap_arrange(pz1, pz2, pz3, pz4, ncol = 4)

## ------------------------------------------------------------------------
zion_points$elevation = raster::extract(srtm, as(zion_points, "Spatial"))

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## # Aim: demonstrate buffer arg in raster extract
## elev_b1 = raster::extract(srtm, as(zion_points, "Spatial"), buffer = 1000)

## ----pointextr, echo=FALSE, message=FALSE, warning=FALSE, fig.cap="Locations of points used for raster extraction."----
library(tmap)
library(grid)

rast_poly_point = tm_shape(srtm) +
  tm_raster(palette = terrain_colors, title = "Elevation (m)", 
            legend.show = TRUE, style = "cont") + 
  tm_shape(zion) +
  tm_borders(lwd = 2) + 
  tm_shape(zion_points) + 
  tm_symbols(shape = 1, col = "black") + 
  tm_layout(legend.frame = TRUE, legend.position = c("right", "top"))
rast_poly_point

## ------------------------------------------------------------------------
zion_transect = cbind(c(-113.2, -112.9), c(37.45, 37.2)) %>%
  st_linestring() %>% 
  st_sfc(crs = projection(srtm)) %>% 
  st_sf()

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # Aim: show how extraction works with non-straight lines by
## # using this alternative line object:
## zion_transect = cbind(c(-113.2, -112.9, -113.2), c(37.45, 37.2, 37.5)) %>%
##   st_linestring() %>%
##   st_sfc(crs = projection(srtm)) %>%
##   st_sf()

## ------------------------------------------------------------------------
transect = raster::extract(srtm, as(zion_transect, "Spatial"),
                           along = TRUE, cellnumbers = TRUE)

## ------------------------------------------------------------------------
transect_df = map_dfr(transect, as_data_frame, .id = "ID")
transect_coords = xyFromCell(srtm, transect_df$cell)
transect_df$dist = c(0, cumsum(geosphere::distGeo(transect_coords)))    

## ----lineextr, echo=FALSE, message=FALSE, warning=FALSE, fig.cap="Location of a line used for raster extraction (left) and the elevation along this line (right)."----
library(tmap)
library(grid)

zion_transect_points = st_cast(zion_transect, "POINT")[1:2, ]
zion_transect_points$name = c("start", "end")

rast_poly_line = tm_shape(srtm) +
  tm_raster(palette = terrain_colors, title = "Elevation (m)", 
            legend.show = TRUE, style = "cont") + 
  tm_shape(zion) +
  tm_borders(lwd = 2) + 
  tm_shape(zion_transect) + 
  tm_lines(col = "black", lwd = 4) + 
  tm_shape(zion_transect_points) +                                                 
  tm_text("name", bg.color = "white", bg.alpha = 0.75, auto.placement = TRUE) +
  tm_layout(legend.frame = TRUE, legend.position = c("right", "top"))

plot_transect = ggplot(transect_df, aes(dist, srtm)) + 
  geom_line() +
  labs(x = "Distance (m)", y = "Elevation (m a.s.l.)") + 
  theme_bw() +
  theme(plot.margin = unit(c(5.5, 15.5, 5.5, 5.5), "pt"))

grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2, heights = unit(c(0.25, 5), "null"))))
grid.text("A. Line extraction", vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
grid.text("B. Elevation along the line", vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(rast_poly_line, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(plot_transect, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # aim: create zion_many to test multi-polygon results
## n = 3
## zion_many = st_sample(x = zion, size = n) %>%
##   st_buffer(dist = 0.01) %>%
##   st_sf(data.frame(v = 1:n), geometry = .)
## plot(zion_many)
## 
## # for continuous data:
## zion_srtm_values = raster::extract(x = srtm, y = zion_many, df = TRUE)
## group_by(zion_srtm_values, ID) %>%
##   summarize_at(vars(srtm), funs(min, mean, max))
## 
## # for categories
## zion_nlcd = raster::extract(nlcd, zion_many, df = TRUE, factors = TRUE)
## dplyr::select(zion_nlcd, ID, levels) %>%
##   gather(key, value, -ID) %>%
##   group_by(ID, key, value) %>%
##   tally() %>%
##   spread(value, n, fill = 0)

## ------------------------------------------------------------------------
zion_srtm_values = raster::extract(x = srtm, y = as(zion, "Spatial"), df = TRUE)

## ------------------------------------------------------------------------
group_by(zion_srtm_values, ID) %>% 
  summarize_at(vars(srtm), funs(min, mean, max))

## ---- warning=FALSE, message=FALSE---------------------------------------
zion_nlcd = raster::extract(nlcd, as(zion, "Spatial"), df = TRUE, factors = TRUE)
dplyr::select(zion_nlcd, ID, levels) %>% 
  gather(key, value, -ID) %>%
  group_by(ID, key, value) %>%
  tally() %>% 
  spread(value, n, fill = 0)

## ----polyextr, echo=FALSE, message=FALSE, warning=FALSE, fig.cap="Area used for continuous (left) and categorical (right) raster extraction."----
rast_poly_srtm = tm_shape(srtm) + tm_raster(palette = terrain_colors, title = "Elevation (m)", legend.show = TRUE, style = "cont") + 
  tm_shape(zion) + tm_borders(lwd = 2) +
  tm_layout(title = "A. Continuous data extraction", legend.frame = TRUE, legend.position = c("left", "bottom"))
landcover_cols = c("#476ba0", "#aa0000", "#b2ada3", "#68aa63", "#a58c30", "#c9c977", "#dbd83d", "#bad8ea")
rast_poly_nlcd = tm_shape(nlcd) + tm_raster(col = "levels", palette = landcover_cols, style = "cat", title = "Land cover", legend.show = TRUE) + 
  tm_shape(zion) + tm_borders(lwd = 2) +
  tm_layout(title = "B. Categorical data extraction", legend.frame = TRUE, legend.position = c("left", "bottom"))
tmap_arrange(rast_poly_srtm, rast_poly_nlcd, ncol = 2)

## ------------------------------------------------------------------------
cycle_hire_osm_projected = st_transform(cycle_hire_osm, 27700)
raster_template = raster(extent(cycle_hire_osm_projected), resolution = 1000,
                         crs = st_crs(cycle_hire_osm_projected)$proj4string)

## ------------------------------------------------------------------------
ch_raster1 = rasterize(cycle_hire_osm_projected, raster_template, field = 1)

## ------------------------------------------------------------------------
ch_raster2 = rasterize(cycle_hire_osm_projected, raster_template, 
                       field = 1, fun = "count")

## ------------------------------------------------------------------------
ch_raster3 = rasterize(cycle_hire_osm_projected, raster_template, 
                       field = "capacity", fun = sum)

## ----vector-rasterization1, echo=FALSE, fig.cap="Examples of point's rasterization.", warning=FALSE----
source("code/05-vector-rasterization1.R")

## ------------------------------------------------------------------------
california = dplyr::filter(us_states, NAME == "California")
california_borders = st_cast(california, "MULTILINESTRING")
raster_template2 = raster(extent(california), resolution = 0.5,
                         crs = st_crs(california)$proj4string)

## ------------------------------------------------------------------------
california_raster1 = rasterize(as(california_borders, "Spatial"), raster_template2)

## ------------------------------------------------------------------------
california_raster2 = rasterize(as(california, "Spatial"), raster_template2)

## ----vector-rasterization2, echo=FALSE, fig.cap="Examples of line and polygon rasterizations.", warning=FALSE----
source("code/05-vector-rasterization2.R")

## Be careful with the wording!

## ------------------------------------------------------------------------
elev_point = rasterToPoints(elev, spatial = TRUE) %>% 
  st_as_sf()

## ----raster-vectorization1, echo=FALSE, fig.cap="Raster and point representation of `elev`.", warning=FALSE----
source("code/05-raster-vectorization1.R")

## ---- eval = FALSE-------------------------------------------------------
## # not shown
## data(dem, package = "RQGIS")
## plot(dem, axes = FALSE)
## contour(dem, add = TRUE)

## ----contour, echo=FALSE, message=FALSE, fig.cap = "DEM hillshade of the southern flank of Mt. Mongón overlaid with contour lines.", warning=FALSE----
library(tmap)
data("dem", package = "RQGIS")
# create hillshade
hs = hillShade(slope = terrain(dem, "slope"), aspect = terrain(dem, "aspect"))
# create contour
cn = rasterToContour(dem)
rect = tmaptools::bb_poly(hs)
bbx = tmaptools::bb(hs, xlim = c(-.02, 1), ylim = c(-.02, 1), relative = TRUE)

tm_shape(hs, bbox = rect) +
	tm_grid(col = "black", n.x = 2, n.y = 2, labels.inside.frame = FALSE,
	        labels.rot = c(0, 90)) +
	tm_raster(palette = gray(0:100 / 100), n = 100, legend.show = FALSE) +
	tm_shape(dem) +
	tm_raster(alpha = 0.5, palette = terrain.colors(25),
	          legend.show = FALSE) +
	tm_shape(cn) + 
	tm_lines(col = "white") +
	tm_text("level", col = "white") +
	qtm(rect, fill = NULL) +
	tm_layout(outer.margins = c(0.04, 0.04, 0.02, 0.02), frame = FALSE)

## ------------------------------------------------------------------------
grain_poly = rasterToPolygons(grain) %>% 
  st_as_sf()
grain_poly2 = grain_poly %>% 
  group_by(layer) %>%
  summarize()

## ----raster-vectorization2, echo=FALSE, fig.cap="Illustration of vectorization of raster (left) into polygon (center) and polygon aggregation (right).", warning=FALSE----
source("code/05-raster-vectorization2.R")

## ---- message=FALSE------------------------------------------------------
library(RQGIS)
data(random_points)
data(ndvi)
ch = st_combine(random_points) %>% 
  st_convex_hull()

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## plot(rmapshaper::ms_simplify(st_geometry(nz), keep = 1))
## plot(rmapshaper::ms_simplify(st_geometry(nz), keep = 0.5))
## plot(rmapshaper::ms_simplify(st_geometry(nz), keep = 0.05))
## # Starts to breakdown here at 0.5% of the points:
## plot(rmapshaper::ms_simplify(st_geometry(nz), keep = 0.005))
## # At this point no further simplification changes the result
## plot(rmapshaper::ms_simplify(st_geometry(nz), keep = 0.0005))
## plot(rmapshaper::ms_simplify(st_geometry(nz), keep = 0.00005))
## plot(st_simplify(st_geometry(nz), dTolerance = 100))
## plot(st_simplify(st_geometry(nz), dTolerance = 1000))
## # Starts to breakdown at 10 km:
## plot(st_simplify(st_geometry(nz), dTolerance = 10000))
## plot(st_simplify(st_geometry(nz), dTolerance = 100000))
## plot(st_simplify(st_geometry(nz), dTolerance = 100000, preserveTopology = TRUE))
## 
## plot(rmapshaper::ms_simplify(st_geometry(nz), keep = 0.05))
## plot(rmapshaper::ms_simplify(st_geometry(nz), keep = 0.05))
## 
## # Problem: st_simplify returns POLYGON and MULTIPOLYGON results, affecting plotting
## # Cast into a single geometry type to resolve this
## nz_simple_poly = st_simplify(st_geometry(nz), dTolerance = 10000) %>%
##   st_sfc() %>%
##   st_cast("POLYGON")
## nz_simple_multipoly = st_simplify(st_geometry(nz), dTolerance = 10000) %>%
##   st_sfc() %>%
##   st_cast("MULTIPOLYGON")
## plot(nz_simple_poly)
## length(nz_simple_poly)
## nrow(nz)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## canterbury = nz[nz$Name == "Canterbury Region", ]
## cant_buff = st_buffer(canterbury, 100)
## nz_height_near_cant = nz_height[cant_buff, ]
## nrow(nz_height_near_cant) # 66 - 5 more

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## cant_cent = st_centroid(canterbury)
## nz_centre = st_centroid(st_union(nz))
## st_distance(cant_cent, nz_centre) # 234 km

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## world_sfc = st_geometry(world)
## world_sfc_mirror = world_sfc * c(1, -1)
## plot(world_sfc)
## plot(world_sfc_mirror)
## 
## us_states_sfc = st_geometry(us_states)
## us_states_sfc_mirror = us_states_sfc * c(1, -1)
## plot(us_states_sfc)
## plot(us_states_sfc_mirror)
## ## nicer plot
## library(ggrepel)
## us_states_sfc_mirror_labels = st_centroid(us_states_sfc_mirror) %>%
##   st_coordinates() %>%
##   as_data_frame() %>%
##   mutate(name = us_states$NAME)
## us_states_sfc_mirror_sf = st_set_geometry(us_states, us_states_sfc_mirror)
## ggplot(data = us_states_sfc_mirror_sf) +
##   geom_sf(color = "white") +
##   geom_text_repel(data = us_states_sfc_mirror_labels, mapping = aes(X, Y, label = name), size = 3, min.segment.length = 0) +
##   theme_void()

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## p_in_y = p[y]
## p_in_xy = p_in_y[x]
## x_and_y = st_intersection(x, y)
## p[x_and_y]

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## us_states2163 = st_transform(us_states, 2163)
## us_states_bor = st_cast(us_states2163, "MULTILINESTRING")
## us_states_bor$borders = st_length(us_states_bor)
## arrange(us_states_bor, borders)
## arrange(us_states_bor, -borders)

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## nz_raster_low = raster::aggregate(nz_raster, fact = 2, fun = sum)
## res(nz_raster_low)
## nz_resample = resample(nz_raster_low, nz_raster)
## plot(nz_raster_low)
## plot(nz_resample) # the results are spread over a greater area and there are border issues
## plot(nz_raster)
## # advantage: lower memory use
## # advantage: faster processing
## # advantage: good for viz in some cases
## # disadvantage: removes geographic detail
## # disadvantage: another processing step

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## plot(ndvi)
## plot(st_geometry(random_points), add = TRUE)
## plot(ch, add = TRUE)
## 
## ndvi_crop1 = crop(ndvi, as(random_points, "Spatial"))
## ndvi_crop2 = crop(ndvi, as(ch, "Spatial"))
## plot(ndvi_crop1)
## plot(ndvi_crop2)
## 
## ndvi_mask1 = mask(ndvi, as(random_points, "Spatial"))
## ndvi_mask2 = mask(ndvi, as(ch, "Spatial"))
## plot(ndvi_mask1)
## plot(ndvi_mask2)

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## random_points_buf = st_buffer(random_points, dist = 90)
## plot(ndvi)
## plot(st_geometry(random_points_buf), add = TRUE)
## plot(ch, add = TRUE)
## random_points$ndvi = extract(ndvi, as(random_points, "Spatial"), buffer = 90, fun = mean)
## random_points$ndvi2 = extract(ndvi, as(random_points, "Spatial"))
## plot(random_points$ndvi, random_points$ndvi2)

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## nz_height3100 = dplyr::filter(nz_height, elevation > 3100)
## new_graticule = st_graticule(nz_height3100, datum = 2193)
## plot(st_geometry(nz_height3100), graticule = new_graticule, axes = TRUE)
## nz_template = raster(extent(nz_height3100), resolution = 3000,
##                          crs = st_crs(nz_height3100)$proj4string)
## nz_raster = rasterize(nz_height3100, nz_template,
##                        field = "elevation", fun = "count")
## plot(nz_raster)
## nz_raster2 = rasterize(nz_height3100, nz_template,
##                        field = "elevation", fun = max)
## plot(nz_raster2)

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## grain_poly = rasterToPolygons(grain) %>%
##   st_as_sf()
## levels(grain)
## clay = dplyr::filter(grain_poly, layer == 1)
## plot(clay)
## # advantages: can be used to subset other vector objects
## # can do affine transformations and use sf/dplyr verbs
## # disadvantages: better consistency, fast processing on some operations, functions developed for some domains

