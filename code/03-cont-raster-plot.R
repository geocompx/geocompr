library(tmap)
library(grid)
library(spData)
library(sp)

data("elev")
data("grain")

colfunc = colorRampPalette(c("lightyellow", "rosybrown"))
colfunc2 = c("clay" = "brown", "silt" = "sandybrown", "sand" = "rosybrown")

p1 = tm_shape(elev) + 
  tm_raster(legend.show = TRUE, palette = colfunc(36), style = "cont", title = "") +
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = rep(0, 4)) +
  tm_legend(bg.color = "white")

p2 = tm_shape(as(grain, "SpatialGridDataFrame")) + 
  tm_raster(legend.show = TRUE, palette = colfunc2, title = "") +
  tm_layout(outer.margins = rep(0.01, 4), 
            inner.margins = rep(0, 4)) +
  tm_legend(bg.color = "white")

tmap_arrange(p1, p2, nrow = 1)
