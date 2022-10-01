## ----15-eco-1, message=FALSE------------------------------------------------------------------------------------------------------------------------------
library(data.table)
library(dplyr)
library(mlr3)
library(mlr3spatiotempcv)
library(mlr3tuning)
library(mlr3learners)
library(qgisprocess)
library(paradox)
library(ranger)
library(tree)
library(sf)
library(terra)
library(tree)
library(vegan)


## ----study-area-mongon, echo=FALSE, fig.cap="The Mt. Mongón study area, from Muenchow, Schratz, and Brenning (2017).", out.width="60%", fig.scap="The Mt. Mongón study area."----
knitr::include_graphics("figures/15_study_area_mongon.png")
# knitr::include_graphics("https://user-images.githubusercontent.com/1825120/38989956-6eae7c9a-43d0-11e8-8f25-3dd3594f7e74.png")


## ----15-eco-2---------------------------------------------------------------------------------------------------------------------------------------------
data("study_area", "random_points", "comm", package = "spDataLarge")
dem = rast(system.file("raster/dem.tif", package = "spDataLarge"))
ndvi = rast(system.file("raster/ndvi.tif", package = "spDataLarge"))


## ----15-eco-3, eval=FALSE---------------------------------------------------------------------------------------------------------------------------------
## # sites 35 to 40 and corresponding occurrences of the first five species in the
## # community matrix
## comm[35:40, 1:5]
## #>    Alon_meri Alst_line Alte_hali Alte_porr Anth_eccr
## #> 35         0         0         0       0.0     1.000
## #> 36         0         0         1       0.0     0.500
## #> 37         0         0         0       0.0     0.125
## #> 38         0         0         0       0.0     3.000
## #> 39         0         0         0       0.0     2.000
## #> 40         0         0         0       0.2     0.125


## ----sa-mongon, echo=FALSE, message=FALSE, fig.cap="Study mask (polygon), location of the sampling sites (black points) and DEM in the background.", fig.scap="Study mask, location of the sampling sites."----
# hs = terra::shade(terra::terrain(dem, v = "slope", unit = "radians"),
#                   terra::terrain(dem, v = "aspect", unit = "radians"),
#                   10, 200)
# library(tmap)
# tm = tm_shape(hs) +
#   tm_grid(n.x = 3, n.y = 3) +
#   tm_raster(style = "cont", palette = rev(hcl.colors(99, "Grays")),
#             legend.show = FALSE) +
#   tm_shape(dem) +
#   tm_raster(alpha = 0.5,
#             style = "cont",
#             title = "m asl",
#             legend.reverse = TRUE,
#             n = 11,
#             palette = terrain.colors(50)) +
#   tm_shape(study_area) +
#   tm_borders() +
#   tm_shape(random_points) +
#   tm_dots() +
#   tm_layout(inner.margins = 0, legend.outside = TRUE)
# tmap_save(tm, "figures/15_sa_mongon_sampling.png",
#           width = 12, height = 7, units = "cm")
knitr::include_graphics("figures/15_sa_mongon_sampling.png")


## ----15-eco-5, eval=FALSE---------------------------------------------------------------------------------------------------------------------------------
## qgisprocess::qgis_show_help("saga:sagawetnessindex")
## #> Saga wetness index (saga:sagawetnessindex)
## #> ...
## #> ----------------
## #> Arguments
## #> ----------------
## #>
## #> DEM: Elevation
## #> 	Argument type:	raster
## #> 	Acceptable values:
## #> 		- Path to a raster layer
## #> ...
## #> SLOPE_TYPE: Type of Slope
## #> 	Argument type:	enum
## #> 	Available values:
## #> 		- 0: [0] local slope
## #> 		- 1: [1] catchment slope
## #> ...
## #> AREA: Catchment area
## #> 	Argument type:	rasterDestination
## #> 	Acceptable values:
## #> 		- Path for new raster layer
## #>...
## #> ----------------
## #> Outputs
## #> ----------------
## #>
## #> AREA: <outputRaster>
## #> 	Catchment area
## #> SLOPE: <outputRaster>
## #> 	Catchment slope
## #> ...


