## ----05-geometry-operations-1, message=FALSE--------------------------------------------------------------------------------------------------------------
library(sf)
library(terra)
library(dplyr)
library(spData)
library(spDataLarge)


## ----05-geometry-operations-2-----------------------------------------------------------------------------------------------------------------------------
seine_simp = st_simplify(seine, dTolerance = 2000)  # 2000 m


## ----seine-simp, echo=FALSE, fig.cap="Comparison of the original and simplified geometry of the seine object.", warning=FALSE, fig.scap="Simplification in action.", message=FALSE----
library(tmap)
p_simp1 = tm_shape(seine) + tm_lines() +
  tm_layout(main.title = "Original data")
p_simp2 = tm_shape(seine_simp) + tm_lines() +
  tm_layout(main.title = "st_simplify")
tmap_arrange(p_simp1, p_simp2, ncol = 2)


## ----05-geometry-operations-3-----------------------------------------------------------------------------------------------------------------------------
object.size(seine)
object.size(seine_simp)


## ----05-geometry-operations-4-----------------------------------------------------------------------------------------------------------------------------
us_states2163 = st_transform(us_states, "EPSG:2163")
us_states2163 = us_states2163


## ----05-geometry-operations-5-----------------------------------------------------------------------------------------------------------------------------
us_states_simp1 = st_simplify(us_states2163, dTolerance = 100000)  # 100 km


## ----05-geometry-operations-6, warning=FALSE, message=FALSE-----------------------------------------------------------------------------------------------
# proportion of points to retain (0-1; default 0.05)
us_states_simp2 = rmapshaper::ms_simplify(us_states2163, keep = 0.01,
                                          keep_shapes = TRUE)


## ----05-geometry-operations-6b, warning=FALSE-------------------------------------------------------------------------------------------------------------
us_states_simp3 = smoothr::smooth(us_states2163, method = 'ksmooth', smoothness = 6)



## ----us-simp, echo=FALSE, fig.cap="Polygon simplification in action, comparing the original geometry of the contiguous United States with simplified versions, generated with functions from sf (top-right), rmapshaper (bottom-left), and smoothr (bottom-right) packages.", warning=FALSE, fig.asp=0.3, fig.scap="Polygon simplification in action."----
library(tmap)
p_ussimp1 = tm_shape(us_states2163) + tm_polygons() + tm_layout(main.title = "Original data")
p_ussimp2 = tm_shape(us_states_simp1) + tm_polygons() + tm_layout(main.title = "st_simplify")
p_ussimp3 = tm_shape(us_states_simp2) + tm_polygons() + tm_layout(main.title = "ms_simplify")
p_ussimp4 = tm_shape(us_states_simp3) + tm_polygons() + tm_layout(main.title = "smooth(method=ksmooth)")
tmap_arrange(p_ussimp1, p_ussimp2, p_ussimp3, p_ussimp4, ncol = 2, nrow = 2)


## ----05-geometry-operations-7, warning=FALSE--------------------------------------------------------------------------------------------------------------
nz_centroid = st_centroid(nz)
seine_centroid = st_centroid(seine)


## ----05-geometry-operations-8, warning=FALSE--------------------------------------------------------------------------------------------------------------
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


## ----05-geometry-operations-9-----------------------------------------------------------------------------------------------------------------------------
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

## This argument rarely needs to be set.

## Unusual cases where it may be useful include when the memory consumed by the output of a buffer operation is a major concern (in which case it should be reduced) or when very high precision is needed (in which case it should be increased).


## ----nQuadSegs, eval=FALSE, echo=FALSE--------------------------------------------------------------------------------------------------------------------
## # Demonstrate nQuadSegs
## seine_buff_simple = st_buffer(seine, dist = 50000, nQuadSegs = 3)
## plot(seine_buff_simple, key.pos = NULL, main = "50 km buffer")
## plot(seine, key.pos = NULL, lwd = 3, pal = rainbow, add = TRUE)
## seine_points = st_cast(seine[1, ], "POINT")
## buff_single = st_buffer(seine_points[1, ], 50000, 2)
## buff_points = st_cast(buff_single, "POINT")
## plot(st_geometry(buff_single), add = TRUE)


