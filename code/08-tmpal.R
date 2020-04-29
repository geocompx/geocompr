library(tmap)
library(spData)
breaks = c(0, 3, 4, 5) * 10000
mc1 = tm_shape(nz) + tm_polygons(col = "Median_income")
mc2 = tm_shape(nz) + tm_polygons(col = "Median_income", breaks = breaks)
mc3 = tm_shape(nz) + tm_polygons(col = "Median_income", n = 10)
mc4 = tm_shape(nz) + tm_polygons(col = "Median_income", palette = "BuGn")
tmap_arrange(mc1, mc2, mc3, mc4, nrow = 1)
