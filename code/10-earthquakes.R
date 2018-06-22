# Aim: create up-to-date map of Earthquakes in previous week

# set-up ------------------------------------------------------------------

library(sf)
library(spData)

# download data -----------------------------------------------------------

u = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_month.geojson"
earthquakes = read_sf(u)
# summary(earthquakes) # summarise

# text results ------------------------------------------------------------

print(paste0(nrow(earthquakes), " significant earthquakes happened last month"))

# map ---------------------------------------------------------------------

plot(st_geometry(world), border = "grey")
plot(st_geometry(earthquakes), cex = earthquakes$mag, add = TRUE)
title(paste0(
  "Location of significant (mag > 5) Earthquakes in the month to ",
  Sys.Date(),
  "\n(circle diameter is proportional to magnitude)"
))
