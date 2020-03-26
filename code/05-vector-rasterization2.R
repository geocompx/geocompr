library(tmap)

if(!exists("raster_template2")) {
  library(sf)
  library(raster)
  library(spData)
  library(spDataLarge)
  california = dplyr::filter(us_states, NAME == "California")
  california_borders = st_cast(california, "MULTILINESTRING")
  raster_template2 = raster(extent(california), resolution = 0.5,
                            crs = st_crs(california)$proj4string)
  
  california_raster1 = rasterize(as(california_borders, "Spatial"), raster_template2)
  
  california_raster2 = rasterize(as(california, "Spatial"), raster_template2)
}

california_raster_centr = rasterToPoints(raster_template2, spatial = TRUE)

r1po = tm_shape(california_raster1) + tm_raster(col = "layer", legend.show = TRUE, title = "Values: ") +
  tm_shape(california_raster_centr) + tm_dots() + 
  tm_shape(california) + tm_borders() + 
  tm_layout(main.title = "A. Line rasterization", main.title.size = 1, legend.show = FALSE)

r2po = tm_shape(california_raster2) + tm_raster(col = "layer", legend.show = TRUE, title = "Values: ") +
  tm_shape(california_raster_centr) + tm_dots() + 
  tm_shape(california) + tm_borders() + 
  tm_layout(main.title = "B. Polygon rasterization", main.title.size = 1, legend.show = FALSE)

tmap_arrange(r1po, r2po, ncol = 2)
