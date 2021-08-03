library("mlr3")
# library("mlr3learners")
# library("mlr3proba")
library("sf")
library("mlr3spatiotempcv")
library("mlr3verse")

# use 11-spatial-cv-jm.R as a template
# replace RQGIS code by qgisprocess code

# just use lsl and ta from spDataLarge, do no longer refer to RSAGA since it is
# deprecated and it is also not that interesting for the reader to construct the
# landslide points and the terrain attributes
data("lsl", package = "spDataLarge")
data("ta", package = "spDataLarge")
# data("landslides", package = "RSAGA")
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
