## ----12-spatial-cv-1, message=FALSE-----------------------------------------------------------------------------------------------------------------------
library(dplyr)
library(future)
library(lgr)
library(mlr3)
library(mlr3learners)
library(mlr3extralearners)
library(mlr3spatiotempcv)
library(mlr3tuning)
library(mlr3viz)
library(progressr)
library(sf)
library(terra)


## ----12-spatial-cv-2--------------------------------------------------------------------------------------------------------------------------------------
data("lsl", "study_mask", package = "spDataLarge")
ta = terra::rast(system.file("raster/ta.tif", package = "spDataLarge"))


## ----lsl-map, echo=FALSE, out.width="70%", fig.cap="Landslide initiation points (red) and points unaffected by landsliding (blue) in Southern Ecuador.", fig.scap="Landslide initiation points."----
# library(tmap)
# data("lsl", package = "spDataLarge")
# ta = terra::rast(system.file("raster/ta.tif", package = "spDataLarge"))
# lsl_sf = sf::st_as_sf(lsl, coords = c("x", "y"), crs = "EPSG:32717")
# hs = terra::shade(slope = ta$slope * pi / 180,
#                   terra::terrain(ta$elev, v = "aspect", unit = "radians"))
# # so far tmaptools does not support terra objects
# 
# bbx = tmaptools::bb(raster::raster(hs), xlim = c(-0.0001, 1),
#                     ylim = c(-0.0001, 1), relative = TRUE)
# 
# map = tm_shape(hs, bbox = bbx) +
#   tm_grid(col = "black", n.x = 1, n.y = 1, labels.inside.frame = FALSE,
#           labels.rot = c(0, 90), lines = FALSE) +
#   tm_raster(palette = gray(0:100 / 100), n = 100, legend.show = FALSE) +
#   tm_shape(ta$elev) +
#   tm_raster(alpha = 0.5, palette = terrain.colors(10), legend.show = FALSE) +
#   tm_shape(lsl_sf) +
#   tm_bubbles("lslpts", size = 0.2, palette = "-RdYlBu",
#              title.col = "Landslide: ") +
#   tm_layout(inner.margins = 0) +
#   tm_legend(bg.color = "white")
# tmap::tmap_save(map, filename = "figures/lsl-map-1.png", width = 11,
#                 height = 11, units = "cm")
knitr::include_graphics("figures/lsl-map-1.png")


## ----lslsummary, echo=FALSE, warning=FALSE----------------------------------------------------------------------------------------------------------------
lsl_table = lsl |>
  mutate(across(.cols = -any_of(c("x", "y", "lslpts")), ~signif(., 2)))
knitr::kable(lsl_table[c(1, 2, 350), ], caption = "Structure of the lsl dataset.",
             caption.short = "`lsl` dataset.", booktabs = TRUE) |>
  kableExtra::kable_styling(latex_options = "scale_down")


## ----12-spatial-cv-6--------------------------------------------------------------------------------------------------------------------------------------
fit = glm(lslpts ~ slope + cplan + cprof + elev + log10_carea,
          family = binomial(),
          data = lsl)


## ----12-spatial-cv-7--------------------------------------------------------------------------------------------------------------------------------------
class(fit)
fit


## ----12-spatial-cv-8--------------------------------------------------------------------------------------------------------------------------------------
pred_glm = predict(object = fit, type = "response")
head(pred_glm)


## ----12-spatial-cv-9, eval=FALSE--------------------------------------------------------------------------------------------------------------------------
## # making the prediction
## pred = terra::predict(ta, model = fit, type = "response")


