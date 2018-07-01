library(globe)
library(dplyr)
library(sf)

london_lonlat = st_point(c(-0.1, 51.5)) %>%
  st_sfc() %>%
  st_sf(crs = 4326, geometry = .)
london_osgb = st_transform(london_lonlat, 27700)
origin_osgb = st_point(c(0, 0)) %>% 
  st_sfc() %>% 
  st_sf(crs = 27700, geometry = .)
london_orign = rbind(london_osgb, origin_osgb)

png("figures/vector_lonlat.png")
globe::globeearth(eye = c(0, 0))
gratmat = st_coordinates(st_graticule())[, 1:2]
globe::globelines(loc = gratmat, col = "grey", lty = 3)
globe::globelines(loc = matrix(c(-90, 90, 0, 0), ncol = 2))
globe::globelines(loc = matrix(c(0, 0, -90, 90), ncol = 2))
globe::globepoints(loc = c(-0.1, 51.5), pch = 4, cex = 2, lwd = 3, col = "red")
globe::globepoints(loc = c(0, 0), pch = 1, cex = 2, lwd = 3, col = "blue")
dev.off()
png("figures/vector_projected.png")
uk = rnaturalearth::ne_countries(scale = 50) %>% 
  st_as_sf() %>% 
  filter(grepl(pattern = "United Kingdom|Ire", x = name_long)) %>% 
  st_transform(27700)
plot(uk$geometry)
plot(london_orign$geometry[1], add = TRUE, pch = 4, cex = 2, lwd = 3, col = "red")
plot(london_orign$geometry[2], add = TRUE, pch = 1, cex = 2, lwd = 3, col = "blue")
abline(h = seq(0, 9e5, length.out = 10), col = "grey", lty = 3)
abline(v = seq(0, 9e5, length.out = 10), col = "grey", lty = 3)
dev.off()
