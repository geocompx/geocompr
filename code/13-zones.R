library(tmap)
tmap_mode("plot")
tm_shape(zones_od) + 
  tm_fill(c("all", "all_dest"), 
          fill.scale = tm_scale(values =  viridis::plasma(4), breaks = c(0, 2000, 4000, 10000, 50000)),
          fill.legend = tm_legend(title = "Trips", position = tm_pos_out("right", "center")),
          fill.free = FALSE)  +
  tm_facets() +
  tm_borders(col = "black", lwd = 0.5) + 
  tm_layout(panel.labels = c("Zone of origin", "Zone of destination"))
