## ----06-raster-vector-1, message=FALSE--------------------------------------------------------------------------------------------------------------------
library(dplyr)
library(terra)
library(sf)


## ----06-raster-vector-2, results='hide'-------------------------------------------------------------------------------------------------------------------
srtm = rast(system.file("raster/srtm.tif", package = "spDataLarge"))
zion = read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))
zion = st_transform(zion, crs(srtm))


## ----06-raster-vector-3-----------------------------------------------------------------------------------------------------------------------------------
srtm_cropped = crop(srtm, zion)


## ----06-raster-vector-4-----------------------------------------------------------------------------------------------------------------------------------
srtm_masked = mask(srtm, zion)


## ----06-raster-vector-5-----------------------------------------------------------------------------------------------------------------------------------
srtm_cropped = crop(srtm, zion)
srtm_final = mask(srtm_cropped, zion)


## ----06-raster-vector-6-----------------------------------------------------------------------------------------------------------------------------------
srtm_inv_masked = mask(srtm, zion, inverse = TRUE)


## ----cropmask, echo = FALSE, fig.cap="Illustration of raster cropping and raster masking.", fig.asp=0.36, fig.width = 10, warning=FALSE-------------------
library(tmap)
library(rcartocolor)
terrain_colors = carto_pal(7, "Geyser")
pz1 = tm_shape(srtm) + 
  tm_raster(palette = terrain_colors, legend.show = FALSE, style = "cont") + 
  tm_shape(zion) + 
  tm_borders(lwd = 2) + 
  tm_layout(main.title = "A. Original", inner.margins = 0)
pz2 = tm_shape(srtm_cropped) +
  tm_raster(palette = terrain_colors, legend.show = FALSE, style = "cont") + 
  tm_shape(zion) +
  tm_borders(lwd = 2) + 
  tm_layout(main.title = "B. Crop", inner.margins = 0)
pz3 = tm_shape(srtm_masked) + 
  tm_raster(palette = terrain_colors, legend.show = FALSE, style = "cont") + 
  tm_shape(zion) + 
  tm_borders(lwd = 2) + 
  tm_layout(main.title = "C. Mask", inner.margins = 0)
pz4 = tm_shape(srtm_inv_masked) +
  tm_raster(palette = terrain_colors, legend.show = FALSE, style = "cont") + 
  tm_shape(zion) +
  tm_borders(lwd = 2) + 
  tm_layout(main.title = "D. Inverse mask", inner.margins = 0)
tmap_arrange(pz1, pz2, pz3, pz4, ncol = 4, asp = NA)


## ----06-raster-vector-8-----------------------------------------------------------------------------------------------------------------------------------
data("zion_points", package = "spDataLarge")
elevation = terra::extract(srtm, zion_points)
zion_points = cbind(zion_points, elevation)


## ----06-raster-vector-9, echo=FALSE, eval=FALSE-----------------------------------------------------------------------------------------------------------
## library(dplyr)
## zion_points2 = zion_points
## zion_points2$a = 1
## zion_points2 = zion_points2 |> group_by(a) |> summarise()
## elevation = terra::extract(srtm, zion_points2)
## zion_points = cbind(zion_points, elevation)


## ----pointextr, echo=FALSE, message=FALSE, warning=FALSE, fig.cap="Locations of points used for raster extraction.", fig.asp=0.57-------------------------
source("https://github.com/Robinlovelace/geocompr/raw/main/code/06-pointextr.R", print.eval = TRUE)


## ----06-raster-vector-11----------------------------------------------------------------------------------------------------------------------------------
zion_transect = cbind(c(-113.2, -112.9), c(37.45, 37.2)) |>
  st_linestring() |> 
  st_sfc(crs = crs(srtm)) |>
  st_sf(geometry = _)


## ----06-raster-vector-12, eval=FALSE, echo=FALSE----------------------------------------------------------------------------------------------------------
## # Aim: show how extraction works with non-straight lines by
## # using this alternative line object:
## zion_transect2 = cbind(c(-113.2, -112.9, -113.2), c(36.45, 37.2, 37.5)) |>
##   st_linestring() |>
##   st_sfc(crs = crs(srtm)) |>
##   st_sf()
## zion_transect = rbind(zion_transect, zion_transect2)


## ----06-raster-vector-13, warning=FALSE-------------------------------------------------------------------------------------------------------------------
zion_transect$id = 1:nrow(zion_transect)
zion_transect = st_segmentize(zion_transect, dfMaxLength = 250)
zion_transect = st_cast(zion_transect, "POINT")


## ----06-raster-vector-14----------------------------------------------------------------------------------------------------------------------------------
zion_transect = zion_transect |> 
  group_by(id) |> 
  mutate(dist = st_distance(geometry)[, 1]) 


## ----06-raster-vector-15----------------------------------------------------------------------------------------------------------------------------------
zion_elev = terra::extract(srtm, zion_transect)
zion_transect = cbind(zion_transect, zion_elev)


