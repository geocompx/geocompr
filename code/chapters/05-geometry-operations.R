## ----05-geometry-operations-1, message=FALSE-----------------------------
library(sf)
library(raster)
library(dplyr)
library(spData)
library(spDataLarge)

## ----05-geometry-operations-2--------------------------------------------
seine_simp = st_simplify(seine, dTolerance = 2000)  # 2000 m

## ----seine-simp, echo=FALSE, fig.cap="Comparison of the original and simplified `seine` geometry.", warning=FALSE, fig.scap="Simplification in action."----
library(tmap)
p_simp1 = tm_shape(seine) + tm_lines() +
  tm_layout(main.title = "Original data")
p_simp2 = tm_shape(seine_simp) + tm_lines() +
  tm_layout(main.title = "st_simplify")
tmap_arrange(p_simp1, p_simp2, ncol = 2)

## ----05-geometry-operations-3--------------------------------------------
object.size(seine)
object.size(seine_simp)

## ----05-geometry-operations-4--------------------------------------------
us_states2163 = st_transform(us_states, 2163)

## ----05-geometry-operations-5--------------------------------------------
us_states_simp1 = st_simplify(us_states2163, dTolerance = 100000)  # 100 km

## ----05-geometry-operations-6, warning=FALSE-----------------------------
# proportion of points to retain (0-1; default 0.05)
us_states2163$AREA = as.numeric(us_states2163$AREA)    
us_states_simp2 = rmapshaper::ms_simplify(us_states2163, keep = 0.01,
                                          keep_shapes = TRUE)

## ----us-simp, echo=FALSE, fig.cap="Polygon simplification in action, comparing the original geometry of the contiguous United States with simplified versions, generated with functions from sf (center) and rmapshaper (right) packages.", warning=FALSE, fig.asp=0.3, fig.scap="Polygon simplification in action."----
library(tmap)
p_ussimp1 = tm_shape(us_states2163) + tm_polygons() + tm_layout(main.title = "Original data")
p_ussimp2 = tm_shape(us_states_simp1) + tm_polygons() + tm_layout(main.title = "st_simplify")
p_ussimp3 = tm_shape(us_states_simp2) + tm_polygons() + tm_layout(main.title = "ms_simplify")
tmap_arrange(p_ussimp1, p_ussimp2, p_ussimp3, ncol = 3)

## ----05-geometry-operations-7, warning=FALSE-----------------------------
nz_centroid = st_centroid(nz)
seine_centroid = st_centroid(seine)

## ----05-geometry-operations-8, warning=FALSE-----------------------------
nz_pos = st_point_on_surface(nz)
seine_pos = st_point_on_surface(seine)

## ----centr, warning=FALSE, echo=FALSE, fig.cap="Centroids (black points) and 'points on surface' (red points) of New Zealand's regions (left) and the Seine (right) datasets.", fig.scap="Centroid vs point on surface operations."----
p_centr1 = tm_shape(nz) + tm_borders() +
  tm_shape(nz_centroid) + tm_symbols(shape = 1, col = "black", size = 0.5) +
  tm_shape(nz_pos) + tm_symbols(shape = 1, col = "red", size = 0.5)  
p_centr2 = tm_shape(seine) + tm_lines() +
  tm_shape(seine_centroid) + tm_symbols(shape = 1, col = "black", size = 0.5) +
  tm_shape(seine_pos) + tm_symbols(shape = 1, col = "red", size = 0.5)  
tmap_arrange(p_centr1, p_centr2, ncol = 2)

## ----05-geometry-operations-9--------------------------------------------
seine_buff_5km = st_buffer(seine, dist = 5000)
seine_buff_50km = st_buffer(seine, dist = 50000)

## ----buffs, echo=FALSE, fig.cap="Buffers around the Seine dataset of 5 km (left) and 50 km (right). Note the colors, which reflect the fact that one buffer is created per geometry feature.", fig.show='hold', out.width="75%", fig.scap="Buffers around the seine dataset."----
p_buffs1 = tm_shape(seine_buff_5km) + tm_polygons(col = "name") +
  tm_shape(seine) + tm_lines() +
  tm_layout(main.title = "5 km buffer", legend.show = FALSE)
