## ---- message=FALSE------------------------------------------------------
library(sf)
library(raster)
library(tidyverse)
library(spData)
library(spDataLarge)

## ------------------------------------------------------------------------
london = data.frame(lon = -0.1, lat = 51.5) %>% 
  st_as_sf(coords = c("lon", "lat"))
st_is_longlat(london)

## ------------------------------------------------------------------------
london = st_set_crs(london, 4326)
st_is_longlat(london)

## ------------------------------------------------------------------------
london_buff = st_buffer(london, dist = 1)

## The distance between two lines of longitude, called meridians, is around 111 km at the equator (execute `geosphere::distGeo(c(0, 0), c(1, 0))` to find the precise distance).

## ------------------------------------------------------------------------
london_proj = data.frame(x = 530000, y = 180000) %>% 
  st_as_sf(coords = 1:2, crs = 27700)

## ---- eval=FALSE---------------------------------------------------------
## st_crs(london_proj)
## #> Coordinate Reference System:
## #>   EPSG: 27700
## #>   proj4string: "+proj=tmerc +lat_0=49 +lon_0=-2 ... +units=m +no_defs"

## ------------------------------------------------------------------------
london_proj_buff = st_buffer(london_proj, 111320)

## ----crs-buf, fig.cap="Buffer on vector represenations of London with a geographic (left) and projected (right) CRS. The circular point represents London and the grey outline represents the outline of the UK.", fig.asp=1, fig.show='hold', out.width="45%", echo=FALSE----
uk = rnaturalearth::ne_countries(scale = 50) %>% 
  st_as_sf() %>% 
  filter(grepl(pattern = "United Kingdom|Ire", x = name_long))
plot(london_buff, graticule = st_crs(4326), axes = TRUE)
plot(london, add = TRUE)
plot(uk$geometry, add = TRUE, border = "grey", lwd = 3)
uk_proj = uk %>%
  st_transform(27700)
plot(london_proj_buff, graticule = st_crs(27700), axes = TRUE)
plot(london_proj, add = TRUE)
plot(uk_proj$geometry, add = TRUE, border = "grey", lwd = 3)

## ---- eval=FALSE---------------------------------------------------------
## st_distance(london, london_proj)
## # > Error: st_crs(x) == st_crs(y) is not TRUE

## ------------------------------------------------------------------------
london2 = st_transform(london, 27700)

## ------------------------------------------------------------------------
st_distance(london2, london_proj)

## ------------------------------------------------------------------------
lonlat2UTM = function(lonlat) {
  utm = (floor((lonlat[1] + 180) / 6) %% 60) + 1
  utm + 32600
}

## ------------------------------------------------------------------------
(epsg_utm = lonlat2UTM(st_coordinates(london)))
st_crs(epsg_utm)

## ------------------------------------------------------------------------
crs_lnd = st_crs(cycle_hire_osm)
class(crs_lnd)
crs_lnd$epsg

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## crs1 = st_crs("+proj=longlat +datum=WGS84")
## crs2 = st_crs("+datum=WGS84 +proj=longlat")
## crs3 = st_crs(4326)
## crs1 == crs2
## crs1 == crs3

## ------------------------------------------------------------------------
cycle_hire_osm_projected = st_transform(cycle_hire_osm, 27700)

## ------------------------------------------------------------------------
crs_codes = rgdal::make_EPSG()[1:2]
dplyr::filter(crs_codes, code == 27700)

## ---- eval=FALSE---------------------------------------------------------
## st_crs(27700)$proj4string
## #> [1] "+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000 ...

## Printing a spatial object in the console, automatically returns its coordinate reference system.

## ------------------------------------------------------------------------
world_mollweide = st_transform(world, crs = "+proj=moll")

## ----mollproj, echo=FALSE, fig.cap="Mollweide projection of the world.", warning=FALSE----
par_old = par()
par(mar = c(0, 0, 1, 0))
plot(world_mollweide$geom, graticule = TRUE, main = "the Mollweide projection")
par(par_old)

## ------------------------------------------------------------------------
world_wintri = lwgeom::st_transform_proj(world, crs = "+proj=wintri")