## ----lsl-susc, echo=FALSE, out.width="70%",fig.cap="Spatial prediction of landslide susceptibility using a GLM.", fig.scap = "Spatial prediction of landslide susceptibility.", warning=FALSE----
# # attach study mask for the natural part of the study area
# data("lsl", "study_mask", package = "spDataLarge")
# ta = terra::rast(system.file("raster/ta.tif", package = "spDataLarge"))
# study_mask = terra::vect(study_mask)
# lsl_sf = sf::st_as_sf(lsl, coords = c("x", "y"), crs = 32717)
# hs = terra::shade(ta$slope * pi / 180,
#                   terra::terrain(ta$elev, v = "aspect", unit = "radians"))
# bbx = tmaptools::bb(raster::raster(hs), xlim = c(-0.0001, 1),
#                     ylim = c(-0.0001, 1), relative = TRUE)
# 
# map = tm_shape(hs, bbox = bbx) +
#   tm_grid(col = "black", n.x = 1, n.y = 1, labels.inside.frame = FALSE,
#           labels.rot = c(0, 90), lines = FALSE) +
#   tm_raster(palette = "white", legend.show = FALSE) +
#   # hillshade
#   tm_shape(terra::mask(hs, study_mask), bbox = bbx) +
# 	tm_raster(palette = gray(0:100 / 100), n = 100,
# 	          legend.show = FALSE) +
# 	# prediction raster
#   tm_shape(terra::mask(pred, study_mask)) +
# 	tm_raster(alpha = 0.5, palette = "Reds", n = 6, legend.show = TRUE,
# 	          title = "Susceptibility") +
# 	tm_layout(legend.position = c("left", "bottom"),
# 	          legend.title.size = 0.9,
# 	          inner.margins = 0)
# tmap::tmap_save(map, filename = "figures/lsl-susc-1.png", width = 11,
#                 height = 11, units = "cm")
knitr::include_graphics("figures/lsl-susc-1.png")


## ----12-spatial-cv-10, message=FALSE, eval=FALSE----------------------------------------------------------------------------------------------------------
## pROC::auc(pROC::roc(lsl$lslpts, fitted(fit)))
## #> Area under the curve: 0.8216


## ----partitioning, fig.cap="Spatial visualization of selected test and training observations for cross-validation of one repetition. Random (upper row) and spatial partitioning (lower row).", echo=FALSE, fig.scap="Spatial visualization of selected test and training observations."----
knitr::include_graphics("figures/13_partitioning.png")


## ----building-blocks, echo=FALSE, fig.height=4, fig.width=4, fig.cap="Basic building blocks of the mlr3 package. Source: @becker_mlr3_2022. (Permission to reuse this figure was kindly granted.)", fig.scap="Basic building blocks of the mlr3 package."----
knitr::include_graphics("figures/13_ml_abstraction_crop.png")


## ----12-spatial-cv-11, eval=FALSE-------------------------------------------------------------------------------------------------------------------------
## # create task
## task = mlr3spatiotempcv::TaskClassifST$new(
##   id = "ecuador_lsl",
##   backend = mlr3::as_data_backend(lsl),
##   target = "lslpts",
##   positive = "TRUE",
##   extra_args = list(
##     coordinate_names = c("x", "y"),
##     coords_as_features = FALSE,
##     crs = "EPSG:32717")
##   )


## ----autoplot, eval=FALSE---------------------------------------------------------------------------------------------------------------------------------
## # plot response against each predictor
## mlr3viz::autoplot(task, type = "duo")
## # plot all variables against each other
## mlr3viz::autoplot(task, type = "pairs")


## ----12-spatial-cv-12, eval=FALSE-------------------------------------------------------------------------------------------------------------------------
## mlr3extralearners::list_mlr3learners(
##   filter = list(class = "classif", properties = "twoclass"),
##   select = c("id", "mlr3_package", "required_packages")) |>
##   head()


## ----lrns, echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------
lrns_df = mlr3extralearners::list_mlr3learners(
  filter = list(class = "classif", properties = "twoclass"), 
  select = c("id", "mlr3_package", "required_packages")) |>
  head()