p_buffs2 = tm_shape(seine_buff_50km) + tm_polygons(col = "name") +
  tm_shape(seine) + tm_lines() +
  tm_layout(main.title = "50 km buffer", legend.show = FALSE)
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

## ----05-geometry-operations-11-------------------------------------------
nz_sfc = st_geometry(nz)

## ----05-geometry-operations-12-------------------------------------------
nz_shift = nz_sfc + c(0, 100000)

## ----05-geometry-operations-13, echo=FALSE,eval=FALSE--------------------
## nz_scale0 = nz_sfc * 0.5

## ----05-geometry-operations-14-------------------------------------------
nz_centroid_sfc = st_centroid(nz_sfc)
nz_scale = (nz_sfc - nz_centroid_sfc) * 0.5 + nz_centroid_sfc

## ----05-geometry-operations-15-------------------------------------------
rotation = function(a){
  r = a * pi / 180 #degrees to radians
  matrix(c(cos(r), sin(r), -sin(r), cos(r)), nrow = 2, ncol = 2)
} 

## ----05-geometry-operations-16-------------------------------------------
nz_rotate = (nz_sfc - nz_centroid_sfc) * rotation(30) + nz_centroid_sfc

## ----affine-trans, echo=FALSE, fig.cap="Illustrations of affine transformations: shift, scale and rotate.", warning=FALSE, eval=TRUE, fig.scap="Illustrations of affine transformations."----
p_at1 = tm_shape(nz_sfc) + tm_polygons() +
  tm_shape(nz_shift) + tm_polygons(col = "red") +
  tm_layout(main.title = "Shift")
p_at2 = tm_shape(nz_sfc) + tm_polygons() +
  tm_shape(nz_scale) + tm_polygons(col = "red") +
  tm_layout(main.title = "Scale")
p_at3 = tm_shape(nz_sfc) + tm_polygons() +
  tm_shape(nz_rotate) + tm_polygons(col = "red") +
  tm_layout(main.title = "Rotate")
tmap_arrange(p_at1, p_at2, p_at3, ncol = 3)

## ----05-geometry-operations-17, echo=FALSE,eval=FALSE--------------------
## nz_scale_rotate = (nz_sfc - nz_centroid_sfc) * 0.25 * rotation(90) + nz_centroid_sfc

## ----05-geometry-operations-18, echo=FALSE,eval=FALSE--------------------
## shearing = function(hx, hy){
##   matrix(c(1, hy, hx, 1), nrow = 2, ncol = 2)
## }
## nz_shear = (nz_sfc - nz_centroid_sfc) * shearing(1.1, 0) + nz_centroid_sfc

## ----05-geometry-operations-19, echo=FALSE,eval=FALSE--------------------
## plot(nz_sfc)
## plot(nz_shear, add = TRUE, col = "red")

## ----05-geometry-operations-20-------------------------------------------
nz_scale_sf = st_set_geometry(nz, nz_scale)

## ----points, fig.cap="Overlapping circles.", fig.asp=1-------------------
b = st_sfc(st_point(c(0, 1)), st_point(c(1, 1))) # create 2 points
b = st_buffer(b, dist = 1) # convert points to circles
plot(b)
text(x = c(-0.5, 1.5), y = 1, labels = c("x", "y")) # add text

## ----circle-intersection, fig.cap="Overlapping circles with a gray color indicating intersection between them.", fig.asp=1, fig.scap="Overlapping circles showing intersection types."----
x = b[1]
y = b[2]
x_and_y = st_intersection(x, y)
plot(b)
plot(x_and_y, col = "lightgrey", add = TRUE) # color intersecting area

## ----venn-clip, echo=FALSE, fig.cap="Spatial equivalents of logical operators.", warning=FALSE----
source("https://github.com/Robinlovelace/geocompr/raw/master/code/05-venn-clip.R")

