# Aim: plot globe
if (!require(globe)) {
  install.packages("globe")
}
library(sf)
center = st_sf(st_sfc(st_point(c(0, 0))))
buff_equator = st_buffer(x = center, dist = 20)
coords = st_coordinates(buff_equator)[, 1:2]
png(filename = "images/globe-r.png", width = 500, height = 500)
globeearth(eye = c(0, 0))
globelines(loc = coords)
dev.off()