## ----05-geometry-operations-11----------------------------------------------------------------------------------------------------------------------------
nz_sfc = st_geometry(nz)


## ----05-geometry-operations-12----------------------------------------------------------------------------------------------------------------------------
nz_shift = nz_sfc + c(0, 100000)


## ----05-geometry-operations-13, echo=FALSE,eval=FALSE-----------------------------------------------------------------------------------------------------
## nz_scale0 = nz_sfc * 0.5


## ----05-geometry-operations-14----------------------------------------------------------------------------------------------------------------------------
nz_centroid_sfc = st_centroid(nz_sfc)
nz_scale = (nz_sfc - nz_centroid_sfc) * 0.5 + nz_centroid_sfc


## ----05-geometry-operations-15----------------------------------------------------------------------------------------------------------------------------
rotation = function(a){
  r = a * pi / 180 #degrees to radians
  matrix(c(cos(r), sin(r), -sin(r), cos(r)), nrow = 2, ncol = 2)
} 


## ----05-geometry-operations-16----------------------------------------------------------------------------------------------------------------------------
nz_rotate = (nz_sfc - nz_centroid_sfc) * rotation(30) + nz_centroid_sfc


## ----affine-trans, echo=FALSE, fig.cap="Illustrations of affine transformations: shift, scale and rotate.", warning=FALSE, eval=TRUE, fig.scap="Illustrations of affine transformations."----
st_crs(nz_shift) = st_crs(nz_sfc)
st_crs(nz_scale) = st_crs(nz_sfc)
st_crs(nz_rotate) = st_crs(nz_sfc)
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


## ----05-geometry-operations-17, echo=FALSE,eval=FALSE-----------------------------------------------------------------------------------------------------
## nz_scale_rotate = (nz_sfc - nz_centroid_sfc) * 0.25 * rotation(90) + nz_centroid_sfc

## ----05-geometry-operations-18, echo=FALSE,eval=FALSE-----------------------------------------------------------------------------------------------------
## shearing = function(hx, hy){
##   matrix(c(1, hy, hx, 1), nrow = 2, ncol = 2)
## }
## nz_shear = (nz_sfc - nz_centroid_sfc) * shearing(1.1, 0) + nz_centroid_sfc

## ----05-geometry-operations-19, echo=FALSE,eval=FALSE-----------------------------------------------------------------------------------------------------
## plot(nz_sfc)
## plot(nz_shear, add = TRUE, col = "red")


## ----05-geometry-operations-20----------------------------------------------------------------------------------------------------------------------------
nz_scale_sf = st_set_geometry(nz, nz_scale)


## ----points, fig.cap="Overlapping circles.", fig.asp=0.4, crop = TRUE-------------------------------------------------------------------------------------
b = st_sfc(st_point(c(0, 1)), st_point(c(1, 1))) # create 2 points
b = st_buffer(b, dist = 1) # convert points to circles
plot(b, border = "grey")
text(x = c(-0.5, 1.5), y = 1, labels = c("x", "y"), cex = 3) # add text


## ----circle-intersection, fig.cap="Overlapping circles with a gray color indicating intersection between them.", fig.asp=0.4, fig.scap="Overlapping circles showing intersection types.", crop = TRUE----
x = b[1]
y = b[2]
x_and_y = st_intersection(x, y)
plot(b, border = "grey")
plot(x_and_y, col = "lightgrey", border = "grey", add = TRUE) # intersecting area


## ----venn-clip, echo=FALSE, fig.cap="Spatial equivalents of logical operators.", warning=FALSE------------------------------------------------------------
source("https://github.com/Robinlovelace/geocompr/raw/main/code/05-venn-clip.R")
# source("code/05-venn-clip.R") # for testing local version, todo: remove or change


