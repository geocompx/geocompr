devtools::install_github("robinlovelace/ukboundaries")
library(ukboundaries)
library(stplanr)
library(sf)
dl_stats19()
a = read_stats19_ac()
names(a)
a_no_na = a[!is.na(a$Latitude), ]
a_sf = st_as_sf(a_no_na, coords = c("Longitude", "Latitude"), crs = 4326)
leeds = lad2018[lad2018$lau118nm == "Leeds",]
a_leeds = a_sf[leeds, ]
plot(st_geometry(a_leeds))