## ----wintriproj, echo=FALSE, fig.cap="Winkel tripel projection of the world.", warning=FALSE----
world_wintri_gr = st_graticule(lat = c(-89.9, seq(-80, 80, 20), 89.9)) %>% 
  lwgeom::st_transform_proj(crs = "+proj=wintri")
par_old = par()
par(mar = c(0, 0, 1, 0))
plot(world_wintri_gr$geometry, main = "the Winkel tripel projection", col = "grey")
plot(world_wintri$geom, add = TRUE)
par(par_old)

## The two main functions for transformation of simple features coordinates are `sf::st_transform()` and `sf::sf_project()`.

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # demo of sf_project
## mat_lonlat = as.matrix(data.frame(x = 0:20, y = 50:70))
## plot(mat_lonlat)
## mat_projected = sf_project(from = st_crs(4326)$proj4string, to = st_crs(27700)$proj4string, pts = mat_lonlat)
## plot(mat_projected)

## ------------------------------------------------------------------------
world_laea1 = st_transform(world, crs = "+proj=laea +x_0=0 +y_0=0 +lon_0=0 +lat_0=0")

## ----laeaproj1, echo=FALSE, fig.cap="Lambert azimuthal equal-area projection of the world centered on longitude and latitude of 0.", warning=FALSE----
par_old = par()
par(mar = c(0, 0, 1, 0))
plot(world_laea1$geom, graticule = TRUE, main = "the Lambert azimuthal equal-area projection")
par(par_old)

## ------------------------------------------------------------------------
world_laea2 = st_transform(world, crs = "+proj=laea +x_0=0 +y_0=0 +lon_0=-74 +lat_0=40")

## ----laeaproj2, echo=FALSE, fig.cap="Lambert azimuthal equal-area projection of the world centered on New York City.", warning=FALSE----
world_laea2_g = st_graticule(ndiscr = 10000) %>%
  st_transform("+proj=laea +x_0=0 +y_0=0 +lon_0=-74 +lat_0=40.1 +ellps=WGS84 +no_defs") %>% 
  st_geometry()
par_old = par()
par(mar = c(0, 0, 1, 0))
plot(world_laea2_g, main = "the Lambert azimuthal equal-area projection", col = "grey")
plot(world_laea2$geom, add = TRUE)
par(par_old)

## It is possible to use a EPSG code in a `proj4string` definition with `"+init=epsg:MY_NUMBER"`.

## ------------------------------------------------------------------------
cat_raster = raster(system.file("raster/nlcd2011.tif", package = "spDataLarge"))
crs(cat_raster)

## ------------------------------------------------------------------------
unique(cat_raster)

## ------------------------------------------------------------------------
wgs84 = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
cat_raster_wgs84 = projectRaster(cat_raster, crs = wgs84, method = "ngb")

## ----catraster, echo=FALSE-----------------------------------------------
data_frame(
  CRS = c("NAD83", "WGS84"),
  nrow = c(nrow(cat_raster), nrow(cat_raster_wgs84)),
  ncol = c(ncol(cat_raster), ncol(cat_raster_wgs84)),
  ncell = c(ncell(cat_raster), ncell(cat_raster_wgs84)),
  resolution = c(mean(res(cat_raster)), mean(res(cat_raster_wgs84), na.rm = TRUE)),
  unique_categories = c(length(unique(values(cat_raster))), length(unique(values(cat_raster_wgs84))))
) %>% knitr::kable(caption = "Key attributes in the original and projected categorical raster datasets.", digits = 4)

## ------------------------------------------------------------------------
con_raster = raster(system.file("raster/srtm.tif", package = "spDataLarge"))
crs(con_raster)

## ------------------------------------------------------------------------
equalarea = "+proj=laea +lat_0=37.32 +lon_0=-113.04"
con_raster_ea = projectRaster(con_raster, crs = equalarea, method = "bilinear")
crs(con_raster_ea)

## ----rastercrs, echo=FALSE-----------------------------------------------
data_frame(
  CRS = c("WGS84", "Equal-area"),
  nrow = c(nrow(con_raster), nrow(con_raster_ea)),
  ncol = c(ncol(con_raster), ncol(con_raster_ea)),
  ncell = c(ncell(con_raster), ncell(con_raster_ea)),
  resolution = c(mean(res(cat_raster)), mean(res(cat_raster_wgs84), na.rm = TRUE)),
  mean = c(mean(values(con_raster)), mean(values(con_raster_ea), na.rm = TRUE))
) %>% knitr::kable(caption = "Key attributes original and projected continuous (numeric) raster datasets.", digits = 4)

