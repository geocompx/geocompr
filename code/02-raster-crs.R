library(gridExtra)
library(raster)
library(rasterVis)
library(rcartocolor)

# raster-plot -------------------------------------------------------------
raster_filepath = system.file("raster/srtm.tif", package = "spDataLarge")
new_raster = raster(raster_filepath) #%>% mask(., new_vector)
new_raster2 = projectRaster(new_raster, crs = "+proj=utm +zone=12 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")

pr1 = levelplot(new_raster, margin = FALSE, colorkey = FALSE,
                par.settings = rasterTheme(region = carto_pal(7, "TealRose")))
pr2 = levelplot(new_raster2, margin = FALSE, colorkey = FALSE,
                par.settings = rasterTheme(region = carto_pal(7, "TealRose")),
                xlab = "x", ylab = "y")

png(filename = "figures/02_raster_crs.png", width = 950, height = 532, res = 150)
plot(pr1, split=c(1, 1, 2, 1), more=TRUE)
plot(pr2, split=c(2, 1, 2, 1))
dev.off()
