library(sf)
library(tmap)
library(spData)
rx = rbind(congruent, incongruent)
# tmap_mode("plot")
m = tm_shape(rx) +
  tm_fill("value", breaks = seq(3.5, 7, by = 0.5)) +
  tm_borders(lwd = 1, col = "black", lty = 1) +
  tm_facets(by = "level", drop.units = TRUE, ncol = 2) +
  tm_shape(aggregating_zones) +
  # tm_borders(alpha = 0.4, lwd = 10, col = "blue")
  tm_borders(alpha = 0.3, lwd = 3, col = "blue")

m1 = m +
  tm_layout(legend.show = FALSE, scale = 1)
m1
# tmap_save(m1, "figures/04-congruence.png", width = 800, height = 400)