## ----venn-subset, fig.cap="Randomly distributed points within the bounding box enclosing circles x and y. The point that intersects with both objects x and y is highlighted.", fig.height=6, fig.width=9, fig.asp=0.4, fig.scap="Randomly distributed points within the bounding box. Note that only one point intersects with both x and y, highlighted with a red circle.", echo=FALSE----
bb = st_bbox(st_union(x, y))
box = st_as_sfc(bb)
set.seed(2017)
p = st_sample(x = box, size = 10)
p_xy1 = p[x_and_y]
plot(box, border = "grey", lty = 2)
plot(x, add = TRUE, border = "grey")
plot(y, add = TRUE, border = "grey")
plot(p, add = TRUE)
plot(p_xy1, cex = 3, col = "red", add = TRUE)
text(x = c(-0.5, 1.5), y = 1, labels = c("x", "y"), cex = 2)


## ----venn-subset-to-show, eval=FALSE----------------------------------------------------------------------------------------------------------------------
## bb = st_bbox(st_union(x, y))
## box = st_as_sfc(bb)
## set.seed(2017)
## p = st_sample(x = box, size = 10)
## x_and_y = st_intersection(x, y)


## ----05-geometry-operations-21----------------------------------------------------------------------------------------------------------------------------
p_xy1 = p[x_and_y]
p_xy2 = st_intersection(p, x_and_y)
sel_p_xy = st_intersects(p, x, sparse = FALSE)[, 1] &
  st_intersects(p, y, sparse = FALSE)[, 1]
p_xy3 = p[sel_p_xy]


## ----05-geometry-operations-22, echo=FALSE, eval=FALSE----------------------------------------------------------------------------------------------------
## # test if objects are identical:
## identical(p_xy1, p_xy2)
## identical(p_xy2, p_xy3)
## identical(p_xy1, p_xy3)
## waldo::compare(p_xy1, p_xy2) # the same except attribute names
## waldo::compare(p_xy2, p_xy3) # the same except attribute names
## 
## 
## # An alternative way to sample from the bb
## bb = st_bbox(st_union(x, y))
## pmulti = st_multipoint(pmat)
## box = st_convex_hull(pmulti)


## ----05-geometry-operations-23----------------------------------------------------------------------------------------------------------------------------
regions = aggregate(x = us_states[, "total_pop_15"], by = list(us_states$REGION),
                    FUN = sum, na.rm = TRUE)
regions2 = us_states |> 
  group_by(REGION) |>
  summarize(pop = sum(total_pop_15, na.rm = TRUE))


## ----05-geometry-operations-24, echo=FALSE----------------------------------------------------------------------------------------------------------------
# st_join(buff, africa[, "pop"]) |>
#   summarize(pop = sum(pop, na.rm = TRUE))
# summarize(africa[buff, "pop"], pop = sum(pop, na.rm = TRUE))


## ----us-regions, fig.cap="Spatial aggregation on contiguous polygons, illustrated by aggregating the population of US states into regions, with population represented by color. Note the operation automatically dissolves boundaries between states.", echo=FALSE, warning=FALSE, fig.asp=0.2, out.width="100%", fig.scap="Spatial aggregation on contiguous polygons."----
source("https://github.com/Robinlovelace/geocompr/raw/main/code/05-us-regions.R", print.eval = TRUE)


## ----05-geometry-operations-25----------------------------------------------------------------------------------------------------------------------------
us_west = us_states[us_states$REGION == "West", ]
us_west_union = st_union(us_west)


## ----05-geometry-operations-26, message=FALSE-------------------------------------------------------------------------------------------------------------
texas = us_states[us_states$NAME == "Texas", ]
texas_union = st_union(us_west_union, texas)


## ----05-geometry-operations-27, echo=FALSE, eval=FALSE----------------------------------------------------------------------------------------------------
## plot(texas_union)
## # aim: experiment with st_union
## us_south2 = st_union(us_west[1, ], us_west[6, ])
## plot(us_southhwest)


## ----05-geometry-operations-28----------------------------------------------------------------------------------------------------------------------------
multipoint = st_multipoint(matrix(c(1, 3, 5, 1, 3, 1), ncol = 2))


## ----05-geometry-operations-29----------------------------------------------------------------------------------------------------------------------------
linestring = st_cast(multipoint, "LINESTRING")
polyg = st_cast(multipoint, "POLYGON")


