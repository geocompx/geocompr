library(tmap)
library(spData)
mc1 = tm_shape(nz) + tm_polygons(fill = "Median_income")
mc2 = tm_shape(nz) + tm_polygons(fill = "Median_income",
                           fill.scale = tm_scale(breaks = c(0, 30000, 40000, 50000)))
mc3 = tm_shape(nz) + tm_polygons(fill = "Median_income",
                           fill.scale = tm_scale(n = 10))
mc4 = tm_shape(nz) + tm_polygons(fill = "Median_income",
                           fill.scale = tm_scale(values = "BuGn"))
tmap_arrange(mc1, mc2, mc3, mc4, nrow = 1)
