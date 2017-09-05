# Filename: 03_raster_creation_subset.R (2017-09-05)
#
# TO DO: Create contnuous and categorical raster and spatial raster subsetting
#
# Author(s): Jannes MUENCHOW
#
#**********************************************************
# CONTENTS-------------------------------------------------
#**********************************************************
#
# 1. ATTACH PACKAGES AND DATA
# 2. EXAMPLE RASTER AND GRAIN SIZE
# 3. SPATIAL SUBSETTING
#
#**********************************************************
# 1 ATTACH PACKAGES AND DATA-------------------------------
#**********************************************************

# attach packages
library(grid)
library(gridExtra)
library(sp)
library(latticeExtra)
library(lattice)
library(sf)
library(raster)

#**********************************************************
# 2 EXAMPLE RASTER AND GRAIN SIZE--------------------------
#**********************************************************

# create rasters
r = raster(nrow = 6, ncol = 6, res = 0.5, 
           xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
           vals = 1:36)
grain_size = c("clay", "silt", "sand")
r_2 = raster(nrow = 6, ncol = 6, res = 0.5, 
             xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
             vals = factor(sample(grain_size, 36, replace = TRUE), 
                           levels = grain_size))

colfunc <- colorRampPalette(c("lightyellow", "rosybrown"))
# colfunc(10)
# p_1 = spplot(r, col.regions = terrain.colors(36))
p_1 = spplot(r, col.regions = colfunc(36))
p_2 = spplot(r_2, col.regions = c("brown","sandybrown", "rosybrown"))

png(filename = "figures/03_cont_categ_rasters.png", width = 950, height = 555)
plot(arrangeGrob(p_1, p_2, ncol = 2))
dev.off()

#**********************************************************
# 3 SPATIAL SUBSETTING-------------------------------------
#**********************************************************

r_3 = raster(nrow = 3, ncol = 3, res = 0.3, xmn = -0.45, xmx = 0.45, 
             ymn = -0.45, ymx = 0.45, vals = rep(1, 9))
p_3 = spplot(r, col.regions = colfunc(36), colorkey = FALSE,
             sp.layout = list(
               list("sp.polygons", rasterToPolygons(r), col = "lightgrey",
                    first = FALSE),
               list("sp.polygons", rasterToPolygons(r_3), col = "black", 
                    lwd = 2, first = FALSE)))
png(filename = "figures/03_raster_subset.png", width = 950 / 2, 
    height = 950 / 2)
plot(p_3)
dev.off()
