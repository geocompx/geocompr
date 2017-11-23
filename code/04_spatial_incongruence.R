# Filename: 04_spatial_incongruence.R (2017-11-03)
#
# TO DO: Difference between admin and postal code layers
#
# Author(s): Jannes Muenchow
#
#**********************************************************
# CONTENTS-------------------------------------------------
#**********************************************************
#
# 1. ATTACH PACKAGES AND DATA
# 2. 
#
#**********************************************************
# 1 ATTACH PACKAGES AND DATA-------------------------------
#**********************************************************

# attach packages
library(raster)
library(sp)
library(sf)
library(tidyverse)

# download data
download.file(paste0("http://www.suche-postleitzahl.org/downloads?", 
                     "download_file=plz-gebiete.shp.zip"),
              destfile = file.path(tempdir(), "pc_germ.zip"))
unzip(zipfile = file.path(tempdir(), "pc_germ.zip"), exdir = tempdir())
# load PC shapefile
shp_pc = read_sf(file.path(tempdir(), "plz-gebiete.shp"))

ger_mun = getData(country = "DEU", level = 3)
ger_dis = getData(country = "DEU", level = 2)
ger_mun = st_as_sf(ger_mun)
ger_dis = st_as_sf(ger_dis)
save.image("congruence.Rdata")


weimar = filter(ger_dis, NAME_2 %in% "Weimar")
weimar_2 = ger_dis[weimar, ]
plot(st_geometry(ger_dis[weimar, ]))
ind = unlist(st_contains(ger_dis[weimar, ], ger_mun))
plot(st_geometry(ger_dis[weimar, ]), border = "steelblue2", add = TRUE, lwd = 5)
plot(st_geometry(ger_mun[ind, ]), border = "red3", add = TRUE)
# one polygon is missing, don't know why...
plot(st_geometry(ger_mun[weimar_2, ][17, ]), add = TRUE, border = "green")
ger_mun[weimar_2, ][17, ]  # 4674
ind = c(ind, 4674)
plot(st_geometry(ger_dis[weimar, ]), border = "steelblue2", lwd = 5)
plot(st_geometry(ger_mun[ind, ]), border = "red3", add = TRUE)

# show postal code problem
plot(st_geometry(shp_pc[weimar, ]), lwd = 3, border = "red3")  # pcs around Weimar
plot(st_geometry(weimar), add = TRUE, border = "steelblue2", lwd = 2)  # weimar district/municipality
# the same as, i.e., Weimar municipality is also a district
# plot(st_geometry(filter(ger_mun, NAME_3 %in% "Weimar")), add = TRUE, border = "blue")
png(filename = "figures/04_incongruence_example.png", width = 950, height = 555)
# show postal code problem
plot(st_geometry(shp_pc[weimar, ]), lwd = 3, border = "red3")  # pcs around Weimar
plot(st_geometry(weimar), add = TRUE, border = "steelblue2", lwd = 2)  # weimar district/municipality
dev.off()
