library(qgisprocess)
library(terra)
library(tmap)

dem = rast(system.file("raster/dem.tif", package = "spDataLarge"))

dem_slope = terrain(dem, unit = "radians")
dem_aspect = terrain(dem, v = "aspect", unit = "radians")
dem_TPI = terrain(dem, v = "TPI")

qgis_algo = qgis_algorithms()
grep("topidx", qgis_algo$algorithm, value = TRUE)

qgis_show_help("grass:r.topidx")

dem_twi = qgis_run_algorithm("grass:r.topidx", input = dem)
# r.topidx writes a Float32 GeoTIFF with a categorical attribute table attached
# (visible as the "SetColorTable() only supported for Byte or UInt16" warning).
# Stripping it with terra::app() so plotting/tmap see numeric values.
dem_twi = terra::app(qgis_as_terra(dem_twi$output), as.numeric)
names(dem_twi) = "twi"
# plot(dem_twi)

grep("geomorphon", qgis_algo$algorithm, value = TRUE)
qgis_show_help("grass:r.geomorphon")

dem_geomorph = qgis_run_algorithm("grass:r.geomorphon",
                                  elevation = dem,
                                  `-m` = TRUE,
                                  search = 120)

dem_geomorph_terra = qgis_as_terra(dem_geomorph$forms)
# plot(dem_geomorph_terra)

dem_hillshade = shade(dem_slope, dem_aspect, 10, 200)

tm1 = tm_shape(dem_hillshade) +
  tm_raster(col.scale = tm_scale_continuous(values = rev(hcl.colors(99, "Grays"))),
            col.legend = tm_legend_hide()) +
  tm_shape(dem_twi) +
  tm_raster(col_alpha = 0.5,
            col.scale = tm_scale_continuous(values = "Blues"),
            col.legend = tm_legend(title = "")) +
  tm_title("TWI", position = tm_pos_out()) +
  tm_layout(inner.margins = c(0, 0.22, 0, 0),
            legend.position = c("LEFT", "top"),
            frame = FALSE)

tm2 = tm_shape(dem_hillshade) +
  tm_raster(col.scale = tm_scale_continuous(values = rev(hcl.colors(99, "Grays"))),
            col.legend = tm_legend_hide()) +
  tm_shape(dem_geomorph_terra) +
  tm_raster(col_alpha = 0.5,
            col.legend = tm_legend(title = ""),
            col.scale = tm_scale_categorical(levels.drop = TRUE)) +
  tm_title("Geomorphons", position = tm_pos_out(pos.h = "right")) +
  tm_layout(inner.margins = c(0, 0, 0, 0.22),
            legend.position = c("RIGHT", "top"),
            frame = FALSE)

qgis_raster_map = tmap_arrange(tm1, tm2, nrow = 1)

tmap_save(qgis_raster_map, "images/10-qgis-raster-map.png",
          width = 20, height = 9, units = "cm")
