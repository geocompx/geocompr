if(!exists("route_cycleway")) {
  source("code/chapters/13-transport.R")
} 
tmap_mode("plot")
bristol_stations_top = bristol_stations[desire_rail, , op = st_is_within_distance, dist = 500]
m_leaflet = tm_shape(bristol_ttwa) +
  tm_borders(col = "darkblue") +
  tm_shape(bristol_ways) +
  tm_lines(col = "highway", lwd = 3, palette = c("lightgreen", "grey", "pink")) +
  tm_scale_bar() +
  tm_shape(route_cycleway) +
  tm_lines(col = "blue", lwd = "all", scale = 20, alpha = 0.6) +
  tm_shape(bristol_stations_top) +
  tm_dots(size = 0.3, col = "red") +
  tm_layout(legend.position = c("LEFT", "TOP"))
# m_leaflet
