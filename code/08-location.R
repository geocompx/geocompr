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
library(lattice)
library(latticeExtra)
library(grid)
library(gridExtra)
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