## ----15-eco-6, eval=FALSE---------------------------------------------------------------------------------------------------------------------------------
## # environmental predictors: catchment slope and catchment area
## ep = qgisprocess::qgis_run_algorithm(
##   alg = "saga:sagawetnessindex",
##   DEM = dem,
##   SLOPE_TYPE = 1,
##   SLOPE = tempfile(fileext = ".sdat"),
##   AREA = tempfile(fileext = ".sdat"),
##   .quiet = TRUE)


## ----15-eco-7, eval=FALSE---------------------------------------------------------------------------------------------------------------------------------
## # read in catchment area and catchment slope
## ep = ep[c("AREA", "SLOPE")] |>
##   unlist() |>
##   terra::rast()
## names(ep) = c("carea", "cslope") # assign proper names
## terra::origin(ep) = terra::origin(dem) # make sure rasters have the same origin
## ep = c(dem, ndvi, ep) # add dem and ndvi to the multilayer SpatRaster object


## ----15-eco-8, eval=FALSE---------------------------------------------------------------------------------------------------------------------------------
## ep$carea = log10(ep$carea)


## ----15-eco-9, cache.lazy=FALSE---------------------------------------------------------------------------------------------------------------------------
ep = terra::rast(system.file("raster/ep.tif", package = "spDataLarge"))


## ----15-eco-10, cache=TRUE, cache.lazy=FALSE, message=FALSE, warning=FALSE--------------------------------------------------------------------------------
# terra::extract adds automatically a for our purposes unnecessary ID column
ep_rp = terra::extract(ep, random_points) |>
  dplyr::select(-ID)
random_points = cbind(random_points, ep_rp)


## ----15-eco-11--------------------------------------------------------------------------------------------------------------------------------------------
# presence-absence matrix
pa = vegan::decostand(comm, "pa")  # 100 rows (sites), 69 columns (species)
# keep only sites in which at least one species was found
pa = pa[rowSums(pa) != 0, ]  # 84 rows, 69 columns


## ----15-eco-12, eval=FALSE, message=FALSE-----------------------------------------------------------------------------------------------------------------
## set.seed(25072018)
## nmds = vegan::metaMDS(comm = pa, k = 4, try = 500)
## nmds$stress
## #> ...
## #> Run 498 stress 0.08834745
## #> ... Procrustes: rmse 0.004100446  max resid 0.03041186
## #> Run 499 stress 0.08874805
## #> ... Procrustes: rmse 0.01822361  max resid 0.08054538
## #> Run 500 stress 0.08863627
## #> ... Procrustes: rmse 0.01421176  max resid 0.04985418
## #> *** Solution reached
## #> 0.08831395


## ----15-eco-13, eval=FALSE, echo=FALSE--------------------------------------------------------------------------------------------------------------------
## saveRDS(nmds, "extdata/15-nmds.rds")


## ----15-eco-14, include=FALSE-----------------------------------------------------------------------------------------------------------------------------
nmds = readRDS("extdata/15-nmds.rds")


## ----xy-nmds-code, fig.cap="Plotting the first NMDS axis against altitude.", fig.scap = "First NMDS axis against altitude plot.", fig.asp=1, out.width="60%", eval=FALSE----
## elev = dplyr::filter(random_points, id %in% rownames(pa)) |>
##   dplyr::pull(dem)
## # rotating NMDS in accordance with altitude (proxy for humidity)
## rotnmds = vegan::MDSrotate(nmds, elev)
## # extracting the first two axes
## sc = vegan::scores(rotnmds, choices = 1:2)
## # plotting the first axis against altitude
## plot(y = sc[, 1], x = elev, xlab = "elevation in m",
##      ylab = "First NMDS axis", cex.lab = 0.8, cex.axis = 0.8)


## ----xy-nmds, fig.cap="Plotting the first NMDS axis against altitude.", fig.scap = "First NMDS axis against altitude plot.", fig.asp=1, out.width="60%", message=FALSE, echo=FALSE----
elev = dplyr::filter(random_points, id %in% rownames(pa)) |> 
  dplyr::pull(dem)
# rotating NMDS in accordance with altitude (proxy for humidity)
rotnmds = vegan::MDSrotate(nmds, elev)
# extracting the first two axes
sc = vegan::scores(rotnmds, choices = 1:2)
knitr::include_graphics("figures/15_xy_nmds.png")


