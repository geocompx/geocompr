if(!exists("route_cycleway")) {
  source("code/chapters/07-transport.R")
} 
bristol_stations_top = bristol_stations[knn_orig, ]
m_leaflet = qtm(bristol_ways, lines.col = "highway", lines.lwd = 3, lines.palette = c("lightgreen", "grey", "pink")) +
  tm_scale_bar() +
  # tm_shape(bristol_ttwa) +
  # tm_borders(col = "darkblue") +
  tm_shape(route_cycleway) +
  tm_lines(col = "blue", lwd = "all", scale = 20, alpha = 0.6) +
  tm_shape(bristol_stations_top) +
  tm_dots(size = 0.3, col = "red")
