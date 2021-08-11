# Filename: 11-svm.R (2021-08-11)
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
library(future)
library(mlr3)
library(mlr3extralearners)
library(mlr3learners)
library(mlr3spatiotempcv)
library(mlr3tuning)
library(raster)
library(sf)
library(tmap)

# attach data
data("lsl", "ta", "study_mask", package = "spDataLarge")

#**********************************************************
# 2 mlr building blocks----
#**********************************************************

# 2.1 create mlr3 task====
#**********************************************************
task = TaskClassifST$new(
  id = "ecuador_lsl",
  backend = mlr3::as_data_backend(lsl), target = "lslpts", positive = "TRUE",
  extra_args = list(
    coordinate_names = c("x", "y"),
    coords_as_features = FALSE,
    crs = 32717)
)

# 2.2 Specify learner======================================
#**********************************************************
# construct SVM learner (using ksvm function from the kernlab package)

lrn_ksvm = lrn("classif.ksvm", predict_type = "prob", kernel = "rbfdot")
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
perf_level = rsmp("repeated_spcv_coords", folds = 5, repeats = 100)

# five spatially disjoint partitions
tune_level = rsmp("spcv_coords", folds = 5)
# use 50 randomly selected hyperparameters
terminator = trm("evals", n_evals = 50)
tuner = tnr("random_search")
# define the outer limits of the randomly selected hyperparameters
ps = ps(
  C = p_dbl(lower = -12, upper = 15, trafo = function(x) 2^x),
  sigma = p_dbl(lower = -15, upper = 6, trafo = function(x) 2^x)
)

at_ksvm = AutoTuner$new(
  learner = lrn_ksvm,
  resampling = tune_level,
  measure = msr("classif.auc"),
  search_space = ps,
  terminator = terminator,
  tuner = tuner
)


# 2.4 run the resampling (spatial cv)====
#**********************************************************
# execute the outer loop sequentially and parallelize the inner loop
future::plan(list("sequential", "multisession"), 
             workers = floor(availableCores() / 2))

# run the resampling
set.seed(12345)
# reduce verbosity
lgr::get_logger("mlr3")$set_threshold("warn")
tic()
progressr::with_progress(expr = {
  rr = resample(task = task,
                learner = at_ksvm,
                # outer resampling (performance level)
                resampling = perf_level,
                store_models = TRUE,
                encapsulate = "evaluate")
})
toc()
# stop parallelization
future:::ClusterRegistry("stop")
# save your result, e.g.:
saveRDS(rr, "11-svm_sp_sp_rbf_50it.rds")

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
