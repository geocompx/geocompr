# Filename: 04-focal_eample.R (2017-08-29)
#
# TO DO: Illustrate how a focal function works
#
# Author(s): Jannes MUENCHOW
#
#**********************************************************
# CONTENTS-------------------------------------------------
#**********************************************************
#
# 1. ATTACH PACKAGES AND DATA
# 2. SPATIAL SUBSETTING
# 3. FOCAL EXAMPLE
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
# 2 SPATIAL SUBSETTING-------------------------------------
#**********************************************************

# Subsetting example I=====================================
#**********************************************************
# create data
# raster
r = raster(nrow = 3, ncol = 3, res = 0.5, 
           xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
           vals = 1:36)

clip = raster(nrow = 3, ncol = 3, res = 0.3, xmn = 0.9, xmx = 1.8, 
             ymn = -0.45, ymx = 0.45, vals = rep(1, 9))
# create color scale
colfunc = colorRampPalette(c("lightyellow", "rosybrown"))

p_1 = spplot(r, xlim = c(-1.5, 2), ylim = c(-1.5, 1.5),
             col.regions = colfunc(36), colorkey = FALSE,
             par.settings = list(axis.line = list(col =  'transparent')),
             sp.layout = list(
               list("sp.polygons", rasterToPolygons(r), col = "lightgrey",
                    first = FALSE),
               list("sp.polygons", rasterToPolygons(clip), col = "black", 
                    lwd = 2, first = FALSE)))

# add another subsetting example (masking)
r_mask = raster(nrow = 6, ncol = 6, res = 0.5, 
                xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
                vals = sample(c(NA, TRUE), 36, replace = TRUE))
masked = r[r_mask, drop = FALSE]
p_2 = spplot(r_mask, col.regions = colfunc(2), colorkey = FALSE, 
             xlim = c(-1.5, 2),
             par.settings = list(axis.line = list(col =  'transparent')),
             sp.layout = list(
               list("sp.polygons", rasterToPolygons(r_mask), col = "black",
                    first = FALSE),
               list("sp.polygons", rasterToPolygons(aggregate(r_mask, fact = 6)),
                    border = "black", first = FALSE))
             )

p_3 = spplot(masked, col.regions = colfunc(36), colorkey = FALSE,
             xlim = c(-1.5, 2),
             par.settings = list(axis.line = list(col =  'transparent')),
             sp.layout = list(
               list("sp.polygons", rasterToPolygons(masked), col = "black",
                    first = FALSE),
               list("sp.polygons", 
                    rasterToPolygons(aggregate(r_mask, fact = 6)),
                    border = "black", first = FALSE))
             )

ggplot2::ggsave(filename = "figures/04_raster_subset.png",
                plot = arrangeGrob(p_1, p_2, p_3, ncol = 3),
                width = 7.5, height = 3)

# Subsetting example II====================================
#**********************************************************
elev = raster(nrow = 6, ncol = 6, res = 0.5, 
              xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
              vals = 1:36)
elev_2 = raster(nrow = 6, ncol = 6, res = 0.5, 
                xmn = -1.5 + 1, xmx = 1.5 + 1, ymn = -1.5 + 1, ymx = 1.5 + 1,
                vals = 1:36)
# retrieves the intersection
clip = elev[elev_2, drop = FALSE]

p_1 = spplot(elev, xlim = c(-2, 3), ylim = c(-2, 3), colorkey = FALSE, 
             col.regions = NA,
             par.settings =
               list(axis.line = list(col =  'transparent')),
             sp.layout = list(
               list("sp.polygons", rasterToPolygons(elev), col = gray(0.7),
                    first = FALSE),
               list("sp.polygons", rasterToPolygons(aggregate(elev, fact = 6)),
                    border = "black", first = FALSE)))
p_2 = spplot(elev_2, col.regions = NA, colorkey = FALSE,
             sp.layout = list(
               list("sp.polygons", rasterToPolygons(elev_2), col = gray(0.7),
                    first = FALSE),
               list("sp.polygons", rasterToPolygons(aggregate(elev_2, fact = 6)),
                    border = "black", first = FALSE)))
p_3 = spplot(clip, col.regions = "lightgray", colorkey = FALSE,
             sp.layout = list(
               list("sp.polygons", rasterToPolygons(clip), col = "black",
                    first = FALSE),
               list("sp.polygons", rasterToPolygons(aggregate(clip, fact = 4)),
                    border = "black", lwd = 2, first = FALSE)
             ))

# png(filename = "figures/04_mosaic_intersect.png", width = 450, 
#     height = 450)
# plot(arrangeGrob(p_1 + as.layer(p_2, under = TRUE) + as.layer(p_3)))
# dev.off()


# doing the same with base plotting
plot(merge(elev, elev_2), col = NA, legend = FALSE, xlim = c(-2, 2),
     ylim = c(-3, 3))
plot(rasterToPolygons(elev), add = TRUE, border = gray(0.7))
plot(extent(elev), add = TRUE)
plot(rasterToPolygons(elev_2), add = TRUE, border = gray(0.7))
plot(extent(elev_2), add = TRUE)
plot(rasterToPolygons(clip), add = TRUE, col = "lightgray")
plot(extent(clip), lwd = 2, add = TRUE)
