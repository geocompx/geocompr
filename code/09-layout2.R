library(spData)
library(tmap)
legend_title = expression("Area (km"^2*")")
map_nza = tm_shape(nz) +
  tm_fill(fill = "Land_area", 
          fill.legend = tm_legend(position = c("left", "top"), title = legend_title)) +
  tm_borders()
c1 = map_nza +
  tm_title('frame.lwd = 5', position = c("right", "bottom")) +
  tm_layout(frame.lwd = 5, scale = 0.8) 
c2 = map_nza +
  tm_title('inner.margins = rep(0.2, 4)', position = c("right", "bottom")) +
  tm_layout(inner.margins = rep(0.2, 4), scale = 0.8)
c3 = map_nza +
  tm_title('legend.show = FALSE', position = c("right", "bottom")) + 
  tm_layout(legend.show = FALSE, scale = 0.8)
c4 = tm_shape(nz) +
  tm_fill(fill = "Land_area") +
  tm_borders() +
  tm_title('legend.position =\n c("right", "bottom")', position = c("left", "top")) +
  tm_layout(legend.position = c("right", "bottom"), scale = 0.8)
tmap_arrange(c1, c2, c3, c4, nrow = 2)
