## ----11-spatial-cv-1, message=FALSE--------------------------------------
library(sf)
library(raster)
library(mlr)
library(dplyr)
library(parallelMap)

## ----11-spatial-cv-2-----------------------------------------------------
data("landslides", package = "RSAGA")

## ----11-spatial-cv-3, eval=FALSE-----------------------------------------
## # select non-landslide points
## non_pts = filter(landslides, lslpts == FALSE)
## # select landslide points
## lsl_pts = filter(landslides, lslpts == TRUE)
## # randomly select 175 non-landslide points
## set.seed(11042018)
## non_pts_sub = sample_n(non_pts, size = nrow(lsl_pts))
## # create smaller landslide dataset (lsl)
## lsl = bind_rows(non_pts_sub, lsl_pts)

## ----11-spatial-cv-4, eval=FALSE-----------------------------------------
## dem = raster(
##   dem$data,
##   crs = dem$header$proj4string,
##   xmn = dem$header$xllcorner,
##   xmx = dem$header$xllcorner + dem$header$ncols * dem$header$cellsize,
##   ymn = dem$header$yllcorner,
##   ymx = dem$header$yllcorner + dem$header$nrows * dem$header$cellsize
##   )

## ----lsl-map, echo=FALSE, fig.cap="Landslide initiation points (red) and points unaffected by landsliding (blue) in Southern Ecuador.", fig.scap="Landslide initiation points."----
library(tmap)
data("lsl", package = "spDataLarge")
data("ta", package = "spDataLarge")
lsl_sf = st_as_sf(lsl, coords = c("x", "y"), crs = 32717)
hs = hillShade(ta$slope * pi / 180, terrain(ta$elev, opt = "aspect"))
rect = tmaptools::bb_poly(hs)
bbx = tmaptools::bb(hs, xlim = c(-0.02, 1), ylim = c(-0.02, 1), relative = TRUE)

tm_shape(hs, bbox = bbx) +
	tm_grid(col = "black", n.x = 1, n.y = 1, labels.inside.frame = FALSE,
	        labels.rot = c(0, 90)) +
	tm_raster(palette = gray(0:100 / 100), n = 100, legend.show = FALSE) +
	tm_shape(ta$elev) +
	tm_raster(alpha = 0.5, palette = terrain.colors(10), legend.show = FALSE) +
	tm_shape(lsl_sf) + 
	tm_bubbles("lslpts", size = 0.2, palette = "-RdYlBu", title.col = "Landslide: ") +
#   tm_shape(sam) +
#   tm_bubbles(border.col = "gold", border.lwd = 2, alpha = 0, size = 0.5) +
  qtm(rect, fill = NULL) +
	tm_layout(outer.margins = c(0.04, 0.04, 0.02, 0.02), frame = FALSE) +
  tm_legend(bg.color = "white")

## ----11-spatial-cv-5-----------------------------------------------------
# attach landslide points with terrain attributes
data("lsl", package = "spDataLarge")
# attach terrain attribute raster stack
data("ta", package = "spDataLarge")

## ----lslsummary, echo=FALSE, warning=FALSE-------------------------------
lsl_table = lsl %>%
  mutate_at(vars(-one_of("x", "y", "lslpts")), funs(signif(., 2))) %>%
  head(3)
knitr::kable(lsl_table, caption = "Structure of the lsl dataset.",
             caption.short = "`lsl` dataset.", booktabs = TRUE) %>%
  kableExtra::kable_styling(latex_options="scale_down")

## ----11-spatial-cv-6-----------------------------------------------------
fit = glm(lslpts ~ slope + cplan + cprof + elev + log10_carea,
          family = binomial(),
          data = lsl)

## ----11-spatial-cv-7-----------------------------------------------------
class(fit)
fit

## ----11-spatial-cv-8-----------------------------------------------------
pred_glm = predict(object = fit, type = "response")
head(pred_glm)

## ----11-spatial-cv-9-----------------------------------------------------
# making the prediction
pred = raster::predict(ta, model = fit, type = "response")

