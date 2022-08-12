library(tmap)
library(terra)

elev = rast(system.file("raster/elev.tif", package = "spData"))
grain = rast(system.file("raster/grain.tif", package = "spData"))
colfunc2 = c("clay" = "brown", "silt" = "sandybrown", "sand" = "rosybrown") 

p1 = tm_shape(elev) + 
  tm_raster(legend.show = TRUE, style = "cont", title = "") +
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = 0) +
  tm_legend(bg.color = "white")

p2 = tm_shape(grain) + 
  tm_raster(legend.show = TRUE, title = "", palette = colfunc2) +
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = 0) +
  tm_legend(bg.color = "white")

tmap_arrange(p1, p2, nrow = 1)
