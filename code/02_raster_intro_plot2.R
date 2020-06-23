# second intro plot -----------------------------------------------------------
library(tmap)
library(rcartocolor)
library(spDataLarge)
library(raster)

# data read ---------------------------------------------------------------
cla_raster = raster(system.file("raster/srtm.tif", package = "spDataLarge"))
cat_raster = nlcd

# colors create -----------------------------------------------------------
terrain_colors = carto_pal(7, "TealRose")
landcover_cols = c("#476ba0", "#aa0000", "#b2ada3", "#68aa63", "#a58c30", "#c9c977", "#dbd83d", "#bad8ea")

# plots create ------------------------------------------------------------
rast_srtm = tm_shape(cla_raster) + tm_raster(palette = terrain_colors, title = "Elevation (m)", style = "cont") + 
  tm_layout(main.title = "A. Continuous data", legend.frame = TRUE, legend.position = c("right", "bottom"))

rast_nlcd = tm_shape(cat_raster) + tm_raster(palette = landcover_cols, style = "cat", title = "Land cover") + 
  tm_layout(main.title = "B. Categorical data", legend.frame = TRUE, legend.position = c("right", "bottom"))
# names(cat_raster)
# names(cla_raster)

tmap_arrange(rast_srtm, rast_nlcd, ncol = 2)

