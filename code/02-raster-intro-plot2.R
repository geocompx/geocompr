# second intro plot -----------------------------------------------------------
library(tmap)
library(rcartocolor)
library(spDataLarge)
library(terra)

# data read ---------------------------------------------------------------
cla_raster = rast(system.file("raster/srtm.tif", package = "spDataLarge"))
cat_raster = rast(system.file("raster/nlcd.tif", package = "spDataLarge"))

# plots create ------------------------------------------------------------
rast_srtm = tm_shape(cla_raster) +
  tm_raster(palette = carto_pal(7, "Geyser"),
            title = "Elevation (m)", style = "cont") + 
  tm_layout(main.title = "A. Continuous data",
            legend.frame = TRUE, 
            legend.position = c("right", "bottom"))

rast_nlcd = tm_shape(cat_raster) +
  tm_raster(drop.levels = TRUE, title = "Land cover") + 
  tm_layout(main.title = "B. Categorical data",
            legend.frame = TRUE, 
            legend.position = c("right", "bottom"))

tmap_arrange(rast_srtm, rast_nlcd, nrow = 1)

