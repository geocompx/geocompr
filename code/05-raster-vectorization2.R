library(tmap)
library(spData)

cols = c("clay" = "brown", "sand" = "rosybrown", "silt" = "sandybrown")

p1p = tm_shape(grain) + tm_raster(legend.show = FALSE, palette = cols) +
  tm_layout(main.title = "Raster")

p2p = tm_shape(grain_poly) + tm_polygons("layer", legend.show = FALSE, palette = cols, lwd = 3) +
  tm_layout(main.title = "Polygons")

p3p = tm_shape(grain_poly2) + tm_polygons("layer", legend.show = FALSE, palette = cols, lwd = 3) +
  tm_layout(main.title = "Aggregated polygons")

tmap_arrange(p1p, p2p, p3p, ncol = 3)
