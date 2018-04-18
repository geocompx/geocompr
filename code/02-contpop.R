library(sf)
library(spData)
world_proj = st_transform(world, "+proj=eck4")
old_mar = par()$mar
par(mar = c(0, 0, 0, 0))
world_centroids_largest = st_centroid(world_proj, of_largest_polygon = TRUE)
main = "\nCountry continents and populations worldwide"
plot(st_geometry(world_proj), graticule = TRUE, reset = FALSE)
plot(world_proj["continent"], add = TRUE)
cex = sqrt(world$pop) / 10000
plot(st_geometry(world_centroids_largest), add = TRUE, cex = cex, lwd = 2)
par(mar = old_mar)
