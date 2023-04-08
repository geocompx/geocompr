library(tmap)
tmap_mode("plot")
tm_shape(zones_od) + tm_fill(c("all", "all_dest"), 
                             palette = viridis::plasma(4),
                             breaks = c(0, 2000, 4000, 10000, 50000),
                             title = "Trips")  +
  tm_borders(col = "black", lwd = 0.5) + 
  tm_facets(free.scales = FALSE, ncol = 2) +
  tm_layout(panel.labels = c("Zone of origin", "Zone of destination"))