## ----single-cast, echo = FALSE, fig.cap="Examples of a linestring and a polygon casted from a multipoint geometry.", warning=FALSE, fig.asp=0.3, fig.scap="Examples of casting operations."----
p_sc1 = tm_shape(st_sfc(multipoint)) + tm_symbols(shape = 1, col = "black", size = 0.5) +
  tm_layout(main.title = "MULTIPOINT", inner.margins = c(0.05, 0.05, 0.05, 0.05))
p_sc2 = tm_shape(st_sfc(linestring)) + tm_lines() +
  tm_layout(main.title = "LINESTRING")
p_sc3 = tm_shape(st_sfc(polyg)) + tm_polygons(border.col = "black") +
  tm_layout(main.title = "POLYGON")
tmap_arrange(p_sc1, p_sc2, p_sc3, ncol = 3)


## ----05-geometry-operations-30----------------------------------------------------------------------------------------------------------------------------
multipoint_2 = st_cast(linestring, "MULTIPOINT")
multipoint_3 = st_cast(polyg, "MULTIPOINT")
all.equal(multipoint, multipoint_2)
all.equal(multipoint, multipoint_3)


## For single simple feature geometries (`sfg`), `st_cast()` also provides geometry casting from non-multi-types to multi-types (e.g., `POINT` to `MULTIPOINT`) and from multi-types to non-multi-types.

## However, when casting from multi-types to non-multi-types only the first element of the old object would remain in the output object.


## ----05-geometry-operations-32, include=FALSE-------------------------------------------------------------------------------------------------------------
cast_all = function(xg) {
  lapply(c("MULTIPOLYGON", "MULTILINESTRING", "MULTIPOINT", "POLYGON", "LINESTRING", "POINT"), 
         function(x) st_cast(xg, x))
}
t = cast_all(multipoint)
t2 = cast_all(polyg)


## ----sfs-st-cast, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
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
                             "output type by column"),
             caption.short = "Geometry casting on simple feature geometries.",
             booktabs = TRUE) |> 
  kableExtra::add_footnote("Note: Values like (1) represent the number of features; NA means the operation is not possible. Abbreviations: POI, LIN, POL and GC refer to POINT, LINESTRING, POLYGON and GEOMETRYCOLLECTION. The MULTI version of these geometry types is indicated by a preceding M, e.g., MPOI is the acronym for MULTIPOINT.", notation = "none")


## ----05-geometry-operations-33----------------------------------------------------------------------------------------------------------------------------
multilinestring_list = list(matrix(c(1, 4, 5, 3), ncol = 2), 
                            matrix(c(4, 4, 4, 1), ncol = 2),
                            matrix(c(2, 4, 2, 2), ncol = 2))
multilinestring = st_multilinestring(multilinestring_list)
multilinestring_sf = st_sf(geom = st_sfc(multilinestring))
multilinestring_sf


## ----05-geometry-operations-34----------------------------------------------------------------------------------------------------------------------------
linestring_sf2 = st_cast(multilinestring_sf, "LINESTRING")
linestring_sf2


## ----line-cast, echo=FALSE, fig.cap="Examples of type casting between MULTILINESTRING (left) and LINESTRING (right).", warning=FALSE, fig.scap="Examples of type casting."----
p_lc1 = tm_shape(multilinestring_sf) + tm_lines(lwd = 3) +
  tm_layout(main.title = "MULTILINESTRING")
linestring_sf2$name = c("Riddle Rd", "Marshall Ave", "Foulke St")
p_lc2 = tm_shape(linestring_sf2) + tm_lines(lwd = 3, col = "name", palette = "Set2") +
  tm_layout(main.title = "LINESTRING", legend.show = FALSE)
tmap_arrange(p_lc1, p_lc2, ncol = 2)


## ----05-geometry-operations-35----------------------------------------------------------------------------------------------------------------------------
linestring_sf2$name = c("Riddle Rd", "Marshall Ave", "Foulke St")
linestring_sf2$length = st_length(linestring_sf2)
linestring_sf2


