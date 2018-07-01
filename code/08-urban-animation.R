library(sf)
library(tidyverse)
library(spData)
library(tmap)
m_save = world %>% filter(continent != "Antarctica") %>% 
  tm_shape() + 
  tm_polygons() +
  tm_shape(urban_agglomerations) +
  tm_dots(size = "population_millions", title.size = "Population (m)", alpha = 0.5, col = "red") +
  tm_facets(along = "year", free.coords = FALSE)
tmap::tmap_animation(tm = m_save, filename = "/tmp/urban-animated.gif", width = 1200, height = 800)
magick::image_read("/tmp/urban-animated.gif")
