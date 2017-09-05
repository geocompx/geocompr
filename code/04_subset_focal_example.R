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
# 2. EXAMPLE RASTER AND GRAIN SIZE
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

r_3 = raster(nrow = 3, ncol = 3, res = 0.3, xmn = -0.45, xmx = 0.45, 
             ymn = -0.45, ymx = 0.45, vals = rep(1, 9))
p_3 = spplot(r, col.regions = colfunc(36), colorkey = FALSE,
             sp.layout = list(
               list("sp.polygons", rasterToPolygons(r), col = "lightgrey",
                    first = FALSE),
               list("sp.polygons", rasterToPolygons(r_3), col = "black", 
                    lwd = 2, first = FALSE)))
png(filename = "figures/04_raster_subset.png", width = 950 / 2, 
    height = 950 / 2)
plot(p_3)
dev.off()

# add another subsetting example (masking)

#**********************************************************
# 3 FOCAL EXAMPLE------------------------------------------
#**********************************************************

# create data
# raster
r = raster(nrow = 3, ncol = 3, res = 0.5, 
           xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
           vals = 1:36)
# in the book chapter we show subsetting, that's why we have to do so here also
r[1, 1] = 0
# create polygons
# moving window
poly_window = 
  rbind(c(-1.5, 0), c(0,0), c(0, 1.5), c(-1.5, 1.5), c(-1.5, 0)) %>%
  list %>%
  st_polygon %>%
  st_sfc %>%
  st_sf(data.frame(id = 1), geometry = ., crs = 4326) %>%
  as(., "Spatial")
# target polygon
poly_target =
  rbind(c(-1, 0.5), c(-0.5, 0.5), c(-0.5, 1), c(-1, 1), c(-1, 0.5)) %>%
  list %>%
  st_polygon %>%
  st_sfc %>%
  st_sf(data.frame(id = 1), geometry = ., crs = 4326) %>%
  as(., "Spatial")

# focal example
# polygonize raster data
polys = raster::rasterToPolygons(r, na.rm = FALSE)
r_focal = focal(r, w = matrix(1, nrow = 3, ncol = 3), fun = min)
# focal sum
poly_focal = rasterToPolygons(r_focal, na.rm = FALSE)

# Visualizing
p_1 = spplot(polys, colorkey = FALSE, col = gray(0.5),
             col.regions = colorRampPalette(c("lightyellow", "salmon1"))(36),
             sp.layout = list(
               list("sp.polygons", poly_window, col = "black", lwd = 4,
                    first = FALSE),
               list("sp.polygons", poly_target, col = "gold", lwd = 4, 
                    first = FALSE),
               list("sp.text", xyFromCell(r, 1:ncell(r)), values(r)) 
             ))

p_2 = spplot(poly_focal, colorkey = FALSE, col = gray(0.5),
             col.regions = colorRampPalette(c("lightyellow", "salmon1"))(36),
             sp.layout = list(
               list("sp.polygons", poly_target, col = "gold", lwd = 4, 
                    first = FALSE),
               list("sp.text", xyFromCell(r_focal, 1:ncell(r_focal)),
                    values(r_focal)) 
             ))

png(filename = "figures/03_focal_example.png", width = 950, height = 555)
plot(arrangeGrob(p_1, p_2, ncol = 2))
grid.polyline(x = c(0.255, 0.59), y = c(0.685, 0.685), 
              arrow = arrow(length = unit(0.2, "inches")), 
              gp = gpar(lwd = 2))
dev.off()




