# Aim: demonstrate spatial joins ------------------------------------------
library(sf)
library(spData)
library(tmap)
# names(world)
# names(urban_agglomerations)
# Question arising from the data:
# what % of country populations lived in their largest agglomorations?
# explanation: we're joining the point data onto world

if(!exists("random_joined")) {
  set.seed(2018)
  bb_world = st_bbox(world)
  random_df = tibble(
    x = runif(n = 10, min = bb_world[1], max = bb_world[3]),
    y = runif(n = 10, min = bb_world[2], max = bb_world[4])
  )
  random_points = st_as_sf(random_df, coords = c("x", "y")) %>% 
    st_set_crs(4326)
  
  world_random = world[random_points, ]
  random_joined = st_join(random_points, world["name_long"])
  
}
jm0 = tm_shape(world) +
  tm_borders()
jm1 = jm0 +
  tm_shape(shp = random_points, bbox = bb_world) +
  tm_symbols(col = "black", shape = 4, border.lwd = 2) +
  tm_layout(scale = 1, legend.bg.color = "white", legend.bg.alpha = 0.3, legend.position = c("right", "bottom"))
jm2 = jm0 +
  tm_shape(world_random, bbox = bb_world) +
  tm_polygons(col = "name_long", border.col = "black", lwd = 2, palette = "Dark2") +
  # tm_borders(col = "name_long", lwd = 4) + # issue with tmap: no variable border
  tm_layout(scale = 1, legend.bg.color = "white", legend.bg.alpha = 0.3, legend.position = c("right", "bottom"))
jm3 = jm0 +
  tm_shape(shp = random_joined, bbox = bb_world) +
  tm_symbols(col = "name_long", shape = 4, border.lwd = 2, palette = "Dark2") +
  tm_layout(scale = 1, legend.bg.color = "white", legend.bg.alpha = 0.3, legend.position = c("right", "bottom"))