# Filename: 09-saga-wetness.R (2018-06-19)
#
# TO DO: Compute and visualize SAGA wetness index
#
# Author(s): Jannes Muenchow
#
#**********************************************************
# CONTENTS-------------------------------------------------
#**********************************************************
#
# 1. ATTACH PACKAGES AND DATA
# 2. SAGA WETNESS INDEX
#
#**********************************************************
# 1 ATTACH PACKAGES AND DATA-------------------------------
#**********************************************************

# attach packages
library(tmap)
library(raster)
library(sf)
library(RSAGA)

# attach data
data("landslides", package = "RSAGA")
lsl_sf = st_as_sf(landslides, coords = c("x", "y"), crs = 32717)
write.sgrd(data = dem, file = file.path(tempdir(), "dem"), header = dem$header)
dem = file.path(tempdir(), "dem.sdat") %>%
               raster(crs = st_crs(lsl_sf)$proj4string)

#**********************************************************
# 2 SAGA WETNESS INDEX-------------------------------------
#**********************************************************

# compute SAGA wetness index
rsaga.wetness.index(in.dem = file.path(tempdir(), "dem"), 
                    out.wetness.index = file.path(tempdir(), "twi"))
twi = raster(file.path(tempdir(), "twi.sdat"),
             crs = st_crs(lsl_sf)$proj4string)

# compute hillshade
hs = hillShade(terrain(dem, opt = "slope"), terrain(dem, opt = "aspect"))
rect = tmaptools::bb_poly(hs)
bbx = tmaptools::bb(hs, xlim = c(-0.02, 1), ylim = c(-0.02, 1), relative = TRUE)

# create figure
fig = tm_shape(hs, bbox = bbx) +
  tm_grid(col = "black", n.x = 1, n.y = 1, labels.inside.frame = FALSE,
          labels.rot = c(0, 90)) +
  tm_raster(palette = gray(0:100 / 100), n = 100, legend.show = FALSE) +
  tm_shape(twi) +
  tm_raster(alpha = 0.9,
            palette =  RColorBrewer::brewer.pal(n = 9, name = "Blues"),
            n = 9) +
  qtm(rect, fill = NULL) +
  tm_layout(outer.margins = c(0.04, 0.04, 0.02, 0.02), frame = FALSE) +
  tm_legend(bg.color = "white")
# save the figure
tmap_save(fig, filename = "figures/09_twi.png", dpi = 300, width = 9,
          height = 9.75, units = "cm")
