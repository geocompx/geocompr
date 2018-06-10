library(raster)
library(gridExtra)
library(spData)

# first intro plot -----------------------------------------------------------
set.seed(2017-04-01)

small_ras = raster(matrix(1:16, 4, 4, byrow = TRUE))
small_ras_val = raster(matrix(sample.int(100, 16), 4, 4, byrow = TRUE))
small_ras_val[c(7, 9)] = NA

polys = rasterToPolygons(small_ras, na.rm = FALSE)
# cell IDs
p_1 = spplot(small_ras, colorkey = FALSE, col.regions = "white",
             main = "A. Cell IDs",
             sp.layout = list(
               list("sp.polygons", polys, first = FALSE),
               list("sp.text", xyFromCell(small_ras_val, 1:ncell(small_ras)),
                    1:ncell(small_ras))
             )
)
# cell values
p_2 = spplot(small_ras_val, colorkey = FALSE, col.regions = "white",
             main = "B. Cell values",
             sp.layout = list(
               list("sp.polygons", polys, first = FALSE),
               list("sp.text", xyFromCell(small_ras_val,
                                          1:ncell(small_ras_val)),
                    values(small_ras_val))
             )
)
# color map
p_3 = spplot(small_ras_val, 
             col.regions = colorRampPalette(c("#a50026", "#ffffbf", "#006837"))(16),
             colorkey = FALSE,
             main = "C. Colored cell values")

raster_intro_plot = arrangeGrob(p_1, p_2, p_3, ncol = 3)

plot(raster_intro_plot)
# 
# ggsave(plot = raster_intro_plot, filename = "figures/02_raster_intro_plot.png",
#        width = 6, height = 3, scale = 1.25)
