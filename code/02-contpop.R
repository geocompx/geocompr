library(spData)
world_proj = st_transform(world, "+proj=eck4")
old_mar = par()$mar
par(mar = c(0, 0, 0, 0))
world_centroids_largest = st_centroid(world_proj, of_largest_polygon = TRUE)
main = "\nCountry continents and populations"
plot(world_proj["continent"], key.pos = NULL, graticule = TRUE,
     main = main, reset = FALSE)
cex = sqrt(world$pop) / 10000
plot(world_centroids_largest, add = TRUE, cex = cex, lwd = 5)
par(mar = old_mar)
