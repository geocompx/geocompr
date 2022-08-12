library(tmap)
library(sf)
vector_filepath = system.file("vector/zion.gpkg", package = "spDataLarge")
new_vector = read_sf(vector_filepath)
new_vector2 = st_transform(new_vector, "EPSG:4326")

tm1 = tm_shape(new_vector2) +
  tm_graticules(n.x = 3, n.y = 4) +
  tm_polygons() +
  tm_ylab("Latitude", space = 0.5) +
  tm_xlab("Longitude")

tm2 = tm_shape(new_vector) +
  tm_grid(n.x = 3, n.y = 4) +
  tm_polygons() +
  tm_ylab("y") +
  tm_xlab("x")

tm = tmap_arrange(tm1, tm2)
tmap_save(tm, "figures/02_vector_crs.png", 
          width = 950*1.5, height = 532*1.5, dpi = 150, 
          scale = 1.5)
