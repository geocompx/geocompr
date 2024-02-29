library(mlr3)
library(mlr3spatiotempcv)
library(sf)
library(purrr)
task_ecuador = tsk("ecuador")
set.seed(2024-01-14)

part_spcv_coords = rsmp("spcv_coords", folds = 5)
part_spcv_coords$instantiate(task_ecuador)

part_cv = rsmp("cv", folds = 5)
part_cv$instantiate(task_ecuador)

recreate_sf = function(type, fold){
  if (type == "spcv_coords"){
    part = part_spcv_coords
  } else {
    part = part_cv
  }
  data_sf = st_as_sf(task_ecuador$coordinates(), coords = c("x", "y"))
  st_crs(data_sf) = task_ecuador$crs
  data_sf$fold = fold
  data_sf$split = NA
  data_sf$split[part$train_set(fold)] = "training data"
  data_sf$split[part$test_set(fold)] = "test data"
  data_sf$type = type
  data_sf
}

param_df = data.frame(type = rep(c("spcv_coords", "cv"), each = 5), fold = rep(1:5, 2))
all_sf = pmap(param_df, recreate_sf)
all_sf = do.call(rbind, all_sf)

library(tmap)
tm_folds = tm_shape(all_sf) +
  tm_dots(fill = "split", size = 0.4, fill.legend = tm_legend(title = "")) +
  tm_facets_grid("type", "fold") +
  tm_layout(
    legend.position = tm_pos_out("center", "bottom"),
            legend.frame = FALSE,
            legend.resize.as.group = TRUE,
            legend.text.size = 1,
            panel.labels = list(c("random partitioning", "spatial partitioning"),
                             c("fold 1", "fold 2", "fold 3", "fold 4", "fold 5")))

tmap_save(tm_folds, "figures/12_partitioning.png", width = 1417, height = 726, dpi = 144)  
            