library(tmap)
library(spData)
# Add fill layer to nz shape
m1 = tm_shape(nz) + tm_fill() +
  tm_layout(title = "tm_shape(nz) +\n  tm_fill()", title.size = 0.7)
# Add border layer to nz shape
m2 = tm_shape(nz) + tm_borders() +
  tm_layout("tm_shape(nz) +\n  tm_borders()", title.size = 0.7) 
# Add fill and border layers to nz shape
m3 = tm_shape(nz) + tm_fill() + tm_borders() +
  tm_layout("tm_shape(nz) +\n  tm_fill() +\n  tm_borders()", title.size = 0.7)
tmap_arrange(m1, m2, m3, nrow = 1)