# dput(lrns_df)
# lrns_df = structure(list(Class = c("classif.adaboostm1", "classif.binomial", 
# "classif.featureless", "classif.fnn", "classif.gausspr", "classif.IBk"
# ), Name = c("ada Boosting M1", "Binomial Regression", "Featureless classifier", 
# "Fast k-Nearest Neighbour", "Gaussian Processes", "k-Nearest Neighbours"
# ), `Short name` = c("adaboostm1", "binomial", "featureless", 
# "fnn", "gausspr", "ibk"), Package = c("RWeka", "stats", "mlr", 
# "FNN", "kernlab", "RWeka")), row.names = c(NA, 6L), class = "data.frame")
knitr::kable(lrns_df, 
             caption = paste("Sample of available learners for binomial", 
                             "tasks in the mlr3 package."), 
             caption.short = "Sample of available learners.", booktabs = TRUE)


## ----12-spatial-cv-13, eval=FALSE-------------------------------------------------------------------------------------------------------------------------
## learner = mlr3::lrn("classif.log_reg", predict_type = "prob")


## ----12-spatial-cv-14, eval=FALSE-------------------------------------------------------------------------------------------------------------------------
## learner$help()


## ----12-spatial-cv-15, eval=FALSE-------------------------------------------------------------------------------------------------------------------------
## learner$train(task)
## learner$model


## ----12-spatial-cv-16, eval=FALSE, echo=FALSE-------------------------------------------------------------------------------------------------------------
## learner$model$formula
## task$data()
## learner$model


## ----12-spatial-cv-17, eval=FALSE-------------------------------------------------------------------------------------------------------------------------
## fit = glm(lslpts ~ ., family = binomial(link = "logit"),
##           data = dplyr::select(lsl, -x, -y))
## identical(fit$coefficients, learner$model$coefficients)


## ----12-spatial-cv-18, eval=FALSE-------------------------------------------------------------------------------------------------------------------------
## resampling = mlr3::rsmp("repeated_spcv_coords", folds = 5, repeats = 100)


## ----12-spatial-cv-19, eval=FALSE-------------------------------------------------------------------------------------------------------------------------
## # reduce verbosity
## lgr::get_logger("mlr3")$set_threshold("warn")
## # run spatial cross-validation and save it to resample result glm (rr_glm)
## rr_spcv_glm = mlr3::resample(task = task,
##                              learner = learner,
##                              resampling = resampling)
## # compute the AUROC as a data.table
## score_spcv_glm = rr_spcv_glm$score(measure = mlr3::msr("classif.auc")) %>%
##   # keep only the columns you need
##   .[, .(task_id, learner_id, resampling_id, classif.auc)]


## ----12-spatial-cv-21-------------------------------------------------------------------------------------------------------------------------------------
score = readRDS("extdata/12-bmr_score.rds")
score_spcv_glm = score[learner_id == "classif.log_reg" & 
                         resampling_id == "repeated_spcv_coords"]


## ----12-spatial-cv-22-------------------------------------------------------------------------------------------------------------------------------------
mean(score_spcv_glm$classif.auc) |>
  round(2)


## ----boxplot-cv, echo=FALSE, out.width="75%", fig.cap="Boxplot showing the difference in GLM AUROC values on spatial and conventional 100-repeated 5-fold cross-validation.", fig.scap="Boxplot showing AUROC values."----
library(ggplot2)
# rename the levels of resampling_id
score[, resampling_id := as.factor(resampling_id) |>
        forcats::fct_recode("conventional CV" = "repeated_cv", 
                            "spatial CV" = "repeated_spcv_coords") |> 
            forcats::fct_rev()]
# create the boxplot
ggplot2::ggplot(data = score[learner_id == "classif.log_reg"], 
                mapping = ggplot2::aes(x = resampling_id, y = classif.auc)) +
  ggplot2::geom_boxplot(fill = c("lightblue2", "mistyrose2")) +
  ggplot2::theme_bw() +
  ggplot2::labs(y = "AUROC", x = "")


