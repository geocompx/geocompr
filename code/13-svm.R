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
library("raster")
library("mlr")
library("sf")
library("tmap")

load("extdata/spatialcv.Rdata")

#**********************************************************
# 2 MLR BUILDING BLOCKS------------------------------------
#**********************************************************

# put coordinates in an additional dataframe
coords = lsl[, c("x", "y")]
data = dplyr::select(lsl, -x, -y)

# create MLR task
task = makeClassifTask(data = data,
                       target = "lslpts", positive = "TRUE",
                       coordinates = coords)
# find out about possible learners for our task
listLearners(task)
configureMlr(on.learner.error = "warn", on.error.dump = TRUE)

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


# Outer resampling loop
outer = makeResampleDesc("SpRepCV", folds = 5, reps = 100)

# Tuning in inner resampling loop
ps = makeParamSet(
  makeNumericParam("C", lower = -12, upper = 15, trafo = function(x) 2^x),
  makeNumericParam("sigma", lower = -15, upper = 6, trafo = function(x) 2^x)
  )

ctrl = makeTuneControlRandom(maxit = 50)
inner = makeResampleDesc("SpCV", iters = 5)

wrapper_ksvm = makeTuneWrapper(lrn_ksvm, resampling = inner, par.set = ps,
                               control = ctrl, show.info = FALSE,
                               measures = mlr::auc)

# Linux
library(parallelMap)
# check the number of cores
parallel::detectCores()
# only parallelize the tuning
parallelStart(mode = "multicore", level = "mlr.tuneParams", cpus = 24,
              mc.set.seed = TRUE) 

set.seed(12345)
system.time(
  {resa_svm_spatial = mlr::resample(wrapper_ksvm, task,
                                   resampling = outer, extract = getTuneResult,
                                   show.info = TRUE, measures = mlr::auc)}
)

parallelStop()
saveRDS(resa_svm_spatial, "extdata/svm_sp_sp_rbf_10it.rda")
print("done")