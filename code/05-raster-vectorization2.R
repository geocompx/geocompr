library(tmap)
library(grid)
cols = c("clay" = "brown", "sand" = "rosybrown", "silt" = "sandybrown")

p1p = tm_shape(grain) + 
  tm_raster(legend.show = FALSE, palette = cols) +
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = rep(0, 4))

p2p = tm_shape(grain_poly) + 
  tm_polygons("layer", legend.show = FALSE, palette = cols, lwd = 3) +
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = rep(0, 4))

p3p = tm_shape(grain_poly2) + 
  tm_polygons("layer", legend.show = FALSE, palette = cols, lwd = 3) +
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = rep(0, 4))

grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 3, heights = unit(c(0.25, 5), "null"))))
grid.text("raster", vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
grid.text("polygons", vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
grid.text("aggregated polygons", vp = viewport(layout.pos.row = 1, layout.pos.col = 3))
print(p1p, vp=viewport(layout.pos.col = 1))
print(p2p, vp=viewport(layout.pos.col = 2))
print(p3p, vp=viewport(layout.pos.col = 3))