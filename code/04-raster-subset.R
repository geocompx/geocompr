library(tmap)
library(sf)
library(terra)
elev = rast(system.file("raster/elev.tif", package = "spData"))

# subsetting --------------------------------------------------------------
clip = rast(nrow = 3, ncol = 3, resolution = 0.3, xmin = 0.9, xmax = 1.8, 
            ymin = -0.45, ymax = 0.45, vals = rep(1, 9))

elev_poly = st_as_sf(as.polygons(elev))
clip_poly = st_as_sf(as.polygons(clip, dissolve = FALSE))

tm1 = tm_shape(elev_poly) +
  tm_polygons(col = "elev", lwd = 0.5) +
  tm_shape(clip_poly) +
  tm_borders(lwd = 2, col = "black") +
  tm_layout(frame = FALSE, legend.show = FALSE,
            inner.margins = c(0, 0, 0, 0.1))

# masking -----------------------------------------------------------------
r_mask = rast(nrow = 6, ncol = 6, resolution = 0.5, 
              xmin = -1.5, xmax = 1.5, ymin = -1.5, ymax = 1.5,
              vals = sample(c(NA, TRUE), 36, replace = TRUE))
masked = elev[r_mask, drop = FALSE]

