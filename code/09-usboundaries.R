# Aim: create animation showing shifting US boundaries
# depends on 17 MB USAboundariesData package
# link to script file that shows changing state boundaries
# install.packages("USAboundaries", repos = "https://ropensci.r-universe.dev")
# install.packages("USAboundariesData", repos = "https://ropensci.r-universe.dev", type = "source")
library(USAboundaries)
library(tidyverse)
library(tmap)
library(sf)
dates = paste(historydata::us_state_populations$year, "01", "01", sep = "-")
dates_unique = unique(dates)
# select all dates earlier than 2000 after this error:
#   Error in us_states(map_date, resolution, states) : 
#   map_date <= as.Date("2000-12-31") is not TRUE
dates_unique = dates_unique[dates_unique <= "2000-12-31"]
usb1 = USAboundaries::us_states(map_date = dates_unique[1])
usb1$year = lubridate::year(dates_unique[1])
plot(usb1$geometry)
usbl = map(dates_unique, ~USAboundaries::us_states(map_date = .))
# usb = do.call(rbind, usbl)
statepop = historydata::us_state_populations |>
  select(-GISJOIN) |> rename(name = state) 
sel = usb1$name %in% statepop$name
summary(sel)
usb1$name[!sel]
usbj = left_join(usb1, statepop)
plot(usbj["population"])
i = 2

dates_unique[dates_unique > "2000-12-31"] = "2000-12-31"

for(i in 2:length(dates_unique)) {
  usbi = USAboundaries::us_states(map_date = dates_unique[i])
  #print(st_crs(usbi))
  usbi$year = lubridate::year(dates_unique[i])
  if (dates_unique[i] == "2000-12-31") usbi$year = 2010
  # plot(usbi$geometry)
  usbji = left_join(usbi, statepop)
  # plot(usbji["population"])
  usbj = bind_rows(usbj, usbji)
}

summary(usbj)
usa_contig = usbji[!grepl(pattern = "Alaska|Haw", usbji$name), ]

usbj_contig2163 = st_intersection(usbj, usa_contig[0]) |>
  st_transform("EPSG:2163") |> 
  st_collection_extract("POLYGON")

pal = viridis::viridis(n = 7, direction = -1)
pb = c(0, 1, 2, 5, 10, 20, 30, 40) * 1e6
facet_anim = tm_shape(usbj_contig2163) +
  tm_polygons(fill = "population",
              fill.scale = tm_scale(values = pal, breaks = pb, label.na = FALSE)) +
  tm_facets(by = "year", nrow = 1, ncol = 1, free.coords = FALSE) +
  tm_shape(usa_union) + tm_borders(lwd = 2) +
  tm_layout(legend.position = c("left", "bottom"), legend.frame = FALSE)
tmap_animation(tm = facet_anim, filename = "09-us_pop.gif", width = 900, height = 600)
browseURL("09-us_pop.gif")
