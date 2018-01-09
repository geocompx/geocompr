library(grid)
library(gridExtra)
library(sp)
# library(latticeExtra)
library(lattice)
library(RColorBrewer)
library(ggplot2)

colfunc = colorRampPalette(c("lightyellow", "rosybrown"))
# colfunc(10)
# p_1 = spplot(r, col.regions = terrain.colors(36))
p_1 = spplot(elev, col.regions = colfunc(36))
p_2 = spplot(grain, zcol = "VALUE",
             col.regions =  c("brown","sandybrown", "rosybrown"),
             colorkey = list(space = "right", axis.text = list(cex = 0.8),
                             height = 0.3))

ggplot2::ggplot() +
  ggplot2::theme_bw() +
  theme(panel.border = element_blank())
print(grid.draw(arrangeGrob(p_1, p_2, ncol = 2)))