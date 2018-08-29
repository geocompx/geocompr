library(spDataLarge)
library(tidyverse)
library(sf)
library(gridExtra)
theme_set(theme_bw())

## vector plot ---------------------------------------------------------------
vector_filepath = system.file("vector/zion.gpkg", package = "spDataLarge")
new_vector = st_read(vector_filepath)
new_vector2 = st_transform(new_vector, 4326)

p1 = ggplot() + 
  geom_sf(data = new_vector2) + 
  coord_sf(datum = sf::st_crs(4326)) +
  # theme(axis.text = element_text(size = 4)) +
  labs(x = "Longitude", y = "Latitude")

p2 = ggplot() +
  geom_sf(data = new_vector) +
  coord_sf(datum = sf::st_crs("+proj=utm +zone=12 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")) +
  # theme(axis.text = element_text(size = 4)) +
  labs(x = "x", y = "y")

grid.arrange(p1, p2, nrow = 1)
