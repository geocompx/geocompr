library(tmap)

r0p = tm_shape(cycle_hire_osm_projected) + tm_symbols(col = "capacity", title.col = "Capacity: ", size = 0.1) + 
  tm_layout(main.title = "A. Points", main.title.size = 1, legend.position = c("right", "bottom"))

r1p = tm_shape(ch_raster1) + tm_raster(legend.show = TRUE, title = "Values: ") + tm_layout(main.title = "B. Presence/absence", main.title.size = 1, legend.position = c("right", "bottom"))

r2p = tm_shape(ch_raster2) + tm_raster(legend.show = TRUE, title = "Values: ") + tm_layout(main.title = "C. Count", main.title.size = 1, legend.position = c("right", "bottom"))

r3p = tm_shape(ch_raster3) + tm_raster(legend.show = TRUE, title = "Values: ") + tm_layout(main.title = "D. Aggregated capacity", main.title.size = 1, legend.position = c("right", "bottom"))

tmap_arrange(r0p, r1p, r2p, r3p, ncol = 2)
