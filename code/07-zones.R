library(tmap)
tmap_mode("plot")
qtm(zones, c("all", "all_dest"), fill.palette = viridis::plasma(5),
    fill.breaks = c(0, 2000, 4000, 10000, 40000), fill.title = "Trips") +
  tm_facets(free.scales = FALSE) +
  tm_layout(panel.labels = c("Zone of origin", "Zone of destination"))