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
# NAvalue(small_ras_val) = NA
small_ras_val[c(7, 9)] = NA
# small_ras_val_2 = small_ras_val
# small_ras_val_2[c(7, 9)] = NA

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
library(rasterVis)
cla_raster = raster(system.file("raster/srtm.tif", package="spDataLarge"))
cat_raster = raster(system.file("raster/nlcd2011.tif", package="spDataLarge"))

m = c(11, 11, 1, 21, 23, 2, 31, 31, 3, 41, 43, 4, 52, 52, 5, 71, 71, 6, 81, 82, 7, 90, 95, 8)
rclmat = matrix(m, ncol=3, byrow=TRUE)

cat_raster = reclassify(cat_raster, rclmat, include.lowest = TRUE, right = NA) %>% 
  ratify(.)

landcover = data.frame(landcover = c("Water", "Developed", "Barren", "Forest", "Shrubland", "Herbaceous", "Cultivated", "Wetlands"))
levels(cat_raster) = cbind(levels(cat_raster)[[1]], landcover) 

landcover_col = c("#b2ada3", "#dbd83d", "#aa0000", "#68aa63", "#c9c977", "#a58c30", "#476ba0", "#bad8ea")

## Key
key_landcover = c("Barren", "Cultivated","Developed", "Forest", "Herbaceous", "Shrubland", "Water", "Wetlands")
my_key = list(text=list(lab=key_landcover),
              rectangles=list(col = landcover_col),
              space = "inside",
              columns = 1,
              background = "white")

p2 = levelplot(cat_raster, col.regions = landcover_col, 
               colorkey = FALSE, key = my_key)

p1 = levelplot(cla_raster, margin = FALSE, colorkey = FALSE)

png(filename = "figures/02_raster_intro_plot2.png", width = 950, height = 555)
plot(p1, split=c(1, 1, 2, 1), more=TRUE)
plot(p2, split=c(2, 1, 2, 1))
dev.off()
