# Aim: demonstrate how to load and plot gpx data

library(sf)
download.file("https://www.openstreetmap.org/trace/1619756/data", "Sheff2leeds.gpx")
st_layers("Sheff2leeds.gpx")
route = st_read("Sheff2leeds.gpx", layer = "tracks")
file.remove("Sheff2leeds.gpx")
plot(route)

# also try:
library(tmap)
qtm(route)
ttm()
qtm(route)
mapview::mapview(route)