## ----venn-subset, fig.cap="Randomly distributed points within the bounding box enclosing circles x and y.", out.width="50%", fig.asp=1, fig.scap="Randomly distributed points within the bounding box."----
bb = st_bbox(st_union(x, y))
box = st_as_sfc(bb)
set.seed(2017)
p = st_sample(x = box, size = 10)
plot(box)
plot(x, add = TRUE)
plot(y, add = TRUE)
plot(p, add = TRUE)
text(x = c(-0.5, 1.5), y = 1, labels = c("x", "y"))

## ----05-geometry-operations-21-------------------------------------------
sel_p_xy = st_intersects(p, x, sparse = FALSE)[, 1] &
  st_intersects(p, y, sparse = FALSE)[, 1]
p_xy1 = p[sel_p_xy]
p_xy2 = p[x_and_y]
identical(p_xy1, p_xy2)

## ----05-geometry-operations-22, echo=FALSE, eval=FALSE-------------------
## # An alternative way to sample from the bb
## bb = st_bbox(st_union(x, y))
## pmulti = st_multipoint(pmat)
## box = st_convex_hull(pmulti)

## ----05-geometry-operations-23-------------------------------------------
regions = aggregate(x = us_states[, "total_pop_15"], by = list(us_states$REGION),
                    FUN = sum, na.rm = TRUE)
regions2 = us_states %>% group_by(REGION) %>%
  summarize(pop = sum(total_pop_15, na.rm = TRUE))

## ----05-geometry-operations-24, echo=FALSE-------------------------------
# st_join(buff, africa[, "pop"]) %>%
#   summarize(pop = sum(pop, na.rm = TRUE))
# summarize(africa[buff, "pop"], pop = sum(pop, na.rm = TRUE))

## ----us-regions, fig.cap="Spatial aggregation on contiguous polygons, illustrated by aggregating the population of US states into regions, with population represented by color. Note the operation automatically dissolves boundaries between states.", echo=FALSE, warning=FALSE, fig.asp=0.2, out.width="100%", fig.scap="Spatial aggregation on contiguous polygons."----
source("https://github.com/Robinlovelace/geocompr/raw/master/code/05-us-regions.R", print.eval = TRUE)

## ----05-geometry-operations-25-------------------------------------------
us_west = us_states[us_states$REGION == "West", ]
us_west_union = st_union(us_west)

## ----05-geometry-operations-26, message=FALSE----------------------------
texas = us_states[us_states$NAME == "Texas", ]
texas_union = st_union(us_west_union, texas)

## ----05-geometry-operations-27, echo=FALSE, eval=FALSE-------------------
## plot(texas_union)
## # aim: experiment with st_union
## us_south2 = st_union(us_west[1, ], us_west[6, ])
## plot(us_southhwest)

## ----05-geometry-operations-28-------------------------------------------
multipoint = st_multipoint(matrix(c(1, 3, 5, 1, 3, 1), ncol = 2))

## ----05-geometry-operations-29-------------------------------------------
linestring = st_cast(multipoint, "LINESTRING")
polyg = st_cast(multipoint, "POLYGON")

## ----single-cast, echo = FALSE, fig.cap="Examples of linestring and polygon casted from a multipoint geometry.", warning=FALSE, fig.asp=0.3, fig.scap="Examples of casting operations."----
p_sc1 = tm_shape(st_sfc(multipoint)) + tm_symbols(shape = 1, col = "black", size = 0.5) +
  tm_layout(main.title = "MULTIPOINT", inner.margins = c(0.05, 0.05, 0.05, 0.05))
p_sc2 = tm_shape(st_sfc(linestring)) + tm_lines() +
  tm_layout(main.title = "LINESTRING")
p_sc3 = tm_shape(st_sfc(polyg)) + tm_polygons(border.col = "black") +
  tm_layout(main.title = "POLYGON")
tmap_arrange(p_sc1, p_sc2, p_sc3, ncol = 3)

