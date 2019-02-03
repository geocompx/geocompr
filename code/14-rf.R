library(sf)
library(raster)
library(mlr)
library(tidyverse)
library(parallelMap)
library(ranger)  # needed for random forest regression

# construct response-prediction matrix
d = data.frame(id = as.numeric(rownames(scores(rotnmds))),
               sc = scores(rotnmds)[, 1])
d = inner_join(random_points, d,  by = "id")

coords = sf::st_coordinates(d) %>% 
  as.data.frame %>%
  rename(x = X, y = Y)
d = dplyr::select(d, sc, dem) %>%
  st_drop_geometry()
# create task
task = makeRegrTask(data = d, target = "sc", coordinates = coords)

# create learner
lrns = listLearners(task, warn.missing.packages = FALSE) %>%
  dplyr::select(class, name, short.name, package)

lrn = makeLearner(cl = "regr.ranger",
                  predict.type = "response",
                  fix.factors.prediction = TRUE)
# performance level (outer loop)
perf_level = makeResampleDesc(method = "SpRepCV", folds = 5, reps = 100)

# tuning level (inner loop)
# five spatially disjoint partitions
tune_level = makeResampleDesc("SpCV", iters = 5)
# use 50 randomly selected hyperparameters
ctrl = makeTuneControlRandom(maxit = 50)
# define the outer limits of the randomly selected hyperparameters
ps = makeParamSet(
  # as long as we are only using one predictor, we can only use mtry = 1
  makeIntegerParam("mtry", lower = 1, upper = 1),
  makeIntegerParam("num.trees", lower = 10, upper = 10000))

wrapped_lrn_rf = makeTuneWrapper(learner = lrn, 
                                 resampling = tune_level,
                                 par.set = ps,
                                 control = ctrl, 
                                 show.info = TRUE,
                                 measures = mlr::rmse)
configureMlr(on.learner.error = "warn", on.error.dump = TRUE)

library(parallelMap)
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
result = mlr::resample(learner = wrapped_lrn_rf, 
                       task = task,
                       resampling = perf_level,
                       extract = getTuneResult,
                       measures = mlr::rmse)

#**********************************************************
# 2 SPATIAL PREDICTION-------------------------------------
#**********************************************************

lrn_rf = makeLearner(cl = "regr.ranger",
                     predict.type = "response",
                     mtry = 1, num.trees = 3500)
# train model
model_rf = train(lrn_rf, task)
# prediction
new_d = data.frame(dem = values(dem))
pred_rf <- predict(model_rf, newdata = new_d)
pred_r = dem
pred_r[] = pred_rf$data$response
plot(pred_r)

# just for comparison
gam_1 = gam(sc ~ s(dem), data = d)
names(dem) = "dem"
pred = raster::predict(object = dem, model = gam_1)
plot(pred)
