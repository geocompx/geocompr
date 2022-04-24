library(spData)
library(tmap)
legend_title = expression("Area (km"^2*")")
map_nza = tm_shape(nz) +
  tm_fill(col = "Land_area", title = legend_title) + tm_borders()
aes.color = c(borders = "red")
aes.color.all = tmap_options()$aes.color
aes.color.all[names(aes.color)] = aes.color
c1 = map_nza + tm_layout(aes.color = aes.color.all) 
c2 = map_nza + tm_layout(attr.color = "red")
c3 = map_nza + tm_layout(sepia.intensity = 0.9)
c4 = map_nza + tm_layout(saturation = 0.1)
tmap_arrange(c1, c2, c3, c4, nrow = 1)