## ----15-eco-15, eval=FALSE, echo=FALSE--------------------------------------------------------------------------------------------------------------------
## # scores and rotated scores in one figure
## p1 = xyplot(scores(rotnmds)[, 2] ~ scores(rotnmds)[, 1], pch = 16,
##              col = "lightblue", xlim = c(-3, 2), ylim = c(-2, 2),
##              xlab = list("Dimension 1", cex = 0.8),
##              ylab = list("Dimension 2", cex = 0.8),
##              scales = list(x = list(relation = "same", cex = 0.8),
##                            y = list(relation = "same", cex = 0.8),
##                            # ticks on top are suppressed
##                            tck = c(1, 0),
##                            # plots axes labels only in row and column 1 and 4
##                            alternating = c(1, 0, 0, 1),
##                            draw = TRUE),
##              # we have to use the same colors in the legend as used for the plot
##              # points
##              par.settings = simpleTheme(col = c("lightblue", "salmon"),
##                                         pch = 16, cex = 0.9),
##              # also the legend point size should be somewhat smaller
##              auto.key = list(x = 0.7, y = 0.9, text = c("unrotated", "rotated"),
##                              between = 0.5, cex = 0.9),
##              panel = function(x, y, ...) {
##                            # Plot the points
##                            panel.points(x, y, cex = 0.6, ...)
##                            panel.points(x = scores(nmds)[, 1],
##                                         y = scores(nmds)[, 2],
##                                         col = "salmon", pch = 16, cex = 0.6)
##                            panel.arrows(x0 = scores(nmds)[, 1],
##                                         y0 = scores(nmds)[, 2],
##                                         x1 = x,
##                                         y1 = y,
##                                         length = 0.04,
##                                         lwd = 0.4)
##             })
## 
## plot(scores(nmds, choices = 1:2))
## points(scores(rotnmds, choices = 1:2), col = "lightblue", pch = 16)
## 
## 
## sc = scores(nmds, choices = 1:2) |> as.data.frame()
## sc$id = rownames(sc) |> as.numeric()
## rp = inner_join(select(sc, id), st_drop_geometry(random_points))
## fit_1 = envfit(nmds, select(rp, dem))
## fit_2 = envfit(rotnmds, select(rp, dem))
## par(mfrow = c(1, 2))
## plot(nmds, display = "sites")
## plot(fit_1)
## plot(rotnmds, display = "sites")
## plot(fit_2)


## ----15-eco-16, message=FALSE, eval=FALSE-----------------------------------------------------------------------------------------------------------------
## # construct response-predictor matrix
## # id- and response variable
## rp = data.frame(id = as.numeric(rownames(sc)), sc = sc[, 1])
## # join the predictors (dem, ndvi and terrain attributes)
## rp = inner_join(random_points, rp, by = "id")


## ----attach-rp, echo=FALSE--------------------------------------------------------------------------------------------------------------------------------
# rp = data.frame(id = as.numeric(rownames(sc)), sc = sc[, 1])
# rp = inner_join(random_points, rp, by = "id")
# saveRDS(rp, "extdata/15-rp.rds")
rp = readRDS("extdata/15-rp.rds")


## ----15-eco-17, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
## tree_mo = tree::tree(sc ~ dem, data = rp)
## plot(tree_mo)
## text(tree_mo, pretty = 0)


## ----tree, echo=FALSE, fig.cap="Simple example of a decision tree with three internal nodes and four terminal nodes.", out.width="60%", fig.scap="Simple example of a decision tree."----
# tree_mo = tree::tree(sc ~ dem, data = rp)
# png("figures/15_tree.png", width = 1100, height = 700, units = "px", res = 300)
# par(mar = rep(1, 4))
# plot(tree_mo)
# text(tree_mo, pretty = 0)
# dev.off()
knitr::include_graphics("figures/15_tree.png")


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(eval = FALSE)


## ----15-eco-20--------------------------------------------------------------------------------------------------------------------------------------------
# create task
task = mlr3spatiotempcv::as_task_regr_st(dplyr::select(rp, -id, -spri),
  id = "mongon", target = "sc")


## ----15-eco-21--------------------------------------------------------------------------------------------------------------------------------------------
lrn_rf = lrn("regr.ranger", predict_type = "response")


## ----15-eco-22--------------------------------------------------------------------------------------------------------------------------------------------
# specifying the search space
search_space = paradox::ps(
  mtry = paradox::p_int(lower = 1, upper = ncol(task$data()) - 1),
  sample.fraction = paradox::p_dbl(lower = 0.2, upper = 0.9),
  min.node.size = paradox::p_int(lower = 1, upper = 10)
)