## ----05-geometry-operations-30-------------------------------------------
multipoint_2 = st_cast(linestring, "MULTIPOINT")
multipoint_3 = st_cast(polyg, "MULTIPOINT")
all.equal(multipoint, multipoint_2, multipoint_3)

## For single simple feature geometries (`sfg`), `st_cast` also provides geometry casting from non-multi-types to multi-types (e.g., `POINT` to `MULTIPOINT`) and from multi-types to non-multi-types.

## ----05-geometry-operations-32, include=FALSE----------------------------
cast_all = function(xg) {
  lapply(c("MULTIPOLYGON", "MULTILINESTRING", "MULTIPOINT", "POLYGON", "LINESTRING", "POINT"), 
         function(x) st_cast(xg, x))
}
t = cast_all(multipoint)
t2 = cast_all(polyg)

## ----sfs-st-cast, echo=FALSE---------------------------------------------
sfs_st_cast = read.csv("extdata/sfs-st-cast.csv")
abbreviate_geomtypes = function(geomtypes) {
  geomtypes_new = gsub(pattern = "POINT", replacement = "POI", x = geomtypes)
  geomtypes_new = gsub(pattern = "POLYGON", replacement = "POL", x = geomtypes_new)
  geomtypes_new = gsub(pattern = "LINESTRING", replacement = "LIN", x = geomtypes_new)
  geomtypes_new = gsub(pattern = "MULTI", replacement = "M", x = geomtypes_new)
  geomtypes_new = gsub(pattern = "GEOMETRYCOLLECTION", replacement = "GC", x = geomtypes_new)
  geomtypes_new
}
sfs_st_cast$input_geom = abbreviate_geomtypes(sfs_st_cast$input_geom)
names(sfs_st_cast) = abbreviate_geomtypes(names(sfs_st_cast))
names(sfs_st_cast)[1] = ""
knitr::kable(sfs_st_cast, 
             caption = paste("Geometry casting on simple feature geometries", 
                             "(see Section 2.1) with input type by row and", 
                             "output type by column. Values like (1) represent", 
                             "the number of features; NA means the operation", 
                             "is not possible.\nAbbreviations: POI, LIN, POL", 
                             "and GC refer to POINT, LINESTRING, POLYGON and", 
                             "GEOMETRYCOLLECTION. The MULTI version of these", 
                             "geometry types is indicated by a preceding M,", 
                             "e.g., MPOI is the acronym for MULTIPOINT."),
             caption.short = "Geometry casting on simple feature geometries.",
             booktabs = TRUE)

## ----05-geometry-operations-33-------------------------------------------
multilinestring_list = list(matrix(c(1, 4, 5, 3), ncol = 2), 
                            matrix(c(4, 4, 4, 1), ncol = 2),
                            matrix(c(2, 4, 2, 2), ncol = 2))
multilinestring = st_multilinestring((multilinestring_list))
multilinestring_sf = st_sf(geom = st_sfc(multilinestring))
multilinestring_sf

## ----05-geometry-operations-34-------------------------------------------
linestring_sf2 = st_cast(multilinestring_sf, "LINESTRING")
linestring_sf2

## ----line-cast, echo=FALSE, fig.cap="Examples of type casting between MULTILINESTRING (left) and LINESTRING (right).", warning=FALSE, fig.scap="Examples of type casting."----
p_lc1 = tm_shape(multilinestring_sf) + tm_lines(lwd = 3) +
  tm_layout(main.title = "MULTILINESTRING")
linestring_sf2$name = c("Riddle Rd", "Marshall Ave", "Foulke St")
p_lc2 = tm_shape(linestring_sf2) + tm_lines(lwd = 3, col = "name", palette = "Set2") +
  tm_layout(main.title = "LINESTRING", legend.show = FALSE)
tmap_arrange(p_lc1, p_lc2, ncol = 2)

## ----05-geometry-operations-35-------------------------------------------
linestring_sf2$name = c("Riddle Rd", "Marshall Ave", "Foulke St")
linestring_sf2$length = st_length(linestring_sf2)
linestring_sf2

