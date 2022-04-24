library(tmap)
library(spData)
library(terra)
grain = rast(system.file("raster/grain.tif", package = "spData"))
grain_poly = as.polygons(grain, dissolve = FALSE) %>% 
  st_as_sf()
grain_poly2 = as.polygons(grain) %>% 
  st_as_sf()

cols = c("clay" = "brown", "sand" = "rosybrown", "silt" = "sandybrown")

p1p = tm_shape(grain) +
  tm_raster(legend.show = FALSE, palette = cols) +
  tm_layout(main.title = "A. Raster", frame = FALSE,
            main.title.size = 1)

p2p = tm_shape(grain_poly) +
  tm_polygons("grain", legend.show = FALSE, palette = cols, lwd = 3) +
  tm_layout(main.title = "B.Polygons", frame = FALSE,
            main.title.size = 1)

p3p = tm_shape(grain_poly2) + 
  tm_polygons("grain", legend.show = FALSE, palette = cols, lwd = 3) +
  tm_layout(main.title = "C. Aggregated polygons", frame = FALSE,
            main.title.size = 1)

tmap_arrange(p1p, p2p, p3p, ncol = 3)

