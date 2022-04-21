# Filename: 12-cv.R (2022-02-16)
#
# TO DO: Introduce spatial cross-validation with the help of mlr3
#
# Author(s): Jannes Muenchow
#
#**********************************************************
# contents----
#**********************************************************
#
# 1 attach packages and data
# 2 modeling 
# 3 spatial prediction
#
#**********************************************************
# 1 attach packages and data----
#**********************************************************

# attach packages
library(dplyr)
library(ggplot2)
library(mlr3)
library(mlr3extralearners)
library(mlr3learners)
library(mlr3spatiotempcv)
library(mlr3tuning)
library(raster)
library(sf)
library(tmap)

#**********************************************************
# 2 modeling----
#**********************************************************

# attach data
data("lsl", "study_mask", package = "spDataLarge")
ta = terra::rast(system.file("raster/ta.tif", package = "spDataLarge"))

# 2.1 create a mlr3 task====
#**********************************************************
# id = name of the task
# target = response variable
# spatial: setting up the scene for spatial cv (hence x and y will not be used
# as predictors but as coordinates for kmeans clustering)
# all variables in data will be used in the model

task = TaskClassifST$new(
  id = "lsl_glm_sp",
  backend = mlr3::as_data_backend(lsl), target = "lslpts", positive = "TRUE",
  extra_args = list(
    coordinate_names = c("x", "y"),
    coords_as_features = FALSE,
    crs = 32717)
)
# pls note that you can use a task created by TaskClassifST for both the spatial
# and the conventional CV approach

# 2.2 construct a learner and run the model====
#**********************************************************

# glm learner
lrn_glm = lrn("classif.log_reg", predict_type = "prob")
# define a fallback learner in case one model fails
lrn_glm$fallback = lrn("classif.featureless", predict_type = "prob")

# construct SVM learner (using ksvm function from the kernlab package)
lrn_ksvm = lrn("classif.ksvm", predict_type = "prob", kernel = "rbfdot",
               type = "C-svc")
lrn_ksvm$fallback = lrn("classif.featureless", predict_type = "prob")
# rbfdot Radial Basis kernel "Gaussian" 
# the list of hyper-parameters (kernel parameters). This is a list which
# contains the parameters to be used with the kernel function. For valid
# parameters for existing kernels are :
# sigma inverse kernel width for the Radial Basis kernel function "rbfdot" and
# the Laplacian kernel "laplacedot".
# C cost of constraints violation (default: 1) this is the ‘C’-constant of the
# regularization term in the Lagrange formulation.

# specify nested resampling and adjust learner accordingly
# five spatially disjoint partitions
tune_level = rsmp("spcv_coords", folds = 5)
# use 50 randomly selected hyperparameters
terminator = trm("evals", n_evals = 50)
tuner = tnr("random_search")
# define the outer limits of the randomly selected hyperparameters
search_space = ps(
  C = p_dbl(lower = -12, upper = 15, trafo = function(x) 2^x),
  sigma = p_dbl(lower = -15, upper = 6, trafo = function(x) 2^x)
)

at_ksvm = AutoTuner$new(
  learner = lrn_ksvm,
  resampling = tune_level,
  measure = msr("classif.auc"),
  search_space = search_space,
  terminator = terminator,
  tuner = tuner
)

# 2.3 cross-validation====
#**********************************************************

# specify the reampling method, i.e. spatial CV with 100 repetitions and 5 folds
# -> in each repetition dataset will be splitted into five folds
# method: repeated_spcv_coords -> spatial partioning
# method: repeated_cv -> non-spatial partitioning
rsmp_sp = rsmp("repeated_spcv_coords", folds = 5, repeats = 100)
rsmp_nsp = rsmp("repeated_cv", folds = 5, repeats = 100)

# create your design
design_grid = benchmark_grid(
  tasks = task,
  learners = list(lrn_glm, at_ksvm),
  resamplings = list(rsmp_sp, rsmp_nsp))
print(design_grid)
# run the cross-validations (spatial and conventional)
# execute the outer loop sequentially and parallelize the inner loop
future::plan(list("sequential", "multisession"), 
             # use half of all available cores
             # workers = floor(future::availableCores()) / 2
             workers = 8)

