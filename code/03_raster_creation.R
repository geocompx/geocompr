# Filename: 03_raster_creation_subset.R (2017-09-05)
#
# TO DO: Create continuous and categorical raster and spatial raster subsetting
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
set.seed(2017-12-16)

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
p_2 = spplot(r_2, 
             col.regions =  c("brown","sandybrown", "rosybrown"),
             colorkey = list(space = "right", axis.text = list(cex = 0.5),
                             height = 0.3))

ggplot2::ggsave(filename = "figures/03_cont_categ_rasters.png",
                plot = arrangeGrob(p_1, p_2, ncol = 2),
                width = 5.1, height = 3)
# png(filename = "figures/03_cont_categ_rasters.png", width = 950, height = 555)
# plot(arrangeGrob(p_1, p_2, ncol = 2))
# dev.off()