## ----05-geometry-operations-36-------------------------------------------
data("elev", package = "spData")
clip = raster(xmn = 0.9, xmx = 1.8, ymn = -0.45, ymx = 0.45,
              res = 0.3, vals = rep(1, 9))
elev[clip, drop = FALSE]

## ----extend-example, fig.cap = "Original raster extended by one row on each side (top, bottom) and two columns on each side (right, left).", fig.scap="Extending rasters."----
data(elev, package = "spData")
elev_2 = extend(elev, c(1, 2), value = 1000)
plot(elev_2)

## ----05-geometry-operations-37-------------------------------------------
elev_3 = elev + elev_2

## ----05-geometry-operations-38-------------------------------------------
elev_4 = extend(elev, elev_2)

## ----05-geometry-operations-39-------------------------------------------
origin(elev_4)

## ----origin-example, fig.cap="Rasters with identical values but different origins."----
# change the origin
origin(elev_4) = c(0.25, 0.25)
plot(elev_4)
# and add the original raster
plot(elev, add = TRUE)

## ----05-geometry-operations-40-------------------------------------------
data("dem", package = "spDataLarge")
dem_agg = aggregate(dem, fact = 5, fun = mean)

## ----aggregate-example, fig.cap = "Original raster (left). Aggregated raster (right).", echo=FALSE----
p_ar1 = tm_shape(dem) + tm_raster(style = "cont", legend.show = FALSE) +
  tm_layout(main.title = "Original", frame = FALSE)
p_ar2 = tm_shape(dem_agg) + tm_raster(style = "cont", legend.show = FALSE) +
  tm_layout(main.title = "Aggregated", frame = FALSE)
tmap_arrange(p_ar1, p_ar2, ncol = 2)

## ----05-geometry-operations-41-------------------------------------------
dem_disagg = disaggregate(dem_agg, fact = 5, method = "bilinear")
identical(dem, dem_disagg)

## ----bilinear, echo = FALSE, fig.width=8, fig.height=10, fig.cap="The distance-weighted average of the four closest input cells determine the output when using the bilinear method for disaggregation.", fig.cap="Bilinear disaggregation in action."----
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


## ----05-geometry-operations-42-------------------------------------------
# add 2 rows and columns, i.e. change the extent
dem_agg = extend(dem_agg, 2)
dem_disagg_2 = resample(dem_agg, dem)

## ----05-geometry-operations-43, results='hide'---------------------------
srtm = raster(system.file("raster/srtm.tif", package = "spDataLarge"))
zion = st_read(system.file("vector/zion.gpkg", package = "spDataLarge"))
zion = st_transform(zion, projection(srtm))

## ----05-geometry-operations-44-------------------------------------------
srtm_cropped = crop(srtm, zion)

## ----05-geometry-operations-45-------------------------------------------
srtm_masked = mask(srtm, zion)

## ----05-geometry-operations-46-------------------------------------------
srtm_inv_masked = mask(srtm, zion, inverse = TRUE)

## ----cropmask, echo = FALSE, fig.cap="Illustration of raster cropping and raster masking.", fig.asp=0.36, fig.width = 10----
# TODO: split into reproducible script, e.g. in code/09-cropmask.R
library(tmap)
library(rcartocolor)
terrain_colors = carto_pal(7, "TealRose")
pz1 = tm_shape(srtm) + tm_raster(palette = terrain_colors, legend.show = FALSE, style = "cont") + 
  tm_shape(zion) + tm_borders(lwd = 2) + 
  tm_layout(main.title = "A. Original")
pz2 = tm_shape(srtm_cropped) + tm_raster(palette = terrain_colors, legend.show = FALSE, style = "cont") + 
  tm_shape(zion) + tm_borders(lwd = 2) + 
  tm_layout(main.title = "B. Crop")
pz3 = tm_shape(srtm_masked) + tm_raster(palette = terrain_colors, legend.show = FALSE, style = "cont") + 
  tm_shape(zion) + tm_borders(lwd = 2) + 
  tm_layout(main.title = "C. Mask")