# why do we need the seed?
# the seed is needed when to make sure
# that always the same spatial partitions are used when re-running the code
set.seed(012348)
# reduce verbosity
lgr::get_logger("mlr3")$set_threshold("warn")
lgr::get_logger("bbotk")$set_threshold("info")
tictoc::tic()
progressr::with_progress(expr = {
  # New argument `encapsulate` for `resample()` and `benchmark()` to
  # conveniently enable encapsulation and also set the fallback learner to the
  # respective featureless learner. This is simply for convenience, configuring
  # each learner individually is still possible and allows a more fine-grained
  # control
  bmr = benchmark(design_grid, 
                  encapsulate = "evaluate",
                  store_backends = FALSE,
                  store_models = FALSE)
})
tictoc::toc()
# stop the parallelization plan
future:::ClusterRegistry("stop")
# save your result
# saveRDS(bmr, file = "extdata/12-bmr_glm_svm_spcv_convcv.rds")

# plot your result
# library(mlr3viz)
# p1 = autoplot(bmr, measure = msr("classif.auc"))
# p1$labels$y = "AUROC"
# p1$layers[[1]]$aes_params$fill = c("lightblue2", "mistyrose2")
# p1 + 
#   scale_x_discrete(labels=c("spatial CV", "conventional CV")) +
#   ggplot2::theme_bw()

# instead of using autoplot, it might be easier to create the figure yourself
score = bmr$score(measure = mlr3::msr("classif.auc")) %>%
  # keep only the columns you need
  .[, .(task_id, learner_id, resampling_id, classif.auc)]
# or read in the score
# score = readRDS("extdata/12-bmr_score.rds")

# rename the levels of resampling_id
score[, resampling_id := as.factor(resampling_id) |>
        forcats::fct_recode("conventional CV" = "repeated_cv",
                            "spatial CV" = "repeated_spcv_coords") |>
        forcats::fct_rev()]
# create the boxplot which shows the overfitting in the nsp-case
ggplot2::ggplot(
  data = score,
  mapping = ggplot2::aes(x = interaction(resampling_id, learner_id),
                         y = classif.auc, fill = resampling_id
  )) +
  ggplot2::geom_boxplot() +
  ggplot2::theme_bw() +
  ggplot2::labs(y = "AUROC", x = "")

#**********************************************************
# 3 spatial prediction----
#**********************************************************

#**********************************************************
# 3.1 make the prediction using the glm====
#**********************************************************

lrn_glm$train(task)
fit = lrn_glm$model
# according to lrn_glm$help() the default for predictions was adjusted to FALSE,
# since we would like to have TRUE predictions, we have to change back
# fit$coefficients = fit$coefficients * -1

pred = terra::predict(object = ta, model = fit, fun = predict,
                      type = "response")

# make the prediction "manually"
ta_2 = ta
newdata = as.data.frame(as.matrix(ta_2))
colSums(is.na(newdata))  # ok, there are NAs
ind = rowSums(is.na(newdata)) == 0
tmp = lrn_glm$predict_newdata(newdata = newdata[ind, ], task = task)
newdata[ind, "pred"] = as.data.table(tmp)[["prob.TRUE"]]
# check
all.equal(as.numeric(values(pred)), newdata$pred)  # TRUE
pred_2 = ta$slope
pred_2[] = newdata$pred

#**********************************************************
# 3.2 plot the prediction====
#**********************************************************

hs = terra::shade(ta$slope * pi / 180,
                  terra::terrain(ta$elev, v = "aspect", unit = "radians"),
                  40, 270)
plot(hs, col = gray(seq(0, 1, length.out = 100)), legend = FALSE)
plot(pred, col = RColorBrewer::brewer.pal(name = "Reds", 9), add = TRUE)

# or using tmap
# white raster to only plot the axis ticks, otherwise gridlines would be visible
study_mask = terra::vect(study_mask)
lsl_sf = st_as_sf(lsl, coords = c("x", "y"), crs = 32717)
rect = tmaptools::bb_poly(raster::raster(hs))
bbx = tmaptools::bb(raster::raster(hs), xlim = c(-0.02, 1), ylim = c(-0.02, 1),
                    relative = TRUE)
tm_shape(hs, bbox = bbx) +
  tm_grid(col = "black", n.x = 1, n.y = 1, labels.inside.frame = FALSE,
          labels.rot = c(0, 90)) +
  tm_raster(palette = "white", legend.show = FALSE) +
  # hillshade
  tm_shape(terra::mask(hs, study_mask), bbox = bbx) +
  tm_raster(palette = gray(0:100 / 100), n = 100,
            legend.show = FALSE) +
  # prediction raster
  tm_shape(terra::mask(pred, study_mask)) +
  tm_raster(alpha = 0.5, palette = "Reds", n = 6, legend.show = TRUE,
            title = "Susceptibility") +
  # rectangle and outer margins
  qtm(rect, fill = NULL) +
  tm_layout(outer.margins = c(0.04, 0.04, 0.02, 0.02), frame = FALSE,
            legend.position = c("left", "bottom"),
            legend.title.size = 0.9)