## Of course, the limitations of 2D Earth projections apply as much to vector as to raster data.

## ------------------------------------------------------------------------
seine_simp = st_simplify(seine, dTolerance = 2000)  # 2000 m

## ----seine-simp, echo=FALSE, fig.cap="Comparison of the original and simplified `seine` geometry.", warning=FALSE----
par_old = par()
par(mfrow = c(1, 2), mar = c(0, 0, 1, 0))
plot(seine$geometry, col = 1, main = "Original data")
plot(seine_simp$geometry, col = 1, main = "st_simplify")
par(par_old)

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
par_old = par()
par(mfrow = c(1, 3), mar = c(0, 0, 1, 0))
plot(us_states2163$geometry, col = 8, main = "Original data")
plot(us_states_simp1$geometry, col = 8, main = "st_simplify")
plot(us_states_simp2$geometry, col = 8, main = "ms_simplify")
par(par_old)

## ------------------------------------------------------------------------
nz_centroid = st_centroid(nz)
seine_centroid = st_centroid(seine)

## ------------------------------------------------------------------------
nz_pos = st_point_on_surface(nz)
seine_pos = st_point_on_surface(seine)

## ----centr, warning=FALSE, echo=FALSE, fig.cap="Centroids (black points) and 'points on surface' (red points) of New Zeleand's regions (left) and the Seine (right) datasets."----
par_old = par()
par(mfrow = c(1, 2), mar = c(0, 0, 1, 0))
plot(nz$geometry)
plot(nz_centroid$geometry, add = TRUE)
plot(nz_pos$geometry, add = TRUE, col = "red")
plot(seine$geometry)
plot(seine_centroid$geometry, add = TRUE)
plot(seine_pos$geometry, add = TRUE, col = "red")
par(par_old)

## ------------------------------------------------------------------------
seine_buff_5km = st_buffer(seine, dist = 5000)
seine_buff_50km = st_buffer(seine, dist = 50000)

## ----buffs, echo=FALSE, fig.cap="Buffers around the `seine` datasets of 5km (left) and 50km (right). Note the colors, which reflect the fact that one buffer is created per geometry feature.", fig.show='hold', out.width="50%"----
plot(seine_buff_5km, key.pos = NULL, main = "5 km buffer")
plot(seine, key.pos = NULL, pal = rainbow, add = TRUE)
plot(seine_buff_50km, key.pos = NULL, main = "50 km buffer")
plot(seine, key.pos = NULL, lwd = 3, pal = rainbow, add = T)

## The third and final argument of `st_buffer()` is `nQuadSegs`, which means 'number of segments per quadrant' and is set by default to 30 (meaning circles created by buffers are composed of $4 \times 30 = 120$ lines).

## ----nQuadSegs, eval=FALSE, echo=FALSE-----------------------------------
## # Demonstrate nQuadSegs
## seine_buff_simple = st_buffer(seine, dist = 50000, nQuadSegs = 3)
## plot(seine_buff_simple, key.pos = NULL, main = "50 km buffer")
## plot(seine, key.pos = NULL, lwd = 3, pal = rainbow, add = T)
## seine_points = st_cast(seine[1, ], "POINT")
## buff_single = st_buffer(seine_points[1, ], 50000, 2)
## buff_points = st_cast(buff_single, "POINT")
## plot(buff_single$geometry, add = T)

## ------------------------------------------------------------------------
nz_sfc = nz$geometry

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
par_old = par()
par(mfrow = c(1, 3), mar = c(0, 0, 1, 0))
plot(nz_sfc, main = "Shift")
plot(nz_shift, add = TRUE, col = "red")
plot(nz_sfc, main = "Scale")
plot(nz_scale, add = TRUE, col = "red")
plot(nz_sfc, main = "Rotate")
plot(nz_rotate, add = TRUE, col = "red")
par(par_old)
# add transparency
# library(tmap)
# library(grid)
# 
# p1a = tm_shape(nz_sfc) + 
#   tm_polygons() +
#   tm_shape(nz_shift) + 
#   tm_polygons(col = "red")
#  
# p2a = tm_shape(nz_sfc) + 
#   tm_polygons() +
#   tm_shape(nz_scale) + 
#   tm_polygons(col = "red")
# 
# p3a = tm_shape(nz_sfc) +
#   tm_polygons() +
#   tm_shape(nz_rotate) +
#   tm_polygons(col = "red")
# 
# grid.newpage()
# pushViewport(viewport(layout = grid.layout(1, 3)))
# print(p1a, vp=viewport(layout.pos.col = 1))
# print(p2a, vp=viewport(layout.pos.col = 2))
# print(p3a, vp=viewport(layout.pos.col = 3))

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

