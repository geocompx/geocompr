library("mlr3")
# library("mlr3learners")
# library("mlr3proba")
library("sf")
library("mlr3spatiotempcv")
library("mlr3verse")

# use 11-spatial-cv-jm.R as a template
# replace RQGIS code by qgisprocess code
# use benchmark_grid for comparing nsp with sp cv
# be more consistent with the naming, spatial CV is an umbrella term for many different strategies, here, we are just using the k-means approach
# in the conclusions say that there are other spatial CV methods available -> cross-reference Patrick's upcoming paper

# just use lsl and ta from spDataLarge, do no longer refer to RSAGA since it is
# deprecated and it is also not that interesting for the reader to construct the
# landslide points and the terrain attributes
data("lsl", package = "spDataLarge")
data("ta", package = "spDataLarge")
# data("landslides", package = "RSAGA")

#**********************************************************
# spatial cv with glm----
#**********************************************************

# create 'sf' object
data_sf = sf::st_as_sf(lsl, coords = c("x", "y"), crs = 32717)
tab = table(data_sf$lslpts)
# sel = dplyr::filter(data_sf, slides == "TRUE") |>
#   dplyr::sample_n(tab[["FALSE"]])
# data_sf = dplyr::filter(data_sf, slides == "FALSE") |>
#   dplyr::bind_rows(sel)
# create mlr3 task using an sf object
task = TaskClassifST$new("ecuador_sf",
                         backend = data_sf, target = "lslpts", positive = "TRUE"
)

# create mlr3 task using a dataframe with xy-columns
task = TaskClassifST$new(
  id = "ecuador", backend = mlr3::as_data_backend(lsl),
  target = "lslpts", positive = "TRUE",
  extra_args = list(
    coordinate_names = c("x", "y"),
    coords_as_features = FALSE,
    crs = 32717)
)

# listLearners(task, warn.missing.packages = FALSE) %>%
#   dplyr::select(class, name, short.name, package) %>%
#   head()
as.data.table(mlr_learners)

# lrn = makeLearner(cl = "classif.binomial",
#                   link = "logit",
#                   predict.type = "prob",
#                   fix.factors.prediction = TRUE)

learner = lrn("classif.log_reg", predict_type = "prob")
learner$help()
?mlr3learners::LearnerClassifLogReg

# perf_level = makeResampleDesc(method = "SpRepCV", folds = 5, reps = 100)
perf_level = rsmp("repeated_spcv_coords", folds = 5, repeats = 100)

# set.seed(012348)
# sp_cv = mlr::resample(learner = lrn, task = task,
#                       resampling = perf_level, 
#                       measures = mlr::auc)

rr = resample(task = task,
              learner = learner,
              resampling = perf_level,
              store_models = TRUE)
rr$aggregate(measures = msr("classif.auc"))

#**********************************************************
# hyperparameter tuning ksvm----
#**********************************************************

# filter(lrns, grepl("svm", class)) %>% 
#   dplyr::select(class, name, short.name, package)
install.packages("kernlab")
remotes::install_github("mlr-org/mlr3extralearners")
# make many more learners available
library("mlr3extralearners")
mlr_learners |>
  as.data.table() |>
  dplyr::filter(grepl("svm", key))

lrn_ksvm = lrn("classif.ksvm", predict_type = "prob", kernel = "rbfdot")
lrn_ksvm$help()
# available hyperparameters
lrn_ksvm$param_set

# define the search space
# ps = ParamSet$new(
#   params = list(
#     # if you use hyperpars from different "instances", here from the filter
#     # and from the learner, you have to use the . notation to refer to a
#     # specific hyperparameter, solution found here:
#     # https://mlr3book.mlr-org.com/pipe-modeling.html
#     ParamDbl$new(id = "classif.ksvm.C", lower = -12, upper = 15),
#     ParamDbl$new(id = "classif.ksvm.sigma", lower = -15, upper = 6)
#   )
# )

# define the outer limits of the randomly selected hyperparameters
ps = ps(
  C = p_dbl(lower = -12, upper = 15, trafo = function(x) 2^x),
  sigma = p_dbl(lower = -15, upper = 6, trafo = function(x) 2^x)
)

# resampling_coords = rsmp("spcv_coords", folds = 5)$instantiate(task)
# # install.packages(c("patchwork", "ggtext"))
# autoplot(resampling_coords,
#          size = 1.5, fold_id = 1, task = task) +
#   ggplot2::scale_y_continuous(breaks = seq(-3.97, -4, -0.01)) +
#   ggplot2::scale_x_continuous(breaks = seq(-79.06, -79.08, -0.01))

# nested resampling
at_ksvm = AutoTuner$new(
  learner = lrn_ksvm,
  # five spatially disjoint partitions (inner resampling, tuning level)
  resampling = rsmp("spcv_coords", folds = 5),
  measure = msr("classif.auc"),
  search_space = ps,
  # use 50 randomly selected hyperparameters
  terminator = trm("evals", n_evals = 50),
  tuner = tnr("random_search")
)

# reduce verbosity
lgr::get_logger("mlr3")$set_threshold("warn")
# future::plan("multiprocess", workers = 4)
# this will fit 125,500 models, so this might take a while
progressr::with_progress(expr = {
  rr = resample(task = task,
                learner = at_ksvm,
                # outer resampling (performance level)
                resampling = rsmp("repeated_spcv_coords", folds = 5,
                                  repeats = 100),
                store_models = TRUE)
})

# Advantages mlr3
# - create benchmark grid, i.e., combine all tasks, learners and resampling
# strategies which you would like to compare
# - pipelines (data transformations)
# - fallback learners -> making sure that process is not stopped just because of one failed model, etc.)
# - feature selection
# - filtering
# - autoplot
# - ...