pz4 = tm_shape(srtm_inv_masked) + tm_raster(palette = terrain_colors, legend.show = FALSE, style = "cont") + 
  tm_shape(zion) + tm_borders(lwd = 2) + 
  tm_layout(main.title = "D. Inverse mask")
tmap_arrange(pz1, pz2, pz3, pz4, ncol = 4)

## ----05-geometry-operations-47-------------------------------------------
data("zion_points", package = "spDataLarge")
zion_points$elevation = raster::extract(srtm, zion_points)

## ----05-geometry-operations-48, echo=FALSE, eval=FALSE-------------------
## # Aim: demonstrate buffer arg in raster extract
## elev_b1 = raster::extract(srtm, zion_points, buffer = 1000)

## ----pointextr, echo=FALSE, message=FALSE, warning=FALSE, fig.cap="Locations of points used for raster extraction.", fig.asp=0.57----
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

## ----05-geometry-operations-49-------------------------------------------
zion_transect = cbind(c(-113.2, -112.9), c(37.45, 37.2)) %>%
  st_linestring() %>% 
  st_sfc(crs = projection(srtm)) %>% 
  st_sf()

## ----05-geometry-operations-50, eval=FALSE, echo=FALSE-------------------
## # Aim: show how extraction works with non-straight lines by
## # using this alternative line object:
## zion_transect = cbind(c(-113.2, -112.9, -113.2), c(37.45, 37.2, 37.5)) %>%
##   st_linestring() %>%
##   st_sfc(crs = projection(srtm)) %>%
##   st_sf()

## ----05-geometry-operations-51-------------------------------------------
 transect = raster::extract(srtm, zion_transect, 
                            along = TRUE, cellnumbers = TRUE)

## ----05-geometry-operations-52-------------------------------------------
transect_df = purrr::map_dfr(transect, as_data_frame, .id = "ID")
transect_coords = xyFromCell(srtm, transect_df$cell)
transect_df$dist = c(0, cumsum(geosphere::distGeo(transect_coords)))    

## ----lineextr, echo=FALSE, message=FALSE, warning=FALSE, fig.cap="Location of a line used for raster extraction (left) and the elevation along this line (right).", fig.scap="Line-based raster extraction."----
library(tmap)
library(grid)
library(ggplot2)

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

## ----05-geometry-operations-53, eval=FALSE, echo=FALSE-------------------
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
##   tidyr::gather(key, value, -ID) %>%
##   group_by(ID, key, value) %>%
##   tally() %>%
##   tidyr::spread(value, n, fill = 0)

## ----05-geometry-operations-54-------------------------------------------
 zion_srtm_values = raster::extract(x = srtm, y = zion, df = TRUE) 

## ----05-geometry-operations-55-------------------------------------------
group_by(zion_srtm_values, ID) %>% 
  summarize_at(vars(srtm), funs(min, mean, max))

## ----05-geometry-operations-56, warning=FALSE, message=FALSE-------------
zion_nlcd = raster::extract(nlcd, zion, df = TRUE, factors = TRUE) 
dplyr::select(zion_nlcd, ID, levels) %>% 
  tidyr::gather(key, value, -ID) %>%
  group_by(ID, key, value) %>%
  tally() %>% 
  tidyr::spread(value, n, fill = 0)

## ----polyextr, echo=FALSE, message=FALSE, warning=FALSE, fig.cap="Area used for continuous (left) and categorical (right) raster extraction."----
rast_poly_srtm = tm_shape(srtm) + tm_raster(palette = terrain_colors, title = "Elevation (m)", legend.show = TRUE, style = "cont") + 
  tm_shape(zion) + tm_borders(lwd = 2) +
  tm_layout(main.title = "A. Continuous data extraction", main.title.size = 1, legend.frame = TRUE, legend.position = c("left", "bottom"))
