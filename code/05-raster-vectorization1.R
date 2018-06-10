library(tmap)

colfunc = colorRampPalette(c("lightyellow", "rosybrown"))

p1 = tm_shape(elev) + tm_raster(legend.show = FALSE, palette = colfunc(36), n = 36) +
  tm_layout(title = "Raster", outer.margins = rep(0.01, 4), inner.margins = rep(0, 4))

p2 = tm_shape(elev_point) + tm_bubbles(col = "layer", legend.col.show = FALSE, palette = colfunc(36), n = 36) +
  tm_layout(title = "Points", outer.margins = rep(0.01, 4), inner.margins = rep(0.05, 4))

print(tmap_arrange(p1, p2, ncol = 2))