## ----lineextr, echo=FALSE, message=FALSE, warning=FALSE, fig.cap="Location of a line used for raster extraction (left) and the elevation along this line (right).", fig.scap="Line-based raster extraction."----
library(tmap)
library(grid)
library(ggplot2)

zion_transect_line = cbind(c(-113.2, -112.9), c(37.45, 37.2)) |>
  st_linestring() |> 
  st_sfc(crs = crs(srtm)) |> 
  st_sf()

zion_transect_points = st_cast(zion_transect, "POINT")[c(1, nrow(zion_transect)), ]
zion_transect_points$name = c("start", "end")

rast_poly_line = tm_shape(srtm) +
  tm_raster(palette = terrain_colors, title = "Elevation (m)", 
            legend.show = TRUE, style = "cont") + 
  tm_shape(zion) +
  tm_borders(lwd = 2) + 
  tm_shape(zion_transect_line) + 
  tm_lines(col = "black", lwd = 4) + 
  tm_shape(zion_transect_points) +                                                 
  tm_text("name", bg.color = "white", bg.alpha = 0.75, auto.placement = TRUE) +
  tm_layout(legend.frame = TRUE, legend.position = c("right", "top"))

plot_transect = ggplot(zion_transect, aes(as.numeric(dist), srtm)) + 
  geom_line() +
  labs(x = "Distance (m)", y = "Elevation (m a.s.l.)") + 
  theme_bw() +
  # facet_wrap(~id) +
  theme(plot.margin = unit(c(5.5, 15.5, 5.5, 5.5), "pt"))

grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2, heights = unit(c(0.25, 5), "null"))))
grid.text("A. Line extraction", vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
grid.text("B. Elevation along the line", vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(rast_poly_line, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(plot_transect, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))


## ----06-raster-vector-17, eval=FALSE, echo=FALSE----------------------------------------------------------------------------------------------------------
## # aim: create zion_many to test multi-polygon results
## n = 3
## zion_many = st_sample(x = zion, size = n) |>
##   st_buffer(dist = 500) |>
##   st_sf(data.frame(v = 1:n), geometry = _)
## plot(zion_many)
## 
## # for continuous data:
## zion_srtm_values1 = terra::extract(x = srtm, y = zion_many, fun = min)
## zion_srtm_values2 = terra::extract(x = srtm, y = zion_many, fun = mean)
## zion_srtm_values3 = terra::extract(x = srtm, y = zion_many, fun = max)
## 
## # for categories
## nlcd = rast(system.file("raster/nlcd.tif", package = "spDataLarge"))
## zion_many2 = st_transform(zion_many, st_crs(nlcd))
## zion_nlcd = terra::extract(nlcd, zion_many2)
## count(zion_nlcd, levels)


## ----06-raster-vector-18----------------------------------------------------------------------------------------------------------------------------------
zion_srtm_values = terra::extract(x = srtm, y = zion)


## ----06-raster-vector-19----------------------------------------------------------------------------------------------------------------------------------
group_by(zion_srtm_values, ID) |> 
  summarize(across(srtm, list(min = min, mean = mean, max = max)))


## ----06-raster-vector-20, warning=FALSE, message=FALSE----------------------------------------------------------------------------------------------------
nlcd = rast(system.file("raster/nlcd.tif", package = "spDataLarge"))
zion2 = st_transform(zion, st_crs(nlcd))
zion_nlcd = terra::extract(nlcd, zion2)
zion_nlcd |> 
  group_by(ID, levels) |>
  count()


## ----polyextr, echo=FALSE, message=FALSE, warning=FALSE, fig.cap="Area used for continuous (left) and categorical (right) raster extraction."-------------
rast_poly_srtm = tm_shape(srtm) + 
  tm_raster(palette = terrain_colors, title = "Elevation (m)",
            legend.show = TRUE, style = "cont") + 
  tm_shape(zion) +
  tm_polygons(lwd = 2, alpha = 0.3) +
  tm_layout(main.title = "A. Continuous data extraction",
            main.title.size = 1, legend.frame = TRUE,
            legend.position = c("left", "bottom"))
rast_poly_nlcd = tm_shape(nlcd) +
  tm_raster(drop.levels = TRUE, title = "Land cover", legend.show = TRUE) + 
  tm_shape(zion) +
  tm_polygons(lwd = 2, alpha = 0.3) +
  tm_layout(main.title = "B. Categorical data extraction", 
            main.title.size = 1, legend.frame = TRUE, 
            legend.position = c("left", "bottom"))
tmap_arrange(rast_poly_srtm, rast_poly_nlcd, ncol = 2)


## Polygons usually have irregular shapes, and therefore, a polygon can overlap only some parts of a raster's cells.

## To get more detailed results, the `extract()` function has an argument called `exact`.

## With `exact = TRUE`, we get one more column `fraction` in the output data frame, which contains a fraction of each cell that is covered by the polygon.

## This could be useful to calculate a weighted mean for continuous rasters or more precise coverage for categorical rasters.

## By default, it is `FALSE` as this operation requires more computations.

## The `exactextractr::exact_extract()` function always computes the coverage fraction of the polygon in each cell.


## ----06-raster-vector-23, include=FALSE-------------------------------------------------------------------------------------------------------------------
zion_srtm_values = terra::extract(x = srtm, y = zion, exact = FALSE)


## ----06-raster-vector-24----------------------------------------------------------------------------------------------------------------------------------
cycle_hire_osm = spData::cycle_hire_osm
cycle_hire_osm_projected = st_transform(cycle_hire_osm, "EPSG:27700")
raster_template = rast(ext(cycle_hire_osm_projected), resolution = 1000,
                       crs = st_crs(cycle_hire_osm_projected)$wkt)


## ----06-raster-vector-25----------------------------------------------------------------------------------------------------------------------------------
ch_raster1 = rasterize(cycle_hire_osm_projected, raster_template,
                       field = 1)


## ----06-raster-vector-26----------------------------------------------------------------------------------------------------------------------------------
ch_raster2 = rasterize(cycle_hire_osm_projected, raster_template, 
                       fun = "length")


## ----06-raster-vector-27----------------------------------------------------------------------------------------------------------------------------------
ch_raster3 = rasterize(cycle_hire_osm_projected, raster_template, 
                       field = "capacity", fun = sum)


## ----vector-rasterization1, echo=FALSE, fig.cap="Examples of point rasterization.", warning=FALSE---------------------------------------------------------
source("https://github.com/Robinlovelace/geocompr/raw/main/code/06-vector-rasterization1.R", print.eval = TRUE)


## ----06-raster-vector-29----------------------------------------------------------------------------------------------------------------------------------
california = dplyr::filter(us_states, NAME == "California")
california_borders = st_cast(california, "MULTILINESTRING")
raster_template2 = rast(ext(california), resolution = 0.5,
                        crs = st_crs(california)$wkt)


## ----06-raster-vector-30----------------------------------------------------------------------------------------------------------------------------------
california_raster1 = rasterize(california_borders, raster_template2,
                               touches = TRUE)


## ----06-raster-vector-31----------------------------------------------------------------------------------------------------------------------------------
california_raster2 = rasterize(california, raster_template2) 


## ----vector-rasterization2, echo=FALSE, fig.cap="Examples of line and polygon rasterizations.", warning=FALSE---------------------------------------------
source("https://github.com/Robinlovelace/geocompr/raw/main/code/06-vector-rasterization2.R", print.eval = TRUE)


## Be careful with the wording!

## In R, vectorization refers to the possibility of replacing `for`-loops and alike by doing things like `1:10 / 2` (see also @wickham_advanced_2019).


## ----06-raster-vector-34----------------------------------------------------------------------------------------------------------------------------------
elev = rast(system.file("raster/elev.tif", package = "spData"))
elev_point = as.points(elev) |> 
  st_as_sf()


## ----raster-vectorization1, echo=FALSE, fig.cap="Raster and point representation of the elev object.", warning=FALSE--------------------------------------
source("https://github.com/Robinlovelace/geocompr/raw/main/code/06-raster-vectorization1.R", print.eval = TRUE)


## ----06-raster-vector-36, eval=FALSE----------------------------------------------------------------------------------------------------------------------
## dem = rast(system.file("raster/dem.tif", package = "spDataLarge"))
## cl = as.contour(dem)
## plot(dem, axes = FALSE)
## plot(cl, add = TRUE)


## ----contour-tmap, echo=FALSE, message=FALSE, fig.cap="DEM with hillshading, showing the southern flank of Mt. Mongón overlaid with contour lines.", fig.scap="DEM with hillshading.", warning=FALSE, fig.asp=0.56----
# hs = shade(slope = terrain(dem, "slope", unit = "radians"),
#            aspect = terrain(dem, "aspect", unit = "radians"))
# plot(hs, col = gray(0:100 / 100), legend = FALSE)
# # overlay with DEM
# plot(dem, col = terrain.colors(25), alpha = 0.5, legend = FALSE, add = TRUE)
# # add contour lines
# contour(dem, col = "white", add = TRUE)
knitr::include_graphics("figures/06-contour-tmap.png")


## ----06-raster-vector-39----------------------------------------------------------------------------------------------------------------------------------
grain = rast(system.file("raster/grain.tif", package = "spData"))
grain_poly = as.polygons(grain) |> 
  st_as_sf()


## ----06-raster-vector-40, echo=FALSE, fig.cap="Illustration of vectorization of raster (left) into polygons (dissolve = FALSE; center) and aggregated polygons (dissolve = TRUE; right).", warning=FALSE, fig.asp=0.4, fig.scap="Illustration of vectorization."----
source("https://github.com/Robinlovelace/geocompr/raw/main/code/06-raster-vectorization2.R", print.eval = TRUE)


## ---- echo=FALSE, results='asis'--------------------------------------------------------------------------------------------------------------------------
res = knitr::knit_child('_06-ex.Rmd', quiet = TRUE, options = list(include = FALSE, eval = FALSE))
cat(res, sep = '\n')

