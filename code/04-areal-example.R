library(sf)
library(tmap)
library(spData)
rx = rbind(congruent, incongruent)
# tmap_mode("plot")
m1 = tm_shape(rx) +
  tm_fill("value", fill.scale = tm_scale(breaks = seq(3.5, 7, by = 0.5))) +
  tm_borders(lwd = 1, col = "black", lty = 1) +
  tm_facets(by = "level", drop.units = TRUE, ncol = 2) +
  tm_shape(aggregating_zones) +
  tm_borders(col_alpha = 0.2, lwd = 8, col = "red") +
  tm_layout(legend.show = FALSE, scale = 1)
m1