## ----15-eco-23--------------------------------------------------------------------------------------------------------------------------------------------
autotuner_rf = mlr3tuning::AutoTuner$new(
  learner = lrn_rf,
  resampling = mlr3::rsmp("spcv_coords", folds = 5), # spatial partitioning
  measure = mlr3::msr("regr.rmse"), # performance measure
  terminator = mlr3tuning::trm("evals", n_evals = 50), # specify 50 iterations
  search_space = search_space, # predefined hyperparameter search space
  tuner = mlr3tuning::tnr("random_search") # specify random search
)


## ----15-eco-24, eval=FALSE, cache=TRUE, cache.lazy=FALSE--------------------------------------------------------------------------------------------------
## # hyperparameter tuning
## set.seed(0412022)
## autotuner_rf$train(task)


## ----15-eco-25, cache=TRUE, cache.lazy=FALSE, eval=FALSE, echo=FALSE--------------------------------------------------------------------------------------
## saveRDS(autotuner_rf, "extdata/15-tune.rds")


## ----15-eco-26, echo=FALSE, cache=TRUE, cache.lazy=FALSE--------------------------------------------------------------------------------------------------
autotuner_rf = readRDS("extdata/15-tune.rds")


## ----tuning-result, cache=TRUE, cache.lazy=FALSE----------------------------------------------------------------------------------------------------------
autotuner_rf$tuning_result


## ----15-eco-27, cache=TRUE, cache.lazy=FALSE--------------------------------------------------------------------------------------------------------------
# predicting using the best hyperparameter combination
autotuner_rf$predict(task)


## ----15-eco-28, cache=TRUE, cache.lazy=FALSE, eval=FALSE--------------------------------------------------------------------------------------------------
## pred = terra::predict(ep, model = autotuner_rf, fun = predict)


## ----rf-pred, echo=FALSE, fig.cap="Predictive mapping of the floristic gradient clearly revealing distinct vegetation belts.", out.width="60%", fig.scap="Predictive mapping of the floristic gradient."----
# hs = terra::shade(terra::terrain(dem, v = "slope", unit = "radians"),
#                   terra::terrain(dem, v = "aspect", unit = "radians"),
#                   10, 200) |>
#   terra::mask(terra::vect(study_area))
# pred = terra::mask(pred, terra::vect(study_area)) |>
#   terra::trim()
# library(tmap)
# pal = rev(hcl.colors(n = 15, "RdYlBu"))
# tm = tm_shape(hs) +
#   tm_grid(n.x = 3, n.y = 3, lines = FALSE) +
#   tm_raster(style = "cont", palette = rev(hcl.colors(99, "Grays")),
#             legend.show = FALSE) +
#   tm_shape(pred, is.master = TRUE) +
#   tm_raster(style = "cont", title = "NMDS1", alpha = 0.8,
#             legend.reverse = TRUE, palette = pal, midpoint	= NA) +
#   tm_shape(study_area) +
#   tm_borders() +
#   tm_layout(inner.margins = 0.02, legend.outside = TRUE)
# tmap_save(tm, "figures/15_rf_pred.png",
#           width = 12, height = 7, units = "cm")
knitr::include_graphics("figures/15_rf_pred.png")


## ----15-eco-29, cache=TRUE, cache.lazy=FALSE, eval=FALSE--------------------------------------------------------------------------------------------------
## newdata = as.data.frame(as.matrix(ep))
## colSums(is.na(newdata))  # 0 NAs
## # but assuming there were 0s results in a more generic approach
## ind = rowSums(is.na(newdata)) == 0
## tmp = autotuner_rf$predict_newdata(newdata = newdata[ind, ], task = task)
## newdata[ind, "pred"] = data.table::as.data.table(tmp)[["response"]]
## pred_2 = ep$dem
## # now fill the raster with the predicted values
## pred_2[] = newdata$pred
## # check if terra and our manual prediction is the same
## all(values(pred - pred_2) == 0)


## ---- echo=FALSE, results='asis'--------------------------------------------------------------------------------------------------------------------------
res = knitr::knit_child('_15-ex.Rmd', quiet = TRUE, options = list(include = FALSE, eval = FALSE))
cat(res, sep = '\n')

