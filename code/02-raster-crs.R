library(terra)
library(rcartocolor)
library(tmap)
raster_filepath = system.file("raster/srtm.tif", package = "spDataLarge")
new_raster = rast(raster_filepath)
new_raster2 = project(new_raster, "EPSG:26912")

tm1 = tm_shape(new_raster) +
  tm_graticules(n.x = 3, n.y = 4) +
  tm_raster(palette = carto_pal(7, "Geyser"), 
            style = "cont", legend.show = FALSE) +
  tm_layout(inner.margins = 0) +
  tm_ylab("Latitude", space = 0.5) +
  tm_xlab("Longitude")

tm2 = tm_shape(new_raster2) +
  tm_grid(n.x = 3, n.y = 4) +
  tm_raster(palette = carto_pal(7, "Geyser"), 
            style = "cont", legend.show = FALSE) +
  tm_layout(inner.margins = 0) +
  tm_ylab("y") +
  tm_xlab("x")

tm = tmap_arrange(tm1, tm2)
tmap_save(tm, "figures/02_raster_crs.png", 
          width = 950*1.5, height = 532*1.5, dpi = 150, 
          scale = 1.5)
