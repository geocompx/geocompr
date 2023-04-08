# Filename: 09-tsp.R (2018-06-19)
#
# TO DO: Traveling salesman figure
#
# Author(s): Jannes Muenchow
#
#**********************************************************
# CONTENTS-------------------------------------------------
#**********************************************************
#
# 1. ATTACH PACKAGES AND DATA
# 2. TSP
#
#**********************************************************
# 1 ATTACH PACKAGES AND DATA-------------------------------
#**********************************************************

# attach packages
library(rgrass7)
library(link2GI)
library(sf)
library(mapview)

# attach data
data("cycle_hire", package = "spData")
# just keep the first 25 points
points = cycle_hire[1:25, ]
data("london_streets", package = "spDataLarge")

#**********************************************************
# 2 TSP----------------------------------------------------
#**********************************************************

# initialize spatial GRASS database
link2GI::linkGRASS7(london_streets, ver_select = TRUE)

# add data to the db
writeVECT(SDF = as(london_streets, "Spatial"), vname = "london_streets")
writeVECT(SDF = as(points[, 1], "Spatial"), vname = "points")

# clean topology
execGRASS(cmd = "v.clean", input = "london_streets", output = "streets_clean",
          tool = "break", flags = "overwrite")

# add points to the street network
execGRASS(cmd = "v.net", input = "streets_clean", output = "streets_points_con", 
          points = "points", operation = "connect", threshold = 0.001,
          flags = c("overwrite", "c"))

# run tsp
execGRASS(cmd = "v.net.salesman", input = "streets_points_con",
          output = "shortest_route", center_cats = paste0("1-", nrow(points)),
          flags = c("overwrite"))

# load output into R
route = readVECT("shortest_route") %>%
  st_as_sf %>%
  st_geometry

# make a plot
fig = mapview(route, map.types = "OpenStreetMap.BlackAndWhite", lwd = 7) +
  mapview(points)

# save it as a png
mapshot(fig, file = "figures/09_shortest_route.png",
        remove_controls = c("homeButton", "layersControl"))
