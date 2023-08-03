library(tmap)
library(spData)
library(terra)
grain = rast(system.file("raster/grain.tif", package = "spData"))
grain_poly = as.polygons(grain, dissolve = FALSE) %>% 
  st_as_sf()
grain_poly2 = as.polygons(grain) %>% 
  st_as_sf()

cols = c("clay" = "brown", "sand" = "rosybrown", "silt" = "sandybrown")

p1p = tm_shape(grain) +
  tm_raster("grain", col.scale = tm_scale(values = cols)) +
  tm_title("A. Raster") +
  tm_layout(frame = FALSE, legend.show = FALSE)

p2p = tm_shape(grain_poly) +
  tm_polygons("grain", fill.scale = tm_scale(values = cols), lwd = 3) +
  tm_title("B.Polygons") +
  tm_layout(frame = FALSE, legend.show = FALSE)

p3p = tm_shape(grain_poly2) + 
  tm_polygons("grain", fill.scale = tm_scale(values = cols), lwd = 3)  +
  tm_title("C. Aggregated polygons") +
  tm_layout(frame = FALSE, legend.show = FALSE)

tmap_arrange(p1p, p2p, p3p, ncol = 3)