landcover_cols = c("#476ba0", "#aa0000", "#b2ada3", "#68aa63", "#a58c30", "#c9c977", "#dbd83d", "#bad8ea")
rast_poly_nlcd = tm_shape(nlcd) + tm_raster(col = "levels", palette = landcover_cols, style = "cat", title = "Land cover", legend.show = TRUE) + 
  tm_shape(zion) + tm_borders(lwd = 2) +
  tm_layout(main.title = "B. Categorical data extraction", main.title.size = 1, legend.frame = TRUE, legend.position = c("left", "bottom"))
tmap_arrange(rast_poly_srtm, rast_poly_nlcd, ncol = 2)

## ----05-geometry-operations-57-------------------------------------------
cycle_hire_osm_projected = st_transform(cycle_hire_osm, 27700)
raster_template = raster(extent(cycle_hire_osm_projected), resolution = 1000,
                         crs = st_crs(cycle_hire_osm_projected)$proj4string)

## ----05-geometry-operations-58-------------------------------------------
ch_raster1 = rasterize(cycle_hire_osm_projected, raster_template, field = 1)

## ----05-geometry-operations-59-------------------------------------------
ch_raster2 = rasterize(cycle_hire_osm_projected, raster_template, 
                       field = 1, fun = "count")

## ----05-geometry-operations-60-------------------------------------------
ch_raster3 = rasterize(cycle_hire_osm_projected, raster_template, 
                       field = "capacity", fun = sum)

## ----vector-rasterization1, echo=FALSE, fig.cap="Examples of point rasterization.", warning=FALSE----
source("https://github.com/Robinlovelace/geocompr/raw/master/code/05-vector-rasterization1.R", print.eval = TRUE)

## ----05-geometry-operations-61-------------------------------------------
california = dplyr::filter(us_states, NAME == "California")
california_borders = st_cast(california, "MULTILINESTRING")
raster_template2 = raster(extent(california), resolution = 0.5,
                         crs = st_crs(california)$proj4string)

## ----05-geometry-operations-62-------------------------------------------
california_raster1 = rasterize(california_borders, raster_template2) 

## ----05-geometry-operations-63-------------------------------------------
california_raster2 = rasterize(california, raster_template2) 

## ----vector-rasterization2, echo=FALSE, fig.cap="Examples of line and polygon rasterizations.", warning=FALSE----
source("https://github.com/Robinlovelace/geocompr/raw/master/code/05-vector-rasterization2.R", print.eval = TRUE)

## Be careful with the wording!

## ----05-geometry-operations-65-------------------------------------------
elev_point = rasterToPoints(elev, spatial = TRUE) %>% 
  st_as_sf()

## ----raster-vectorization1, echo=FALSE, fig.cap="Raster and point representation of the elev object.", warning=FALSE----
source("https://github.com/Robinlovelace/geocompr/raw/master/code/05-raster-vectorization1.R", print.eval = TRUE)

## ----05-geometry-operations-66, eval = FALSE-----------------------------
## data(dem, package = "spDataLarge")
## cl = rasterToContour(dem)
## plot(dem, axes = FALSE)
## plot(cl, add = TRUE)

## ----contour, eval=FALSE, fig.cap="DEM with hillshading, showing the southern flank of Mt. Mongón overlaid with contour lines.", fig.scap="DEM with hillshading."----
## # create hillshade
## hs = hillShade(slope = terrain(dem, "slope"), aspect = terrain(dem, "aspect"))
## plot(hs, col = gray(0:100 / 100), legend = FALSE)
## # overlay with DEM
## plot(dem, col = terrain.colors(25), alpha = 0.5, legend = FALSE, add = TRUE)
## # add contour lines
## contour(dem, col = "white", add = TRUE)

## ----contour-tmap, echo=FALSE, message=FALSE, fig.cap="DEM hillshade of the southern flank of Mt. Mongón overlaid by contour lines.", warning=FALSE, fig.asp=0.56, fig.scap="Hillshade overlaid by contours."----
library(tmap)
data("dem", package = "spDataLarge")
# create hillshade
hs = hillShade(slope = terrain(dem, "slope"), aspect = terrain(dem, "aspect"))
# create contour
cn = rasterToContour(dem)
rect = tmaptools::bb_poly(hs)
bbx = tmaptools::bb(hs, xlim = c(-0.02, 1), ylim = c(-0.02, 1), relative = TRUE)

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

