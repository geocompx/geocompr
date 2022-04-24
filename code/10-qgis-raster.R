library(qgisprocess)
library(terra)
library(tmap)

dem = rast(system.file("raster/dem.tif", package = "spDataLarge"))

dem_slope = terrain(dem, unit = "radians")
dem_aspect = terrain(dem, v = "aspect", unit = "radians")
dem_TPI = terrain(dem, v = "TPI")

qgis_algo = qgis_algorithms()
grep("wetness", qgis_algo$algorithm, value = TRUE)

qgis_show_help("saga:sagawetnessindex")

dem_wetness = qgis_run_algorithm("saga:sagawetnessindex", 
                                  DEM = dem)

dem_wetness_1 = qgis_as_terra(dem_wetness$AREA)
dem_wetness_2 = qgis_as_terra(dem_wetness$AREA_MOD)
dem_wetness_3 = qgis_as_terra(dem_wetness$SLOPE)
dem_wetness_4 = qgis_as_terra(dem_wetness$TWI)

# plot(dem_wetness_1)
# plot(dem_wetness_2)
# plot(dem_wetness_3)
# plot(dem_wetness_4)


grep("geomorphon", qgis_algo$algorithm, value = TRUE)
qgis_show_help("grass7:r.geomorphon")

dem_geomorph = qgis_run_algorithm("grass7:r.geomorphon", 
                                 elevation = dem, 
                                 `-m` = TRUE,
                                 search = 120)

dem_geomorph_terra = qgis_as_terra(dem_geomorph$forms)
# plot(dem_geomorphon)
# set.values(dem_geomorphon)
# set.cats(dem_geomorphon, value = cats(dem_geomorphon)[[1]][-11, ])

dem_hillshade = shade(dem_slope, dem_aspect, 10, 200)

tm1 = tm_shape(dem_hillshade) +
  tm_raster(style = "cont", palette = rev(hcl.colors(99, "Grays")),
            legend.show = FALSE) +
  tm_shape(dem_wetness_4) +
  tm_raster(alpha = 0.5,
            style = "cont",
            title = "",
            palette = "Blues") +
  tm_layout(inner.margins = c(0, 0.22, 0, 0),
            legend.position = c("LEFT", "top"),
            frame = FALSE,
            main.title = "TWI",
            main.title.position = "left") 

tm2 = tm_shape(dem_hillshade) +
  tm_raster(style = "cont", palette = rev(hcl.colors(99, "Grays")),
            legend.show = FALSE) +
  tm_shape(dem_geomorph_terra) +
  tm_raster(alpha = 0.5,
            title = "",
            drop.levels = TRUE,
            labels = levels(dem_geomorph_terra)[[1]]) + # ERROR??
  tm_layout(inner.margins = c(0, 0, 0, 0.22),
            legend.position = c("RIGHT", "top"),
            frame = FALSE,
            main.title = "Geomorphons",
            main.title.position = "right") 

qgis_raster_map = tmap_arrange(tm1, tm2, nrow = 1)
tmap_save(qgis_raster_map, "figures/10-qgis-raster-map.png",
          width = 20, height = 9, units = "cm")