## ----12-spatial-cv-23-------------------------------------------------------------------------------------------------------------------------------------
mlr3_learners = list_mlr3learners()
mlr3_learners[class == "classif" & grepl("svm", id),
              .(id, class, mlr3_package, required_packages)]


## ----12-spatial-cv-24-------------------------------------------------------------------------------------------------------------------------------------
lrn_ksvm = mlr3::lrn("classif.ksvm", predict_type = "prob", kernel = "rbfdot")
lrn_ksvm$fallback = lrn("classif.featureless", predict_type = "prob")


## ----12-spatial-cv-25-------------------------------------------------------------------------------------------------------------------------------------
# performance estimation level
perf_level = mlr3::rsmp("repeated_spcv_coords", folds = 5, repeats = 100)


## ----inner-outer, echo=FALSE, fig.cap="Schematic of hyperparameter tuning and performance estimation levels in CV. (Figure was taken from Schratz et al. (2019). Permission to reuse it was kindly granted.)", fig.scap="Schematic of hyperparameter tuning."----
knitr::include_graphics("figures/13_cv.png")


## ----12-spatial-cv-26, eval=FALSE-------------------------------------------------------------------------------------------------------------------------
## # five spatially disjoint partitions
## tune_level = mlr3::rsmp("spcv_coords", folds = 5)
## # use 50 randomly selected hyperparameters
## terminator = mlr3tuning::trm("evals", n_evals = 50)
## tuner = mlr3tuning::tnr("random_search")
## # define the outer limits of the randomly selected hyperparameters
## search_space = paradox::ps(
##   C = paradox::p_dbl(lower = -12, upper = 15, trafo = function(x) 2^x),
##   sigma = paradox::p_dbl(lower = -15, upper = 6, trafo = function(x) 2^x)
## )


## ----12-spatial-cv-27, eval=FALSE-------------------------------------------------------------------------------------------------------------------------
## at_ksvm = mlr3tuning::AutoTuner$new(
##   learner = lrn_ksvm,
##   resampling = tune_level,
##   measure = mlr3::msr("classif.auc"),
##   search_space = search_space,
##   terminator = terminator,
##   tuner = tuner
## )


## ----future, eval=FALSE-----------------------------------------------------------------------------------------------------------------------------------
## library(future)
## # execute the outer loop sequentially and parallelize the inner loop
## future::plan(list("sequential", "multisession"),
##              workers = floor(availableCores() / 2))


## ----12-spatial-cv-30, eval=FALSE-------------------------------------------------------------------------------------------------------------------------
## progressr::with_progress(expr = {
##   rr_spcv_svm = mlr3::resample(task = task,
##                                learner = at_ksvm,
##                                # outer resampling (performance level)
##                                resampling = perf_level,
##                                store_models = FALSE,
##                                encapsulate = "evaluate")
## })
## 
## # stop parallelization
## future:::ClusterRegistry("stop")
## # compute the AUROC values
## score_spcv_svm = rr_spcv_svm$score(measure = mlr3::msr("classif.auc")) %>%
##   # keep only the columns you need
##   .[, .(task_id, learner_id, resampling_id, classif.auc)]


## ----12-spatial-cv-31-------------------------------------------------------------------------------------------------------------------------------------
score = readRDS("extdata/12-bmr_score.rds")
score_spcv_svm = score[learner_id == "classif.ksvm.tuned" & 
                         resampling_id == "repeated_spcv_coords"]


## ----12-spatial-cv-33-------------------------------------------------------------------------------------------------------------------------------------
# final mean AUROC
round(mean(score_spcv_svm$classif.auc), 2)


## ---- echo=FALSE, results='asis'--------------------------------------------------------------------------------------------------------------------------
res = knitr::knit_child('_12-ex.Rmd', quiet = TRUE, options = list(include = FALSE, eval = FALSE))
cat(res, sep = '\n')

