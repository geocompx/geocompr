library(ggplot2)
library(visualraster)
theme_set(theme_fullframe())
set.seed(2017-11-05)

small_ras_val = raster(matrix(sample.int(12, 16, replace = TRUE), 4, 4, byrow =TRUE), crs = "+proj=longlat")
small_ras_val[c(7, 9)] = NA

small_ras_val2 = projectRaster(small_ras_val, crs = "+proj=utm +zone=30 +ellps=WGS72 +datum=WGS84 +units=m +no_defs ")
small_ras_val3 = projectRaster(small_ras_val, crs = "+proj=utm +zone=30 +ellps=WGS72 +datum=WGS84 +units=m +no_defs ", method = "ngb")

ggplot() +
  vr_geom_raster_seq(small_ras_val) +
  vr_geom_text(small_ras_val) + 
  scale_fill_gradientn(colors = c("white"))

ggplot() +
  vr_geom_raster_seq(small_ras_val2) +
  vr_geom_text(small_ras_val2) + 
  scale_fill_gradientn(colors = c("white"))

ggplot() +
  vr_geom_raster_seq(small_ras_val3) +
  vr_geom_text(small_ras_val3) + 
  scale_fill_gradientn(colors = c("white"))
