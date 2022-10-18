library(tmap)
library(terra)
library(sf)
terrain_colors = rcartocolor::carto_pal(7, "Geyser")
srtm = rast(system.file("raster/srtm.tif", package = "spDataLarge"))
zion = read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))
zion = st_transform(zion, crs(srtm))
data("zion_points", package = "spDataLarge")

tm1 = tm_shape(srtm) +
  tm_raster(palette = terrain_colors, title = "Elevation (m)", 
            legend.show = TRUE, style = "cont") + 
  tm_shape(zion) +
  tm_borders(lwd = 2) + 
  tm_shape(zion_points) + 
  tm_dots(col = "black", size = 0.1) + 
  tm_add_legend(type = "symbol", col = "black", size = 0.2,
                labels = "zion_points") + 
  tm_layout(legend.frame = TRUE, legend.position = c("right", "top"))

tm1