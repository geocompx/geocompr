library(tmap)
library(grid)

california_raster_centr = rasterToPoints(raster_template2, spatial = TRUE)

r1po = tm_shape(california_raster1) +
  tm_raster(legend.show = TRUE, title = "Values: ") +
  tm_shape(california_raster_centr) + 
  tm_dots() + 
  tm_shape(california) +
  tm_borders() + 
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = rep(0, 4),
            legend.position = c("right", "top"))

r2po = tm_shape(california_raster2) +
  tm_raster(legend.show = TRUE, title = "Values: ") +
  tm_shape(california_raster_centr) + 
  tm_dots() + 
  tm_shape(california) +
  tm_borders() + 
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = rep(0, 4),
            legend.position = c("right", "top"))

grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2, heights = unit(c(0.5, 5), "null"))))

grid.text("A. Line rasterization", vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(r1po, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
grid.text("B. Polygon rasterization", vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(r2po, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))