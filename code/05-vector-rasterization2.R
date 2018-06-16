library(tmap)

california_raster_centr = rasterToPoints(raster_template2, spatial = TRUE)

r1po = tm_shape(california_raster1) + tm_raster(col = "NAME", legend.show = TRUE, title = "Values: ") +
  tm_shape(california_raster_centr) + tm_dots() + 
  tm_shape(california) + tm_borders() + 
  tm_layout(title = "A. Line rasterization", legend.show = FALSE)

r2po = tm_shape(california_raster2) + tm_raster(col = "NAME", legend.show = TRUE, title = "Values: ") +
  tm_shape(california_raster_centr) + tm_dots() + 
  tm_shape(california) + tm_borders() + 
  tm_layout(title = "B. Polygon rasterization", legend.show = FALSE)

print(tmap_arrange(r1po, r2po, ncol = 2))