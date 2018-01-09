library(tmap)
library(grid)

r0p = tm_shape(cycle_hire_osm_projected) +
  tm_bubbles(col = "capacity", title.col = "Capacity: ") + 
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = rep(0, 4))

r1p = tm_shape(ch_raster1) + 
  tm_raster(legend.show = TRUE, title = "Values: ") +
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = rep(0, 4))

r2p = tm_shape(ch_raster2) + 
  tm_raster(legend.show = TRUE, title = "Values: ") +
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = rep(0, 4))

r3p = tm_shape(ch_raster3) + 
  tm_raster(legend.show = TRUE, title = "Values: ") +
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = rep(0, 4))

grid.newpage()
pushViewport(viewport(layout = grid.layout(4, 2, heights = unit(rep(c(0.5, 5), 2), "null"))))

grid.text("A. Points", vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(r0p, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
grid.text("B. Presence/absensce", vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(r1p, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))
grid.text("C. Count", vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
print(r2p, vp = viewport(layout.pos.row = 4, layout.pos.col = 1))
grid.text("D. Aggregated capacity", vp = viewport(layout.pos.row = 3, layout.pos.col = 2))
print(r3p, vp = viewport(layout.pos.row = 4, layout.pos.col = 2))