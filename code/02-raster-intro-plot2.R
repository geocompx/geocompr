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
  tm_raster(col.scale = tm_scale_continuous(values = carto_pal(7, "Geyser")),
            col.legend = tm_legend("Elevation (m)")) + 
  tm_title("A. Continuous data") +
  tm_layout(legend.frame = TRUE, 
            legend.bg.color = "white",
            legend.position = c("RIGHT", "BOTTOM"))

rast_nlcd = tm_shape(cat_raster) +
  tm_raster(col.scale = tm_scale_categorical(levels.drop = TRUE),
            col.legend = tm_legend("Land cover")) + 
  tm_title("B. Categorical data") +
  tm_layout(legend.frame = TRUE, 
            legend.bg.color = "white",
            legend.position = c("RIGHT", "BOTTOM"))

tmap_arrange(rast_srtm, rast_nlcd, nrow = 1)
