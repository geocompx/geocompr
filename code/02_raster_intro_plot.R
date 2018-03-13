library(raster)
library(ggplot2)
library(visualraster)
library(gridExtra)
library(spData)
library(spDataLarge)
library(lattice)
library(latticeExtra)

theme_set(theme_fullframe())

# first intro plot -----------------------------------------------------------
set.seed(2017-04-01)

small_ras = raster(matrix(1:16, 4, 4, byrow = TRUE))
small_ras_val = raster(matrix(sample.int(100, 16), 4, 4, byrow =TRUE))
# NAvalue(small_ras_val) <- NA
small_ras_val[c(7, 9)] = NA
# small_ras_val_2 <- small_ras_val
# small_ras_val_2[c(7, 9)] <- NA

# empty_grid_plot = ggplot() +
#   vr_geom_raster_seq(small_ras) +
#   scale_fill_gradientn(colors = c("white")) +
#   labs(title = "A. Raster grid")

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


# cells_num_plot = ggplot() +
#   vr_geom_raster_seq(small_ras) +
#   vr_geom_text(small_ras) + 
#   scale_fill_gradientn(colors = c("white")) +
#   labs(title = "A. Cell IDs")
# 
# cells_val_plot = ggplot() +
#   vr_geom_raster_seq(small_ras_val) +
#   vr_geom_text(small_ras_val) + 
#   scale_fill_gradientn(colors = c("white")) +
#   labs(title = "B. Cell values")
# 
# map_plot = ggplot() +
#   vr_geom_raster_seq(small_ras_val_2) +
#   # vr_geom_text(small_ras_val) +
#   labs(title = "C. Coloring cell values") +
#   scale_fill_gradientn(colours = c("#a50026", "#ffffbf", "#006837"))

raster_intro_plot = arrangeGrob(p_1, p_2, p_3,
                                ncol = 3)

ggsave(plot = raster_intro_plot, filename = "figures/02_raster_intro_plot.png",
       width = 6, height = 3, scale = 1.25)

# second intro plot -----------------------------------------------------------
library(tmap)
library(grid)
library(rcartocolor)
library(spDataLarge)
terrain_colors = carto_pal(7, "TealRose")

cla_raster = raster(system.file("raster/srtm.tif", package="spDataLarge"))
cat_raster = nlcd

rast_srtm = tm_shape(cla_raster) +
  tm_raster(palette = terrain_colors, title = "Elevation (m)", 
            legend.show = TRUE, auto.palette.mapping = FALSE, style = "cont") + 
  tm_layout(legend.frame = TRUE, legend.position = c("right", "top"))

landcover_cols = c("#476ba0", "#aa0000", "#b2ada3", "#68aa63", "#a58c30", "#c9c977", "#dbd83d", "#bad8ea")
rast_nlcd = tm_shape(cat_raster) +
  tm_raster(palette = landcover_cols, style = "cat", title = "Land cover", 
            legend.show = TRUE) + 
  tm_layout(legend.frame = TRUE, legend.position = c("right", "top"))

png(filename = "figures/02_raster_intro_plot2.png", width = 950, height = 555)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2, heights = unit(c(0.25, 5), "null"))))
grid.text("A. Continuous data", vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
grid.text("B. Categorical data", vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(rast_srtm, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(rast_nlcd, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))
dev.off()