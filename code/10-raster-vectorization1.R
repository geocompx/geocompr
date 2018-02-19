library(tmap)
library(grid)
colfunc = colorRampPalette(c("lightyellow", "rosybrown"))

p1 = tm_shape(elev) + 
  tm_raster(legend.show = FALSE, palette = colfunc(36), n = 36) +
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = rep(0, 4))

p2 = tm_shape(elev_point) + 
  tm_bubbles(col = "layer", legend.col.show = FALSE, palette = colfunc(36), n = 36) +
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = rep(0.05, 4))

grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2, heights = unit(c(0.25, 5), "null"))))
grid.text("raster", vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
grid.text("points", vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(p1, vp = viewport(layout.pos.col = 1))
print(p2, vp = viewport(layout.pos.col = 2))