## ---- echo=FALSE---------------------------------------------------------
# An alternative way to sample from the bb
bb = st_bbox(st_union(x, y))
pmulti = st_multipoint(pmat)
box = st_convex_hull(pmulti)

## ---- eval = FALSE-------------------------------------------------------
## group_by(us_states, REGION) %>%
##   summarize(sum(pop = total_pop_15, na.rm = TRUE))

## ------------------------------------------------------------------------
regions = aggregate(x = us_states[, "total_pop_15"], by = list(us_states$REGION),
                    FUN = sum, na.rm = TRUE)

## ---- echo=FALSE---------------------------------------------------------
# st_join(buff, africa[, "pop"]) %>%
#   summarize(pop = sum(pop, na.rm = TRUE))
# summarize(africa[buff, "pop"], pop = sum(pop, na.rm = TRUE))

## ----us-regions, fig.cap="Spatial aggregation on contiguous polygons, illustrated by aggregating the population of US states into regions, with population represented by color. Note the operation automatically dissolves boundaries between states.", echo=FALSE, warning=FALSE, fig.asp=0.2, out.width="100%"----
source("code/05-us-regions.R", print.eval = TRUE)

## ---- eval=FALSE---------------------------------------------------------
## regions2 = us_states %>%
##   group_by(REGION) %>%
##   summarize(sum(pop = total_pop_15, na.rm = TRUE))

## ------------------------------------------------------------------------
multipoint = st_multipoint(matrix(c(1, 3, 5, 1, 3, 1), ncol = 2))

## ------------------------------------------------------------------------
linestring = st_cast(multipoint, "LINESTRING")
polyg = st_cast(multipoint, "POLYGON")

## ----single-cast, echo = FALSE, fig.cap="Examples of linestring and polygon 'casted' from a multipoint geometry.", warning=FALSE----
par_old = par()
par(mfrow = c(1, 3), mar = c(0, 0, 1, 0))
plot(multipoint, main = "MULTIPOINT")
plot(linestring, main = "LINESTRING")
plot(polyg, col = "grey", main = "POLYGON")
par(par_old)

## ------------------------------------------------------------------------
multipoint_2 = st_cast(linestring, "MULTIPOINT")
multipoint_3 = st_cast(polyg, "MULTIPOINT")
all.equal(multipoint, multipoint_2, multipoint_3)

## For single simple feature geometries (`sfg`), `st_cast` also provides geometry casting from non-multi to multi types (e.g. `POINT` to `MULTIPOINT`) and from multi types to non-multi types.

