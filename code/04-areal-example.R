# Aim: generate plot to show the concept of spatial congruence
library(sf)
library(tmap)
library(spData)
rx = rbind(congruent, incongruent)
# tmap_mode("plot")
m = tm_shape(rx) +
  tm_fill("value", breaks = seq(4, 6, by = 0.5)) +
  tm_borders(lwd = 2, col = "black", lty = 1) +
  tm_facets(by = "level", drop.units = TRUE, ncol = 2) +
  tm_shape(aggregating_zones) +
  tm_borders(alpha = 0.4, lwd = 10, col = "blue")

m1 = m +
  tm_layout(legend.show = FALSE, scale = 1)

m2 = tm_shape(rx) +
  tm_fill("value", breaks = seq(4, 6, by = 0.5)) +
  tm_layout(legend.only = TRUE)

tmap_arrange(m1, m2, ncol = 2)