## ----lsl-susc, echo=FALSE, fig.cap="Spatial prediction of landslide susceptibility using a GLM.", fig.scap = "Spatial prediction of landslide susceptibility.", warning=FALSE----
# attach study mask for the natural part of the study area
data("study_mask", package = "spDataLarge")
# white raster to only plot the axis ticks, otherwise gridlines would be visible
tm_shape(hs, bbox = bbx) +
  tm_grid(col = "black", n.x = 1, n.y = 1, labels.inside.frame = FALSE,
          labels.rot = c(0, 90)) +
  tm_raster(palette = "white", legend.show = FALSE) +
  # hillshade
  tm_shape(mask(hs, study_mask), bbox = bbx) +
	tm_raster(palette = gray(0:100 / 100), n = 100,
	          legend.show = FALSE) +
	# prediction raster
  tm_shape(mask(pred, study_area)) +
	tm_raster(alpha = 0.5, palette = "Reds", n = 6, legend.show = TRUE,
	          title = "Susceptibility") +
	# rectangle and outer margins
  qtm(rect, fill = NULL) +
	tm_layout(outer.margins = c(0.04, 0.04, 0.02, 0.02), frame = FALSE,
	          legend.position = c("left", "bottom"),
	          legend.title.size = 0.9)

## ----11-spatial-cv-10, message=FALSE-------------------------------------
pROC::auc(pROC::roc(lsl$lslpts, fitted(fit)))

## ----partitioning, fig.cap="Spatial visualization of selected test and training observations for cross-validation of one repetition. Random (upper row) and spatial partitioning (lower row).", echo=FALSE, fig.scap="Spatial visualization of selected test and training observations."----
knitr::include_graphics("figures/13_partitioning.png")

## ----building-blocks, echo=FALSE, fig.height=4, fig.width=4, fig.cap="Basic building blocks of the mlr package. Source: http://bit.ly/2tcb2b7. (Permission to reuse this figure was kindly granted.)", fig.scap="Basic building blocks of the mlr package."----
knitr::include_graphics("figures/13_ml_abstraction_crop.png")

## ----11-spatial-cv-11----------------------------------------------------
library(mlr)
# coordinates needed for the spatial partitioning
coords = lsl[, c("x", "y")]
# select response and predictors to use in the modeling
data = dplyr::select(lsl, -x, -y)
# create task
task = makeClassifTask(data = data, target = "lslpts",
                       positive = "TRUE", coordinates = coords)

## ----11-spatial-cv-12, eval=FALSE----------------------------------------
## listLearners(task, warn.missing.packages = FALSE) %>%
##   dplyr::select(class, name, short.name, package) %>%
##   head

## ----lrns, echo=FALSE----------------------------------------------------
lrns_df = 
  listLearners(task, warn.missing.packages = FALSE) %>%
  dplyr::select(Class = class, Name = name, `Short name` = short.name, Package = package) %>% 
  head()
knitr::kable(lrns_df, 
             caption = paste("Sample of available learners for binomial", 
                             "tasks in the mlr package."), 
             caption.short = "Sample of available learners.", booktabs = TRUE)

## ----11-spatial-cv-13----------------------------------------------------
lrn = makeLearner(cl = "classif.binomial",
                  link = "logit",
                  predict.type = "prob",
                  fix.factors.prediction = TRUE)

## ----11-spatial-cv-14, eval=FALSE----------------------------------------
## getLearnerPackages(lrn)
## helpLearner(lrn)

## ----11-spatial-cv-15----------------------------------------------------
mod = train(learner = lrn, task = task)
mlr_fit = getLearnerModel(mod)

## ----11-spatial-cv-16, eval=FALSE, echo=FALSE----------------------------
## getTaskFormula(task)
## getTaskData(task)
## getLearnerModel(mod)
## mod$learner.model

## ----11-spatial-cv-17----------------------------------------------------
fit = glm(lslpts ~ ., family = binomial(link = "logit"), data = data)
identical(fit$coefficients, mlr_fit$coefficients)

## ----11-spatial-cv-18----------------------------------------------------
perf_level = makeResampleDesc(method = "SpRepCV", folds = 5, reps = 100)

## ----11-spatial-cv-19, eval=FALSE----------------------------------------
## set.seed(012348)
## sp_cv = mlr::resample(learner = lrn, task = task,
##                       resampling = perf_level,
##                       measures = mlr::auc)

## ----11-spatial-cv-20, eval=FALSE, echo=FALSE----------------------------
## set.seed(012348)
## sp_cv = mlr::resample(learner = lrn, task = task,
##                       resampling = perf_level,
##                       measures = mlr::auc)

## ----11-spatial-cv-21, echo=FALSE----------------------------------------
sp_cv = readRDS("extdata/sp_cv.rds")
conv_cv = readRDS("extdata/conv_cv.rds")

## ----11-spatial-cv-22----------------------------------------------------
# summary statistics of the 500 models
summary(sp_cv$measures.test$auc)
# mean AUROC of the 500 models
mean(sp_cv$measures.test$auc)

