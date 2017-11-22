# Aim: generate plot to show the concept of spatial congruence
devtools::install_github("robinlovelace/ukboundaries")
library(sf)
library(tmap)
library(ukboundaries)
# data(package = "ukboundaries") # see datasets available
sel_wetherby = grepl("001|002", msoa2011_lds$geo_label)
aggzones = msoa2011_lds[sel_wetherby, ]

# find lsoas in the aggzones (there must be a neater way...)
lsoa_touching = lsoa2011_simple[aggzones, ]
lsoa_cents = st_centroid(lsoa_touching)
lsoa_cents = lsoa_cents[aggzones, ]
congruent = lsoa2011_simple[lsoa_cents, ]

# same for ed zones
ed_touching = ed1981[aggzones, ]
ed_cents = st_centroid(ed_touching)
ed_cents = ed_cents[aggzones, ]
incongruent = ed1981[ed_cents, ]

# Bind the two types of shape together
congruent$layer = "Congruent"
congruent = congruent["layer"]
congruent$value = "blue"
incongruent$layer = "Incongruent"
incongruent = incongruent["layer"]
incongruent$value = "yellow"
rx = rbind(congruent, incongruent)
tmap_mode("plot")
m = qtm(rx, "value", borders = "black") + tm_facets(by = "layer", drop.units = TRUE, ncol = 2) +
  tm_shape(aggzones) +
  tm_borders(alpha = 0.6, lwd = 10) +
  tm_layout(legend.show = FALSE)
detach("package:tmap", unload = TRUE)
save_tmap(m, "figures/04-congruence.png")
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

