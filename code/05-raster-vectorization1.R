library(tmap)
library(spData)
library(terra)

elev_point = as.points(elev) %>% st_as_sf()

p1 = tm_shape(elev) + 
  tm_raster(legend.show = FALSE, n = 36) +
  tm_layout(main.title = "A. Raster", outer.margins = rep(0.01, 4), inner.margins = rep(0, 4))

p2 = tm_shape(elev_point) +
  tm_bubbles(col = "elev", legend.col.show = FALSE, n = 36) +
  tm_layout(main.title = "B.Points", outer.margins = rep(0.01, 4), inner.margins = rep(0.09, 4))

tmap_arrange(p1, p2, ncol = 2)