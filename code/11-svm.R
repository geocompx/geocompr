# Filename: 13-svm.R (2018-03-22)
#
# TO DO: Spatial cross-validation of SVM
#
# Author(s): Jannes Muenchow, Patrick Schratz
#
#**********************************************************
# CONTENTS-------------------------------------------------
#**********************************************************
#
# 1. ATTACH PACKAGES AND DATA
# 2. MLR BUILDING BLOCKS
#
#**********************************************************
# 1 ATTACH PACKAGES AND DATA-------------------------------
#**********************************************************

# attach packages
library(raster)
library(mlr)
library(sf)
library(tmap)
library(parallelMap)

# attach data
data("lsl", package = "spDataLarge")

#**********************************************************
# 2 MLR BUILDING BLOCKS------------------------------------
#**********************************************************

# put coordinates in an additional data frame
coords = lsl[, c("x", "y")]
data = dplyr::select(lsl, -x, -y)

# 2.1 Create MLR task======================================
#**********************************************************
task = makeClassifTask(data = data,
                       target = "lslpts", 
                       positive = "TRUE",
                       coordinates = coords)
# find out about possible learners for our task
listLearners(task)

# 2.2 Specify learner======================================
#**********************************************************
# construct SVM learner (using ksvm function from the kernlab package)
lrn_ksvm = makeLearner("classif.ksvm",
                        predict.type = "prob",
                        kernel = "rbfdot")
getLearnerPackages(lrn_ksvm)
helpLearner(lrn_ksvm)
# rbfdot Radial Basis kernel "Gaussian" 
# the list of hyper-parameters (kernel parameters). This is a list which
# contains the parameters to be used with the kernel function. For valid
# parameters for existing kernels are :
# sigma inverse kernel width for the Radial Basis kernel function "rbfdot" and
# the Laplacian kernel "laplacedot".
# C cost of constraints violation (default: 1) this is the ‘C’-constant of the
# regularization term in the Lagrange formulation.

# 2.3 Specify resampling strategy==========================
#**********************************************************
# performance level (outer resampling loop)
perf_level = makeResampleDesc("SpRepCV", folds = 5, reps = 100)

# tuning level (inner reseampling loop)
tune_level = makeResampleDesc("SpCV", iters = 5)
# hyperparameter tuning in the inner resampling loop
# use 50 randomly selected hyperparameter combinations...
ctrl = makeTuneControlRandom(maxit = 50)
# ... and restrict them to the following tuning space
ps = makeParamSet(
  makeNumericParam("C", lower = -12, upper = 15, trafo = function(x) 2^x),
  makeNumericParam("sigma", lower = -15, upper = 6, trafo = function(x) 2^x)
  )

wrapper_ksvm = makeTuneWrapper(learner = lrn_ksvm,
                               resampling = tune_level,
                               par.set = ps,
                               control = ctrl,
                               show.info = FALSE,
                               measures = mlr::auc)

# 2.4 Run the resampling (spatial cv)======================
#**********************************************************
# before starting the parallelization, make sure that failed models will be 
# accessible after the processing (and does not lead to the interruption of the 
# cv)
configureMlr(on.learner.error = "warn", on.error.dump = TRUE)
# initialize the parallelization
if (Sys.info()["sysname"] %in% c("Linux, Darwin")) {
  parallelStart(mode = "multicore", 
                # parallelize the hyperparameter tuning level
                level = "mlr.tuneParams", 
                # just use half of the available cores
                cpus = round(parallel::detectCores() / 2),
                mc.set.seed = TRUE)
}

if (Sys.info()["sysname"] == "Windows") {
  parallelStartSocket(level = "mlr.tuneParams",
                      cpus =  round(parallel::detectCores() / 2))
}

# run the resampling
set.seed(12345)
resa_svm_spatial = mlr::resample(learner = wrapper_ksvm, 
                                 task = task,
                                 resampling = perf_level,
                                 extract = getTuneResult,
                                 show.info = TRUE,
                                 measures = mlr::auc)

# Aggregated Result: auc.test.mean=0.7583375
parallelStop()
# save your result
saveRDS(resa_svm_spatial, "extdata/spatial_cv_result.rds")

# Exploring the results
# run time in minutes
resa_svm_spatial$runtime / 60
# final aggregated AUROC 
resa_svm_spatial$aggr
# same as
mean(resa_svm_spatial$measures.test$auc)
# used hyperparameters for the outer fold, i.e. the best combination out of 50 *
# 5 models
resa_svm_spatial$extract[[1]]
# and here one can observe that the AUC of the tuning data is usually higher
# than for the model on the outer fold
resa_svm_spatial$measures.test[1, ]
