# Aim: generate plot to show the concept of spatial congruence
library(sf)
library(tmap)
library(spData)
rx = rbind(congruent, incongruent)
# tmap_mode("plot")
m = tm_shape(rx) +
  tm_fill("value", breaks = seq(4, 6, by = 0.5)) +
  tm_borders(lwd = 2, col = "black", lty = 1) +
  tm_facets(by = "level", drop.units = TRUE, ncol = 1) +
  tm_shape(aggregating_zones) +
  tm_borders(alpha = 0.4, lwd = 10, col = "blue") +
  tm_layout(legend.show = TRUE, scale = 1)

m
