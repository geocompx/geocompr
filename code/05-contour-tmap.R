library(tmap)
library(sf)
library(terra)
dem = rast(system.file("raster/dem.tif", package = "spDataLarge"))
# create hillshade
hs = shade(slope = terrain(dem, "slope", unit = "radians"), 
           aspect = terrain(dem, "aspect", unit = "radians"))
# create contour
cn = st_as_sf(as.contour(dem))

tm1 = tm_shape(hs) +
	tm_grid(col = "black", n.x = 2, n.y = 2, labels.rot = c(0, 90)) +
	tm_raster(palette = gray(0:100 / 100), n = 100, legend.show = FALSE) +
	tm_shape(dem) +
	tm_raster(alpha = 0.6, palette = hcl.colors(25, "Geyser"), legend.show = FALSE) +
	tm_shape(cn) +
	tm_iso("level", col = "white") +
	tm_layout(outer.margins = c(0.04, 0.04, 0.02, 0.02), frame = FALSE)

tmap_save(tm1, "figures/05-contour-tmap.png", height = 1000, width = 1000)
