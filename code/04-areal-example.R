# Aim: generate plot to show the concept of spatial congruence
library(sf)
library(tmap)
library(spData)
rx = rbind(congruent, incongruent)
tmap_mode("plot")
m = tm_shape(rx) +
  tm_fill("value", breaks = seq(4, 6, by = 0.5)) +
  tm_borders(lwd = 2, col = "black", lty = 1) +
  tm_facets(by = "level", drop.units = TRUE, ncol = 2) +
  tm_shape(aggregating_zones) +
  tm_borders(alpha = 0.4, lwd = 10, col = "blue") +
  tm_layout(legend.show = TRUE, scale = 1)
m
# tmap_save(m, f, width = 1000, height = 400)
# f = "figures/04-congruence.png"
# i = magick::image_read(f)
# i_trimmed = magick::image_trim(i)
# i_trimmed_border = magick::image_border(i_trimmed, color = "white", geometry = "10x10")
# i_trimmed_border
# magick::image_write(i_trimmed_border, f)
# detach("package:tmap", unload = TRUE)
# test visuals ----
# tmap_mode("view")
# qtm(aggzones, borders = "black") +
#   qtm(congruent, fill = "blue", borders = "grey") +
#   qtm(incongruent, fill = "yellow", borders = "white")

# # old solution ----
# rx = st_as_sf(raster::rasterToPolygons(raster::raster(ncol = 4, nrow = 4)))
# ry = st_as_sf(raster::rasterToPolygons(raster::raster(ncol = 2, nrow = 2)))
# rxo = st_as_sf(st_set_geometry(rx, NULL), geometry = rx$geometry + 15)
# st_crs(rx) = NA
# rx = rbind(rx, rxo)
# set.seed(1985)
# rx$value = rep(runif(nrow(rx) / 2), 2)
# rx$layer = rep(c("Congruent", "Incongruent"), each = nrow(rxo))
# library(tmap)

