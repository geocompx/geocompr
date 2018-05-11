# Filename: 08-location-gm.R (2018-04-09)
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
library(mapview)

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

# find out about lattice settings
# trellis.par.get()
p_1 = spplot(input, col.regions = RColorBrewer::brewer.pal(6, "GnBu"), 
             main = list("Classes", cex = 0.5),
             layout = c(4, 1), 
             # Leave some space between the panels
             between = list(x = 0.5),
             colorkey = list(space = "top", width = 0.8, height = 0.2,
                             # make tick size smaller
                             tck = 0.5,
                             labels = list(cex = 0.4)),
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
ind = metro_names %in% c("Stuttgart", "Duesseldorf", "Berlin")
coords[!ind, 2] = coords[!ind, 2] + 30000
coords[ind, 2] = coords[ind, 2] + c(45000, 45000, 0)

p_2 = 
  spplot(pop_agg, col.regions = pal, 
         main = list("Number of people in 1000", cex = 0.5),
         # if we want to get rid of the plot frame around the map
         # par.settings = list(axis.line = list(col = 'transparent')), 
         colorkey = list(space = "top", width = 0.5, height = 0.4,
                         # make tick length shorter
                         tck = 0.5,
                         labels = list(cex = 0.4, at = cuts,
                                       labels = cuts / 1000),
                         # draw a box and ticks around the legend
                         axis.line = list(col = "black")),
         # legend necessary if we do not use main as legend title
         # legend = list(top = list(fun = grid::textGrob("Size\n(m)", x = 1.05))),
         # at command necessary again as we have a continous variable!!!
         at = cuts,
         # overlay with further spatial objects
         sp.layout = list(
           list("sp.polygons", ger, col = gray(0.5), first = FALSE),
           list("sp.polygons", as(polys, "Spatial"), col = "gold",
                lwd = 2, first = FALSE)
           # list("sp.text", coords, txt = metro_names, cex = 0.7, font = 3,
           #      first = FALSE)
         ))


theta = seq(pi / 4, 2 * pi, length.out = 8)
xy = xy.coords(coords)
xo = 75 * convertWidth(stringWidth("A"), unitTo = "native", valueOnly = TRUE)
yo = 75 * convertWidth(stringHeight("A"), unitTo = "native", valueOnly = TRUE)
p_3 = p_2 + 
  # take care, layer uses NSE, you need to use the data-argument!!!
  # See ?layer and:
  # browseURL(paste0("https://procomun.wordpress.com/2013/04/24/", 
  #                  "stamen-maps-with-spplot/))
  # browseURL(paste0("https://gist.github.com/oscarperpinan/",
  #                  "7482848#file-stamenpolywithlayerinfunction4-r"))
  # shadowtext by Barry Rowlingson
  # browseURL(paste0("http://blog.revolutionanalytics.com/2009/05/", 
  #                  "make-text-stand-out-with-outlines.html"))
  # needs some adjustment for lattice, strwidth and strheight replace by
  # stringWidth and stringHeight (gridExtra), see
  # browseURL("https://stat.ethz.ch/pipermail/r-help/2004-November/061255.html")
  layer(
    for (i in theta) {
      ltext(x = xy$x + cos(i) * xo, y=  xy$y + sin(i) * yo, 
            labels = metro_names, col = "white", font = 3, cex = 0.5)
    },
    data = list(xy = xy, metro_names = metro_names, theta = theta,
                xo = xo, yo = yo)
  ) +
  layer(
    ltext(x = xy$x, y =  xy$y, labels = metro_names, col = "black", cex = 0.5, 
          font = 3),
    data = list(xy = xy, metro_names = metro_names)
  )
  

# save the output
ggplot2::ggsave(filename = "figures/08_metro_areas.png",
                plot = arrangeGrob(p_3, ncol = 1),
                width = 3, height = 4)

# 2.3 POI figure===========================================
#**********************************************************

library(mapview)
library(htmlwidgets)
# dismiss population raster
reclass = dropLayer(reclass, "pop")
# add poi raster
reclass = addLayer(reclass, poi)
# calculate the total score
result = sum(reclass)
# have a look at suitable bike shop locations in Berlin
# polygons 5 and 9 share one border, delete polygon number 5
metros_2$names = metro_names
berlin = dplyr::filter(metros_2, names == "Berlin")
berlin_raster = crop(result, as(berlin, "Spatial"))
berlin_raster = ratify(berlin_raster > 10)
berlin_raster = berlin_raster == TRUE
berlin_raster[berlin_raster == 0] = NA

m = mapview(berlin_raster, col.regions = c(NA, "darkgreen"),
            na.color = "transparent", legend = TRUE, map.type = "OpenStreetMap")
mapshot(m, url = file.path(getwd(), "figures/08_bikeshops_berlin.html"))

# using leaflet (instead of mapview)
berlin_raster = crop(result, as(berlin, "Spatial"))
berlin_raster = berlin_raster > 10
berlin_raster[berlin_raster == TRUE] = 1
berlin_raster[berlin_raster == 0] = NA
leaflet() %>% 
  addTiles() %>%
  addRasterImage(berlin_raster, colors = "darkgreen", opacity = 0.8)
