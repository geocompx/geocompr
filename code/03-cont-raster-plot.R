# library(grid)
# library(gridExtra)
# library(sp)
# # library(latticeExtra)
# library(lattice)
# library(RColorBrewer)
# library(ggplot2)
# 
# colfunc = colorRampPalette(c("lightyellow", "rosybrown"))
# # colfunc(10)
# # p_1 = spplot(r, col.regions = terrain.colors(36))
# p_1 = spplot(elev, col.regions = colfunc(36))
# p_2 = spplot(grain, zcol = "VALUE",
#              col.regions =  c("brown","sandybrown", "rosybrown"),
#              colorkey = list(space = "right", axis.text = list(cex = 0.8),
#                              height = 0.3))
# 
# ggplot2::ggplot() +
#   ggplot2::theme_bw() +
#   theme(panel.border = element_blank())
# print(grid.draw(arrangeGrob(p_1, p_2, ncol = 2)))

library(tmap)
library(grid)
library(spData)
library(sp)
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

grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 2, heights = unit(c(0.25, 5), "null"))))
print(p1, vp = viewport(layout.pos.col = 1))
print(p2, vp = viewport(layout.pos.col = 2))