## ----05-geometry-operations-36----------------------------------------------------------------------------------------------------------------------------
elev = rast(system.file("raster/elev.tif", package = "spData"))
clip = rast(xmin = 0.9, xmax = 1.8, ymin = -0.45, ymax = 0.45,
            resolution = 0.3, vals = rep(1, 9))
elev[clip, drop = FALSE]


## ----extend-example0--------------------------------------------------------------------------------------------------------------------------------------
elev = rast(system.file("raster/elev.tif", package = "spData"))
elev_2 = extend(elev, c(1, 2))


## ----extend-example, fig.cap = "Original raster (left) and the same raster (right) extended by one row on the top and bottom and two columns on the left and right.", fig.scap="Extending rasters.", echo=FALSE, fig.asp=0.5----
source("https://github.com/Robinlovelace/geocompr/raw/main/code/05-extend-example.R", print.eval = TRUE)


## ----05-geometry-operations-37, error=TRUE----------------------------------------------------------------------------------------------------------------
elev_3 = elev + elev_2


## ----05-geometry-operations-38----------------------------------------------------------------------------------------------------------------------------
elev_4 = extend(elev, elev_2)


## ----05-geometry-operations-39----------------------------------------------------------------------------------------------------------------------------
origin(elev_4)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
# change the origin
origin(elev_4) = c(0.25, 0.25)


## ----origin-example, fig.cap="Rasters with identical values but different origins.", echo=FALSE-----------------------------------------------------------
elev_poly = st_as_sf(as.polygons(elev, dissolve = FALSE))
elev4_poly = st_as_sf(as.polygons(elev_4, dissolve = FALSE))
tm_shape(elev4_poly) +
  tm_grid() +
  tm_polygons(col = "elev") +
  tm_shape(elev_poly) +
  tm_polygons(col = "elev") +
  tm_layout(frame = FALSE, legend.show = FALSE,
            inner.margins = c(0.1, 0.12, 0, 0))
# # See https://github.com/Robinlovelace/geocompr/issues/695
# knitr::include_graphics("https://user-images.githubusercontent.com/1825120/146618199-786fe3ad-9718-4dd0-a640-41180fc17e63.png")


## ----05-geometry-operations-40----------------------------------------------------------------------------------------------------------------------------
dem = rast(system.file("raster/dem.tif", package = "spDataLarge"))
dem_agg = aggregate(dem, fact = 5, fun = mean)


## ----aggregate-example, fig.cap = "Original raster (left). Aggregated raster (right).", echo=FALSE--------------------------------------------------------
p_ar1 = tm_shape(dem) +
  tm_raster(style = "cont", legend.show = FALSE) +
  tm_layout(main.title = "A. Original", frame = FALSE)
p_ar2 = tm_shape(dem_agg) +
  tm_raster(style = "cont", legend.show = FALSE) +
  tm_layout(main.title = "B. Aggregated", frame = FALSE)
tmap_arrange(p_ar1, p_ar2, ncol = 2)


## ----05-geometry-operations-41----------------------------------------------------------------------------------------------------------------------------
dem_disagg = disagg(dem_agg, fact = 5, method = "bilinear")
identical(dem, dem_disagg)


## ----bilinear, echo = FALSE, fig.width=8, fig.height=10, fig.cap="The distance-weighted average of the four closest input cells determine the output when using the bilinear method for disaggregation.", fig.scap="Bilinear disaggregation in action.", warning=FALSE----
source("https://github.com/Robinlovelace/geocompr/raw/main/code/05-bilinear.R", print.eval = TRUE)
# knitr::include_graphics("https://user-images.githubusercontent.com/1825120/146619205-3c0c2e3f-9e8b-4fda-b014-9c342a4befbb.png")


