library(spData)
library(tmap)
legend_title = expression("Area (km"^2*")")
map_nza = tm_shape(nz) +
  tm_fill(fill = "Land_area", 
          fill.legend = tm_legend(position = c("left", "top"), title = legend_title)) +
  tm_borders()
c1 = map_nza + tm_title('frame.lwd = 5', position = c("center", "bottom")) + tm_layout(frame.lwd = 5) 
c2 = map_nza + tm_title('inner.margins = rep(0.2, 4)', position = c("center", "bottom")) + tm_layout(inner.margins = rep(0.2, 4))
c3 = map_nza + tm_title('legend.show = FALSE', position = c("center", "bottom")) + tm_layout(legend.show = FALSE)
c4 = tm_shape(nz) +
  tm_fill(fill = "Land_area") +
  tm_borders() + tm_title('legend.position =\n c("right", "bottom")', position = c("center", "top")) + tm_layout(legend.position = c("right", "bottom"))
tmap_arrange(c1, c2, c3, c4, nrow = 1)
