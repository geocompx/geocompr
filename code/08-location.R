# Filename: 08-location.R (2017-10-20)
#
# TO DO: Build figures for location chapter
#
# Author(s): Jannes Muenchow
#
#**********************************************************
# CONTENTS-------------------------------------------------
#**********************************************************
#
# 1. ATTACH PACKAGES AND DATA
# 2. FIGURES
#
#**********************************************************
# 1 ATTACH PACKAGES AND DATA-------------------------------
#**********************************************************

# attach packages
library(raster)
library(sp)
library(sf)
library(lattice)
library(latticeExtra)
library(grid)
library(gridExtra)
library(classInt)

# attach data
# change when the data has been put into spDataLarge
load("C:/Users/pi37pat/Desktop/tmp/test.Rdata")
ger = getData(country = "DEU", level = 0)
ger = spTransform(ger, proj4string(input))

#**********************************************************
# 2 FIGURES------------------------------------------------
#**********************************************************

# 2.1 Census stack figure==================================
#**********************************************************
# ratify rasters (factor variables)
for (i in names(input)) {
  input[[i]] = ratify(input[[i]])
  values(input[[i]]) = as.factor(values(input[[i]]))
}

p_1 = spplot(input, col.regions = RColorBrewer::brewer.pal(6, "GnBu"), 
             layout = c(4, 1), 
             # Leave some space between the panels
             between = list(x = 0.5),
             colorkey = list(space = "bottom", width = 0.8, height = 0.2,
                             labels = list(cex = 0.5)),
             strip = strip.custom(bg = 'white',
                                  par.strip.text = list(cex = 0.5),
                                  factor.levels = c("population", "women",
                                                    "mean age", 
                                                    "household size")),
             sp.layout = list(
               list("sp.polygons", ger, col = gray(0.5),
                    first = FALSE)))
# save the output
ggplot2::ggsave(filename = "figures/08_census_stack.png",
                plot = arrangeGrob(p_1, ncol = 1),
                width = 5.1, height = 3)


# 2.2 Metropolitan area figure=============================
#**********************************************************

pal = RColorBrewer::brewer.pal(5, "GnBu")
# cuts = c(0, 249000, 499000, 749000, 999000, 1249000)
cuts = c(0, 250000, 500000, 750000, 1000000, 1250000)
metros = st_cast(polys, "POLYGON")
coords = st_centroid(metros) %>% st_coordinates
# delete the fifth polygon (single cell of the Düsseldorf area)
coords = coords[-5, ]
# move all labels up except for Düsseldorf
ind = metro_names %in% c("Stuttgart", "Düsseldorf", "Berlin")
coords[!ind, 2] = coords[!ind, 2] + 20000
coords[ind, 2] = coords[ind, 2] + c(35000, 35000, 0)

p_2 = spplot(inh_agg, col.regions = pal,
       # par.settings = list(axis.line = list(col = 'transparent')), 
       colorkey = list(space = "right", width = 0.7, height = 0.3,
                       labels = list(cex = 0.5, at = cuts,
                                     labels = cuts / 1000),
                       # draw a box and ticks around the legend
                       axis.line = list(col = "black")),
       # at command necessary again as we have a continous variable!!!
       at = cuts,
       sp.layout = list(
         list("sp.polygons", ger, col = gray(0.5), first = FALSE),
         list("sp.polygons", as(polys, "Spatial"), col = "gold",
              lwd = 3, first = FALSE),
         list("sp.text", coords, txt = metro_names, cex = 0.6, font = 2, first = FALSE)
         )) 

# save the output
ggplot2::ggsave(filename = "figures/08_metro_areas.png",
                plot = arrangeGrob(p_2, ncol = 1),
                width = 3, height = 4)

# 2.3 POI figure===========================================
#**********************************************************
plot(poi)