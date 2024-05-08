library(tmap)
library(sf)
library(terra)
set.seed(2023-03-10)
elev = rast(system.file("raster/elev.tif", package = "spData"))

# subsetting --------------------------------------------------------------
clip = rast(nrow = 3, ncol = 3, resolution = 0.3, xmin = 0.9, xmax = 1.8, 
            ymin = -0.45, ymax = 0.45, vals = rep(1, 9))

elev_poly = st_as_sf(as.polygons(elev))
clip_poly = st_as_sf(as.polygons(clip, dissolve = FALSE))

# masking -----------------------------------------------------------------
r_mask = rast(nrow = 6, ncol = 6, resolution = 0.5, 
              xmin = -1.5, xmax = 1.5, ymin = -1.5, ymax = 1.5,
              vals = sample(c(FALSE, TRUE), 36, replace = TRUE))
masked = elev[r_mask, drop = FALSE]

r_mask2 = r_mask
r_mask2[!r_mask] = NA
r_mask_poly = st_as_sf(as.polygons(r_mask2, dissolve = FALSE))
masked_poly = st_as_sf(as.polygons(masked))

tm1 = tm_shape(elev_poly) +
  tm_polygons(fill = "elev", lwd = 0.5) +
  tm_layout(frame = FALSE, legend.show = FALSE,
            inner.margins = c(0, 0, 0, 0.1))

tm2 = tm_shape(r_mask_poly) +
  tm_polygons(lwd = 0.5) +
  tm_layout(frame = FALSE, legend.show = FALSE,
            inner.margins = c(0, 0, 0, 0.1))

tm3 = tm_shape(masked_poly) +
  tm_polygons(fill = "elev", lwd = 0.5) +
  tm_layout(frame = FALSE, legend.show = FALSE,
            inner.margins = c(0, 0, 0, 0.1))

tma = tmap_arrange(tm1, tm2, tm3, nrow = 1)

tmap_save(tma, "images/04_raster_subset.png", 
          width = 7.5, height = 3, dpi = 300)