## ---- echo=FALSE, eval=FALSE------------------------------------------------------------------------------------------------------------------------------
## target_rast = rast(xmin = 794600, xmax = 798200,
##                    ymin = 8931800, ymax = 8935400,
##                    resolution = 150, crs = "EPSG:32717")
## 
## target_rast_p = st_as_sf(as.polygons(target_rast))
## dem_resampl1 = resample(dem, target_rast, method = "near")
## 
## tm1 = tm_shape(dem) +
##   tm_raster(breaks = seq(200, 1100, by = 150), legend.show = FALSE) +
##   tm_layout(frame = FALSE)
## 
## tm2 = tm_shape(dem) +
##   tm_raster(breaks = seq(200, 1100, by = 150), legend.show = FALSE) +
##   tm_layout(frame = FALSE) +
##   tm_shape(target_rast_p) +
##   tm_borders()
## 
## tm3 = tm_shape(dem_resampl1) +
##   tm_raster(breaks = seq(200, 1100, by = 150), legend.show = FALSE) +
##   tm_layout(frame = FALSE)
## 
## tmap_arrange(tm1, tm2, tm3, nrow = 1)


## ----05-geometry-operations-42----------------------------------------------------------------------------------------------------------------------------
target_rast = rast(xmin = 794600, xmax = 798200, 
                   ymin = 8931800, ymax = 8935400,
                   resolution = 150, crs = "EPSG:32717")


## ----05-geometry-operations-42b---------------------------------------------------------------------------------------------------------------------------
dem_resampl = resample(dem, y = target_rast, method = "bilinear")


## ----resampl, echo=FALSE, fig.cap="Visual comparison of the original raster and five different resampling methods."---------------------------------------
dem_resampl1 = resample(dem, target_rast, method = "near")
dem_resampl2 = resample(dem, target_rast, method = "bilinear")
dem_resampl3 = resample(dem, target_rast, method = "cubic")
dem_resampl4 = resample(dem, target_rast, method = "cubicspline")
dem_resampl5 = resample(dem, target_rast, method = "lanczos")

library(tmap)
tm1 = tm_shape(dem) +
  tm_raster(breaks = seq(200, 1100, by = 150), legend.show = FALSE) +
  tm_layout(frame = FALSE, main.title = "Original raster")
tm2 = tm_shape(dem_resampl1) +
  tm_raster(breaks = seq(200, 1100, by = 150), legend.show = FALSE) +
  tm_layout(frame = FALSE, main.title = "near")
tm3 = tm_shape(dem_resampl2) +
  tm_raster(breaks = seq(200, 1100, by = 150), legend.show = FALSE) +
  tm_layout(frame = FALSE, main.title = "bilinear")
tm4 = tm_shape(dem_resampl3) +
  tm_raster(breaks = seq(200, 1100, by = 150), legend.show = FALSE) +
  tm_layout(frame = FALSE, main.title = "cubic")
tm5 = tm_shape(dem_resampl4) +
  tm_raster(breaks = seq(200, 1100, by = 150), legend.show = FALSE) +
  tm_layout(frame = FALSE, main.title = "cubicspline")
tm6 = tm_shape(dem_resampl5) +
  tm_raster(breaks = seq(200, 1100, by = 150), legend.show = FALSE) +
  tm_layout(frame = FALSE, main.title = "lanczos")
tmap_arrange(tm1, tm2, tm3, tm4, tm5, tm6)


## Most geometry operations in **terra** are user-friendly, rather fast, and work on large raster objects.

## However, there could be some cases, when **terra** is not the most performant either for extensive rasters or many raster files, and some alternatives should be considered.

## 

## The most established alternatives come with the GDAL library.

## It contains several utility functions, including:

## 

## - `gdalinfo` - lists various information about a raster file, including its resolution, CRS, bounding box, and more

## - `gdal_translate` - converts raster data between different file formats

## - `gdal_rasterize` - converts vector data into raster files

## - `gdalwarp` - allows for raster mosaicing, resampling, cropping, and reprojecting

## 

## All of the above functions are written in C++, but can be called in R using the **gdalUtilities** package.

## Importantly, all of these functions expect a raster file path as an input and often return their output as a raster file (for example, `gdalUtilities::gdal_translate("my_file.tif", "new_file.tif", t_srs = "EPSG:4326")`)

## This is very different from the usual **terra** approach, which expects `SpatRaster` objects as inputs.


## ---- echo=FALSE, results='asis'--------------------------------------------------------------------------------------------------------------------------
res = knitr::knit_child('_05-ex.Rmd', quiet = TRUE, options = list(include = FALSE, eval = FALSE))
cat(res, sep = '\n')

