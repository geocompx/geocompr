# Aim: demonstrate spatial joins ------------------------------------------
library(sf)
library(spData)
library(tmap)
# names(world)
# names(urban_agglomerations)
# Question arising from the data:
# what % of country populations lived in their largest agglomerations?
# explanation: we're joining the point data onto world

if (!exists("random_joined")) {
  set.seed(2018)
  bb = st_bbox(world)
  random_df = tibble::tibble(
    x = runif(n = 10, min = bb[1], max = bb[3]),
    y = runif(n = 10, min = bb[2], max = bb[4])
  )
  random_points = st_as_sf(random_df, coords = c("x", "y")) |> 
    st_set_crs("EPSG:4326")
  
  world_random = world[random_points, ]
  random_joined = st_join(random_points, world["name_long"])
  
}

# summary(random_joined$name_long) # factors still there
random_joined$name_long = as.character(random_joined$name_long)

jm0 = tm_shape(world) + tm_borders(lwd = 0.2) + tm_format("World")

jm1 = jm0 +
  tm_shape(shp = random_points, bbox = bb) +
  tm_symbols(col = "black", shape = 4, lwd = 3)

jm2 = jm0 +
  tm_shape(world_random, bbox = bb) +
  tm_fill(fill = "name_long", fill.scale = tm_scale(values = "Dark2")) +
  tm_layout(legend.show = FALSE)

jm3 = jm0 +
  tm_shape(shp = random_joined, bbox = bb) +
  tm_symbols(col = "name_long", shape = 4, lwd = 3, col.scale = tm_scale(values = "Dark2")) +
  tm_layout(legend.show = FALSE)

jm4 = jm0 +
  tm_shape(shp = random_joined, bbox = bb) +
  tm_symbols(col = "name_long", shape = 4, lwd = 3, col.scale = tm_scale(values = "Dark2")) +
  tm_layout(legend.only = TRUE)

tmap_arrange(jm1, jm2, jm3, jm4, nrow = 2, ncol = 2)