## ----boxplot-cv, echo=FALSE, fig.width=6, fig.height=9, fig.cap="Boxplot showing the difference in AUROC values between spatial and conventional 100-repeated 5-fold cross-validation.", fig.scap="Boxplot showing AUROC values."----
# Visualization of non-spatial overfitting
boxplot(sp_cv$measures.test$auc,
        conv_cv$measures.test$auc,
        col = c("lightblue2", "mistyrose2"),
        names = c("spatial CV", "conventional CV"), 
        ylab = "AUROC")

## ----11-spatial-cv-23, eval=FALSE----------------------------------------
## lrns = listLearners(task, warn.missing.packages = FALSE)
## filter(lrns, grepl("svm", class)) %>%
##   dplyr::select(class, name, short.name, package)
## #>            class                                 name short.name package
## #> 6   classif.ksvm              Support Vector Machines       ksvm kernlab
## #> 9  classif.lssvm Least Squares Support Vector Machine      lssvm kernlab
## #> 17   classif.svm     Support Vector Machines (libsvm)        svm   e1071

## ----11-spatial-cv-24, eval=FALSE----------------------------------------
## lrn_ksvm = makeLearner("classif.ksvm",
##                         predict.type = "prob",
##                         kernel = "rbfdot")

## ----11-spatial-cv-25, eval=FALSE----------------------------------------
## # performance estimation level
## perf_level = makeResampleDesc(method = "SpRepCV", folds = 5, reps = 100)

## ----inner-outer, echo=FALSE, fig.cap="Schematic of hyperparameter tuning and performance estimation levels in CV. (Figure was taken from Schratz et al. (2018). Permission to reuse it  was kindly granted.)", fig.scap="Schematic of hyperparameter tuning."----
knitr::include_graphics("figures/13_cv.png")

## ----11-spatial-cv-26, eval=FALSE----------------------------------------
## # five spatially disjoint partitions
## tune_level = makeResampleDesc("SpCV", iters = 5)
## # use 50 randomly selected hyperparameters
## ctrl = makeTuneControlRandom(maxit = 50)
## # define the outer limits of the randomly selected hyperparameters
## ps = makeParamSet(
##   makeNumericParam("C", lower = -12, upper = 15, trafo = function(x) 2^x),
##   makeNumericParam("sigma", lower = -15, upper = 6, trafo = function(x) 2^x)
##   )

## ----11-spatial-cv-27, eval=FALSE----------------------------------------
## wrapped_lrn_ksvm = makeTuneWrapper(learner = lrn_ksvm,
##                                    resampling = tune_level,
##                                    par.set = ps,
##                                    control = ctrl,
##                                    show.info = TRUE,
##                                    measures = mlr::auc)

## ----11-spatial-cv-28, eval=FALSE----------------------------------------
## configureMlr(on.learner.error = "warn", on.error.dump = TRUE)

## ----11-spatial-cv-29, eval=FALSE----------------------------------------
## library(parallelMap)
## if (Sys.info()["sysname"] %in% c("Linux", "Darwin")) {
## parallelStart(mode = "multicore",
##               # parallelize the hyperparameter tuning level
##               level = "mlr.tuneParams",
##               # just use half of the available cores
##               cpus = round(parallel::detectCores() / 2),
##               mc.set.seed = TRUE)
## }
## 
## if (Sys.info()["sysname"] == "Windows") {
##   parallelStartSocket(level = "mlr.tuneParams",
##                       cpus =  round(parallel::detectCores() / 2))
## }

## ----11-spatial-cv-30, eval=FALSE----------------------------------------
## set.seed(12345)
## result = mlr::resample(learner = wrapped_lrn_ksvm,
##                        task = task,
##                        resampling = perf_level,
##                        extract = getTuneResult,
##                        measures = mlr::auc)
## # stop parallelization
## parallelStop()
## # save your result, e.g.:
## # saveRDS(result, "svm_sp_sp_rbf_50it.rds")

## ----11-spatial-cv-31----------------------------------------------------
result = readRDS("extdata/spatial_cv_result.rds")

## ----11-spatial-cv-32----------------------------------------------------
# Exploring the results
# runtime in minutes
round(result$runtime / 60, 2)

## ----11-spatial-cv-33----------------------------------------------------
# final aggregated AUROC 
result$aggr
# same as
mean(result$measures.test$auc)

## ----11-spatial-cv-34----------------------------------------------------
# winning hyperparameters of tuning step, 
# i.e. the best combination out of 50 * 5 models
result$extract[[1]]$x

## ----11-spatial-cv-35----------------------------------------------------
result$measures.test[1, ]