## ----05-geometry-operations-67-------------------------------------------
grain_poly = rasterToPolygons(grain) %>% 
  st_as_sf()
grain_poly2 = grain_poly %>% 
  group_by(layer) %>%
  summarize()

## ----raster-vectorization2, echo=FALSE, fig.cap="Illustration of vectorization of raster (left) into polygon (center) and polygon aggregation (right).", warning=FALSE, fig.asp=0.4, fig.scap="Illustration of vectorization."----
source("https://github.com/Robinlovelace/geocompr/raw/master/code/05-raster-vectorization2.R", print.eval = TRUE)

## ----05-geometry-operations-68, message=FALSE----------------------------
library(RQGIS)
data(random_points)
data(ndvi)
ch = st_combine(random_points) %>% 
  st_convex_hull()

## ----05-geometry-operations-69, echo=FALSE, eval=FALSE-------------------
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

## ----05-geometry-operations-70, eval=FALSE, echo=FALSE-------------------
## canterbury = nz[nz$Name == "Canterbury", ]
## cant_buff = st_buffer(canterbury, 100)
## nz_height_near_cant = nz_height[cant_buff, ]
## nrow(nz_height_near_cant) # 75 - 5 more

## ----05-geometry-operations-71, eval=FALSE, echo=FALSE-------------------
## cant_cent = st_centroid(canterbury)
## nz_centre = st_centroid(st_union(nz))
## st_distance(cant_cent, nz_centre) # 234 km

## ----05-geometry-operations-72, echo=FALSE, eval=FALSE-------------------
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

## ----05-geometry-operations-73, echo=FALSE, eval=FALSE-------------------
## p_in_y = p[y]
## p_in_xy = p_in_y[x]
## x_and_y = st_intersection(x, y)
## p[x_and_y]

## ----05-geometry-operations-74, echo=FALSE, eval=FALSE-------------------
## us_states2163 = st_transform(us_states, 2163)
## us_states_bor = st_cast(us_states2163, "MULTILINESTRING")
## us_states_bor$borders = st_length(us_states_bor)
## arrange(us_states_bor, borders)
## arrange(us_states_bor, -borders)

## ----05-geometry-operations-75, echo=FALSE, eval=FALSE-------------------
## plot(ndvi)
## plot(st_geometry(random_points), add = TRUE)
## plot(ch, add = TRUE)
## 
## ndvi_crop1 = crop(ndvi, random_points)
## ndvi_crop2 = crop(ndvi, ch)
## plot(ndvi_crop1)
## plot(ndvi_crop2)
## 
## ndvi_mask1 = mask(ndvi, random_points)
## ndvi_mask2 = mask(ndvi, ch)
## plot(ndvi_mask1)
## plot(ndvi_mask2)

## ----05-geometry-operations-76, echo=FALSE, eval=FALSE-------------------
## random_points_buf = st_buffer(random_points, dist = 90)
## plot(ndvi)
## plot(st_geometry(random_points_buf), add = TRUE)
## plot(ch, add = TRUE)
## random_points$ndvi = extract(ndvi, random_points, buffer = 90, fun = mean)
## random_points$ndvi2 = extract(ndvi, random_points)
## plot(random_points$ndvi, random_points$ndvi2)

## ----05-geometry-operations-77, echo=FALSE, eval=FALSE-------------------
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

## ----05-geometry-operations-78, echo=FALSE, eval=FALSE-------------------
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

## ----05-geometry-operations-79, echo=FALSE, eval=FALSE-------------------
## grain_poly = rasterToPolygons(grain) %>%
##   st_as_sf()
## levels(grain)
## clay = dplyr::filter(grain_poly, layer == 1)
## plot(clay)
## # advantages: can be used to subset other vector objects
## # can do affine transformations and use sf/dplyr verbs
## # disadvantages: better consistency, fast processing on some operations, functions developed for some domains

