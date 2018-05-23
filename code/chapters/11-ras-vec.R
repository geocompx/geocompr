## ---- message = FALSE----------------------------------------------------
library(sf)
library(raster)
library(tidyverse)
library(spData)
library(spDataLarge)

## ---- results='hide'-----------------------------------------------------
srtm = raster((system.file("raster/srtm.tif", package = "spDataLarge")))
zion = st_read((system.file("vector/zion.gpkg", package = "spDataLarge"))) %>% 
  st_transform(4326)

## ------------------------------------------------------------------------
srtm_cropped = crop(srtm, as(zion, "Spatial"))

## ------------------------------------------------------------------------
srtm_masked = mask(srtm_cropped, zion)

## ----cropmask, echo = FALSE, fig.cap="Illustration of raster cropping (center) and raster masking (right)."----
library(tmap)
library(grid)
library(rcartocolor)
terrain_colors = carto_pal(7, "TealRose")

pz1 = tm_shape(srtm) + 
  tm_raster(palette = terrain_colors, title = "Elevation (m)", 
            legend.show = TRUE, style = "cont") + 
  tm_shape(zion) +
  tm_borders(lwd = 2) + 
  tm_layout(legend.frame = TRUE, legend.position = c("right", "top"))

pz2 = tm_shape(srtm_cropped) + 
  tm_raster(palette = terrain_colors, title = "Elevation (m)", 
            legend.show = TRUE, style = "cont") + 
  tm_shape(zion) +
  tm_borders(lwd = 2) + 
  tm_layout(legend.frame = TRUE, legend.position = c("right", "top"))

pz3 = tm_shape(srtm_masked) + 
  tm_raster(palette = terrain_colors, title = "Elevation (m)",
            legend.show = TRUE, style = "cont") + 
  tm_shape(zion) +
  tm_borders(lwd = 2) + 
  tm_layout(legend.frame = TRUE, legend.position = c("right", "top"))

grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 3, heights = unit(c(0.25, 5), "null"))))
grid.text("A. Original", vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
grid.text("B. Cropped", vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
grid.text("C. Masked", vp = viewport(layout.pos.row = 1, layout.pos.col = 3))
print(pz1, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(pz2, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))
print(pz3, vp = viewport(layout.pos.row = 2, layout.pos.col = 3))

## ------------------------------------------------------------------------
zion_points$elevation = raster::extract(srtm, zion_points)

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
zion_transect = st_sfc(st_linestring(rbind(c(-113.2, 37.45), c(-112.9, 37.2)))) %>% 
  st_sf()

## ------------------------------------------------------------------------
transect_df = raster::extract(srtm, zion_transect, along = TRUE, cellnumbers = TRUE) %>%
  data.frame()

## ------------------------------------------------------------------------
transect_coords = xyFromCell(srtm, transect_df$cell)
transect_df$dist = geosphere::distm(transect_coords)[, 1]

## ----lineextr, echo=FALSE, message=FALSE, warning=FALSE, fig.cap="Location of a line used for raster extraction (left) and the elevation along this line (right)."----
library(tmap)
library(grid)

zion_transect_points = st_cast(zion_transect, "POINT")
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

## ------------------------------------------------------------------------
zion_srtm_values = raster::extract(x = srtm, y = zion, df = TRUE)

## ------------------------------------------------------------------------
our_stats = c(min, mean, max)
names(our_stats) = c("minimum", "mean", "maximum")

## ------------------------------------------------------------------------
zion_srtm_df = our_stats %>% 
  map_dfr(raster::extract, x = srtm, y = zion, df = TRUE, .id = "stat") %>% 
  spread(stat, srtm)
zion_srtm_new = bind_cols(zion, zion_srtm_df)

## ---- warning=FALSE, message=FALSE---------------------------------------
data(nlcd)
zion_nlcd = raster::extract(nlcd, zion, df = TRUE)

## ------------------------------------------------------------------------
zion_count = count(zion_nlcd, ID, layer)
zion_nlcd_df = spread(zion_count, layer, n, fill = 0)
zion_nlcd_new = bind_cols(zion, zion_nlcd_df)

## ----polyextr, echo=FALSE, message=FALSE, warning=FALSE, fig.cap="Area used for continuous (left) and categorical (right) raster extraction."----
library(tmap)
library(grid)

rast_poly_srtm = tm_shape(srtm) +
  tm_raster(palette = terrain_colors, title = "Elevation (m)", 
            legend.show = TRUE, style = "cont") + 
  tm_shape(zion) +
  tm_borders(lwd = 2) +
  tm_layout(legend.frame = TRUE, legend.position = c("left", "bottom"))

landcover_cols = c("#476ba0", "#aa0000", "#b2ada3", "#68aa63", "#a58c30", "#c9c977", "#dbd83d", "#bad8ea")

rast_poly_nlcd = tm_shape(nlcd) +
  tm_raster(palette = landcover_cols, style = "cat", title = "Land cover", 
            legend.show = TRUE) + 
  tm_shape(zion) +
  tm_borders(lwd = 2) +
  tm_layout(legend.frame = TRUE, legend.position = c("left", "bottom"))

grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2, heights = unit(c(0.25, 5), "null"))))
grid.text("A. Continuous data extraction", vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
grid.text("B. Categorical data extraction", vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(rast_poly_srtm, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(rast_poly_nlcd, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))

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
source("code/11-vector-rasterization1.R")

## ------------------------------------------------------------------------
california = dplyr::filter(us_states, NAME == "California")
california_borders = st_cast(california, "MULTILINESTRING")
raster_template2 = raster(extent(california), resolution = 0.5,
                         crs = st_crs(california)$proj4string)

## ------------------------------------------------------------------------
california_raster1 = rasterize(california_borders, raster_template2)

## ------------------------------------------------------------------------
california_raster2 = rasterize(california, raster_template2)

## ----vector-rasterization2, echo=FALSE, fig.cap="Examples of line and polygon rasterizations.", warning=FALSE----
source("code/11-vector-rasterization2.R")

## Be careful with the wording!

## ------------------------------------------------------------------------
elev_point = rasterToPoints(elev, spatial = TRUE) %>% 
  st_as_sf()

## ----raster-vectorization1, echo=FALSE, fig.cap="Raster and point representation of `elev`.", warning=FALSE----
source("code/11-raster-vectorization1.R")

## ---- eval = FALSE-------------------------------------------------------
## # not shown
## data(dem, package = "RQGIS")
## plot(dem, axes = FALSE)
## plot(rasterToContour(dem), add = TRUE)

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
	          auto.palette.mapping = FALSE, legend.show = FALSE) +
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
source("code/11-raster-vectorization2.R")

## ---- message=FALSE------------------------------------------------------
library(RQGIS)
data(random_points)
data(ndvi)
ch = st_combine(random_points) %>% 
  st_convex_hull()

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
## random_points$ndvi = extract(ndvi, random_points, buffer = 90, fun = mean)
## random_points$ndvi2 = extract(ndvi, random_points)
## plot(random_points$ndvi, random_points$ndvi2)

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## nz_height3100 = dplyr::filter(nz_height, elevation > 3100)
## new_graticule = st_graticule(nz_height3100, datum = 2193)
## plot(nz_height3100$geometry, graticule = new_graticule, axes = TRUE)
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

