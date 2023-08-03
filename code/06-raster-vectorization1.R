library(tmap)
library(spData)
library(terra)
elev = rast(system.file("raster/elev.tif", package = "spData"))
elev_point = as.points(elev) |> st_as_sf()

p1 = tm_shape(elev) + 
  tm_raster(col.scale = tm_scale(n = 36)) +
  tm_title("A. Raster") +
  tm_layout(outer.margins = rep(0.01, 4), inner.margins = rep(0, 4), legend.show = FALSE)
p2 = tm_shape(elev_point) +
  tm_symbols(fill = "elev", fill.scale = tm_scale(n = 36), size = 2) +
  tm_title("B. Points") +
  tm_layout(outer.margins = rep(0.01, 4), inner.margins = rep(0.09, 4), legend.show = FALSE)
tmap_arrange(p1, p2, ncol = 2)
