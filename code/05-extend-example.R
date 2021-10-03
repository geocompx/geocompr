library(terra)
library(sf)
library(tmap)
elev = rast(system.file("raster/elev.tif", package = "spData"))
elev2 = extend(elev, c(1, 2))

elev_poly = st_as_sf(as.polygons(elev, dissolve = FALSE))
elev2_poly = st_as_sf(as.polygons(elev2, na.rm = FALSE, dissolve = FALSE))

tm1 = tm_shape(elev_poly, bbox = elev2_poly) +
  tm_polygons(col = "elev") +
  tm_layout(frame = FALSE, legend.show = FALSE)

tm2 = tm_shape(elev2_poly) +
  tm_polygons(col = "elev") +
  tm_layout(frame = FALSE, legend.show = FALSE)

tmap_arrange(tm1, tm2, nrow = 1)