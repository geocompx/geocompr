library(ggplot2)
library(visualraster)
library(gridExtra)
theme_set(theme_fullframe())

set.seed(2017-04-01)

small_ras = raster(matrix(1:16, 4, 4, byrow =TRUE))
small_ras_val = raster(matrix(sample.int(100, 16), 4, 4, byrow =TRUE))
small_ras_val[c(7, 9)] = NA

empty_grid_plot = ggplot() +
  vr_geom_raster_seq(small_ras) +
  scale_fill_gradientn(colors = c("white")) +
  labs(title = "A. Raster grid")

cells_num_plot = ggplot() +
  vr_geom_raster_seq(small_ras) +
  vr_geom_text(small_ras) + 
  scale_fill_gradientn(colors = c("white")) +
  labs(title = "B. Cells numbers")

cells_val_plot = ggplot() +
  vr_geom_raster_seq(small_ras_val) +
  vr_geom_text(small_ras_val) + 
  scale_fill_gradientn(colors = c("white")) +
  labs(title = "C. Cells values")

map_plot = ggplot() +
  vr_geom_raster_seq(small_ras_val) +
  # vr_geom_text(small_ras_val) +
  labs(title = "D. Raster map") +
  scale_fill_gradientn(colours=c("#a50026", "#ffffbf", "#006837"))

raster_intro_plot = arrangeGrob(empty_grid_plot, cells_num_plot,
             cells_val_plot, map_plot, 
             ncol = 2)

ggsave(plot = raster_intro_plot, filename = "figures/raster_intro_plot.png", width = 5, height = 5)
