library(tmap)
library(spData)
breaks = c(0, 3, 4, 5) * 1e4
mc1 = tm_shape(nz) + tm_fill(col = "AREA_SQ_KM")
mc2 = tm_shape(nz) + tm_fill(col = "AREA_SQ_KM", breaks = breaks)
mc3 = tm_shape(nz) + tm_fill(col = "AREA_SQ_KM",
                       n = 10, palette = "RdBu")
tmap_arrange(mc1, mc2, mc3)
