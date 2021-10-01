library(tmap)
library(terra)
multi_raster_file = system.file("raster/landsat.tif", package = "spDataLarge")
multi_rast = rast(multi_raster_file)
ndvi_fun = function(nir, red){
  (nir - red) / (nir + red)
}
ndvi_rast = lapp(multi_rast[[c(4, 3)]], fun = ndvi_fun)

multi_rast2 = stretch(multi_rast, maxq = 0.98)
tm1 = tm_shape(multi_rast2[[3:1]]) +
  tm_rgb() +
  tm_layout(frame = FALSE, main.title = "RGB image")
tm2 = tm_shape(ndvi_rast) +
  tm_raster(style = "cont", title = "") +
  tm_layout(frame = FALSE, main.title = "NDVI",
            legend.frame = TRUE, legend.position = c("left", "bottom"))
tma = tmap_arrange(tm1, tm2, nrow = 1)
tmap_save(tma, "figures/04-ndvi.png", height = 800, width = 1100)
