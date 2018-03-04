library(spDataLarge)
library(tidyverse)
library(sf)
library(gridExtra)
library(raster)
library(rasterVis)
library(sfraster)
library(rcartocolor)
theme_set(theme_bw())

## vector plot ---------------------------------------------------------------
vector_filepath = system.file("vector/zion.gpkg", package="spDataLarge")
new_vector = st_read(vector_filepath)
new_vector2 = st_transform(new_vector, 4326)

p1 = ggplot() +
  geom_sf(data = new_vector) +
  coord_sf(datum = sf::st_crs("+proj=utm +zone=12 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")) +
  theme(axis.text = element_text(size = 4))

p2 = ggplot() + 
  geom_sf(data = new_vector2) + 
  coord_sf(datum = sf::st_crs(4326)) +
  theme(axis.text = element_text(size = 4))

vector_crs = arrangeGrob(p2, p1, nrow = 1)

ggsave(plot = vector_crs,
       filename = "figures/02_vector_crs.png",
       width = 5.1, height = 3.0,
       units = "in")


## raster plot ---------------------------------------------------------------
raster_filepath = system.file("raster/srtm.tif", package = "spDataLarge")
new_raster = raster(raster_filepath) #%>% mask(., new_vector)
new_raster2 = projectRaster(new_raster, crs = "+init=epsg:4326")

pr1 = levelplot(new_raster, margin = FALSE, colorkey = FALSE,
                par.settings = rasterTheme(region = carto_pal(7, "TealRose")))
pr2 = levelplot(new_raster2, margin = FALSE, colorkey = FALSE)

png(filename = "figures/02_raster_crs.png", width = 950, height = 555)
plot(pr2, split=c(1, 1, 2, 1), more=TRUE)
plot(pr1, split=c(2, 1, 2, 1))
dev.off()
