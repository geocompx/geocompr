library(tmap)
library(terra)
library(sf)
terrain_colors = rcartocolor::carto_pal(7, "Geyser")
srtm = rast(system.file("raster/srtm.tif", package = "spDataLarge"))
zion = read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))
zion = st_transform(zion, crs(srtm))
data("zion_points", package = "spDataLarge")

tm1 = tm_shape(srtm) +
  tm_raster(col.scale = tm_scale_continuous(values = terrain_colors),
            col.legend = tm_legend("Elevation (m asl)")) + 
  tm_shape(zion) +
  tm_borders(lwd = 2) + 
  tm_shape(zion_points) + 
  tm_symbols(fill = "black", size = 0.5) + 
  tm_add_legend(type = "symbols", fill = "black", size = 0.7,
                labels = "zion_points", shape = 21) + 
  tm_layout(legend.frame = TRUE, legend.position = c("right", "top"),
            legend.bg.color = "white")  
tm1
