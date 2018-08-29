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
  labs(x = "Longitude", y = "Latitude") + 
  scale_y_continuous(breaks = c(37.15, 37.3, 37.45)) +
  scale_x_continuous(breaks = c(-113.2, -113.1, -113.0, -112.9)) + 
  theme(panel.grid = element_line(size = 1, color = "black", linetype = 2))

p2 = ggplot() +
  geom_sf(data = new_vector) +
  coord_sf(datum = sf::st_crs("+proj=utm +zone=12 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")) +
  labs(x = "x", y = "y") + 
  scale_y_continuous(breaks = c(4120000, 4130000, 4140000, 4150000)) +
  scale_x_continuous(breaks = c(305000, 315000, 325000, 335000)) + 
  theme(panel.grid = element_line(size = 1, color = "black", linetype = 2))

grid.arrange(p1, p2, nrow = 1)
