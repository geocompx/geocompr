library(sf)
library(dplyr)
library(spData)
library(tmap)
world2 = filter(world, continent != "Antarctica")
m_save = tm_shape(world2) + 
  tm_polygons() +
  tm_shape(urban_agglomerations) +
  tm_symbols(size = "population_millions", size.legend = tm_legend(title = "Population (m)"),
             fill = "red", fill_alpha = 0.5) +
  tm_facets(by = "year", nrow = 1, ncol = 1, free.coords = FALSE)
tmap::tmap_animation(tm = m_save, filename = "/tmp/urban-animated.gif", width = 1200, height = 800)
# magick::image_read("/tmp/urban-animated.gif")