## ---- include=FALSE------------------------------------------------------
cast_all <- function(xg) {
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
par_old = par()
par(mfrow = c(1, 2), mar = c(0, 0, 1, 0))
plot(multilinestring_sf$geom, col = "black", main = "MULTILINESTRING")
plot(linestring_sf2$geom, col = c("red", "green", "blue"), main = "LINESTRING")
par(par_old)

## ------------------------------------------------------------------------
linestring_sf2$name = c("Riddle Rd", "Marshall Ave", "Foulke St")
linestring_sf2$length = st_length(linestring_sf2)
linestring_sf2

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
elev_agg = aggregate(elev, fact = 2, fun = mean)
par(mfrow = c(1, 2))
plot(elev)
plot(elev_agg)

## ------------------------------------------------------------------------
elev_disagg = disaggregate(elev_agg, fact = 2, method = "bilinear")
all(values(elev) == values(elev_disagg))

## ----bilinear, echo = FALSE, fig.width=8, fig.height=10, fig.cap="The distance-weighted average of the four closest input cells determine the output when using the bilinear method for disaggregation."----
data(elev)
elev_agg_2 = aggregate(elev, fact = 2, fun = mean)
plot(extend(elev, 1, 0), col = NA, legend = FALSE)
plot(elev_agg_2, add = TRUE)
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
elev_agg = extend(elev_agg, 2)
elev_disagg_2 = resample(elev_agg, elev)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## st_crs(nz)
## nz_wgs = st_transform(nz, 4326)
## nz_crs = st_crs(nz)
## nz_wgs_crs = st_crs(nz_wgs)
## nz_crs$epsg
## nz_wgs_crs$epsg
## st_bbox(nz)
## st_bbox(nz_wgs)
## nz_wgs_NULL_crs = st_set_crs(nz_wgs, NA)
## nz_27700 = st_transform(nz_wgs, 27700)
## par(mfrow = c(1, 3))
## plot(nz$geometry)
## plot(nz_wgs$geometry)
## plot(nz_wgs_NULL_crs$geometry)
## # answer: it is fatter in the East-West direction
## # because New Zealand is close to the South Pole and meridians converge there
## plot(nz_27700$geometry)
## par(mfrow = c(1, 1))

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## # see https://github.com/r-spatial/sf/issues/509
## world_tmerc = st_transform(world, "+proj=tmerc")
## plot(world_tmerc$geom)
## world_4326 = st_transform(world_tmerc, 4326)
## plot(world_4326$geom)

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## plot(rmapshaper::ms_simplify(nz$geometry, keep = 1))
## plot(rmapshaper::ms_simplify(nz$geometry, keep = 0.5))
## plot(rmapshaper::ms_simplify(nz$geometry, keep = 0.05))
## # Starts to breakdown here at 0.5% of the points:
## plot(rmapshaper::ms_simplify(nz$geometry, keep = 0.005))
## # At this point no further simplification changes the result
## plot(rmapshaper::ms_simplify(nz$geometry, keep = 0.0005))
## plot(rmapshaper::ms_simplify(nz$geometry, keep = 0.00005))
## plot(st_simplify(nz$geometry, dTolerance = 100))
## plot(st_simplify(nz$geometry, dTolerance = 1000))
## # Starts to breakdown at 10 km:
## plot(st_simplify(nz$geometry, dTolerance = 10000))
## plot(st_simplify(nz$geometry, dTolerance = 100000))
## plot(st_simplify(nz$geometry, dTolerance = 100000, preserveTopology = TRUE))
## 
## plot(rmapshaper::ms_simplify(nz$geometry, keep = 0.05))
## plot(rmapshaper::ms_simplify(nz$geometry, keep = 0.05))
## 
## # Problem: st_simplify returns POLYGON and MULTIPOLYGON results, affecting plotting
## # Cast into a single geometry type to resolve this
## nz_simple_poly = st_simplify(nz$geometry, dTolerance = 10000) %>%
##   st_sfc() %>%
##   st_cast("POLYGON")
## nz_simple_multipoly = st_simplify(nz$geometry, dTolerance = 10000) %>%
##   st_sfc() %>%
##   st_cast("MULTIPOLYGON")
## plot(nz_simple_poly)
## length(nz_simple_poly)
## nrow(nz)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## canterbury = nz[nz$REGC2017_NAME == "Canterbury Region", ]
## cant_buff = st_buffer(canterbury, 100)
## nz_height_near_cant = nz_height[cant_buff, ]
## nrow(nz_height_near_cant) # 66 - 5 more

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## cant_cent = st_centroid(canterbury)
## nz_centre = st_centroid(st_union(nz))
## st_distance(cant_cent, nz_centre) # 234 km

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## world_sfc = world$geom
## world_sfc_mirror = world_sfc * c(1, -1)
## plot(world_sfc)
## plot(world_sfc_mirror)
## 
## us_states_sfc = us_states$geometry
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
## con_raster = raster(system.file("raster/srtm.tif", package="spDataLarge"))
## con_raster_wgs84 = projectRaster(con_raster, crs = wgs84, method = "ngb")
## con_raster_wgs84

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## wgs84 = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
## cat_raster_wgs84 = projectRaster(cat_raster, crs = wgs84, method = "bilinear")
## cat_raster_wgs84

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

