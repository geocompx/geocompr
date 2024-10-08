## ----15-ex-e0, message=FALSE, warning=FALSE----------------------------------------------------------------------
library(sf)
library(terra)
library(data.table)
library(dplyr)
library(future)
library(ggplot2)
library(lgr)
library(mlr3)
library(mlr3learners)
library(mlr3spatiotempcv)
library(mlr3tuning)
library(mlr3viz)
library(progressr)
library(qgisprocess)
library(tictoc)
library(vegan)


## ----15-ex-e1, message=FALSE-------------------------------------------------------------------------------------
data("comm", package = "spDataLarge")
pa = vegan::decostand(comm, "pa")
pa = pa[rowSums(pa) != 0, ]
comm = comm[rowSums(comm) != 0, ]
set.seed(25072018)
nmds_pa = vegan::metaMDS(comm = pa, k = 4, try = 500)
nmds_per = vegan::metaMDS(comm = comm, k = 4, try = 500)
nmds_pa$stress
nmds_per$stress


## The NMDS using the presence-absence values yields a better result (`nmds_pa$stress`) than the one using percentage data (`nmds_per$stress`).

## This might seem surprising at first sight.

## On the other hand, the percentage matrix contains both more information and more noise.

## Another aspect is how the data was collected.

## Imagine a botanist in the field.

## It might seem feasible to differentiate between a plant which has a cover of 5% and another species that covers 10%.

## However, what about a herbal species that was only detected three times and consequently has a very tiny cover, e.g., 0.0001%.

## Maybe another herbal species was detected 6 times, is its cover then 0.0002%?

## The point here is that percentage data as specified during a field campaign might reflect a precision that the data does not have.

## This again introduces noise which in turn will worsen the ordination result.

## Still, it is a valuable information if one species had a higher frequency or coverage in one plot than another compared to just presence-absence data.

## One compromise would be to use a categorical scale such as the Londo scale.


## ----15-ex-e2----------------------------------------------------------------------------------------------------
# first compute the terrain attributes we have also used in the chapter
library(dplyr)
library(terra)
library(qgisprocess)
library(vegan)
data("comm", "random_points", package = "spDataLarge")
dem = terra::rast(system.file("raster/dem.tif", package = "spDataLarge"))
ndvi = terra::rast(system.file("raster/ndvi.tif", package = "spDataLarge"))

# use presence-absence matrix and get rid of empty
pa = vegan::decostand(comm, "pa")
pa = pa[rowSums(pa) != 0, ]

# compute environmental predictors (ep) catchment slope and catchment area
ep = qgisprocess::qgis_run_algorithm(
  alg = "saga:sagawetnessindex",
  DEM = dem,
  SLOPE_TYPE = 1,
  SLOPE = tempfile(fileext = ".sdat"),
  AREA = tempfile(fileext = ".sdat"),
  .quiet = TRUE)
# read in catchment area and catchment slope
ep = ep[c("AREA", "SLOPE")] |>
  unlist() |>
  terra::rast()
# assign proper names 
names(ep) = c("carea", "cslope")
# make sure all rasters share the same origin
origin(ep) = origin(dem)
# add dem and ndvi to the multi-layer SpatRaster object
ep = c(dem, ndvi, ep) 
ep$carea = log10(ep$carea)

# compute the curvatures
qgis_show_help("grass7:r.slope.aspect")
curvs = qgis_run_algorithm(
  "grass7:r.slope.aspect",
  elevation = dem,
  .quiet = TRUE)
# adding curvatures to ep
curv_nms = c("pcurvature", "tcurvature")
curvs = curvs[curv_nms] |>
  unlist() |>
  terra::rast()
curvs = terra::app(curvs, as.numeric)
names(curvs) = curv_nms
ep = c(ep, curvs)
random_points[, names(ep)] = 
  # terra::extract adds an ID column, we don't need
  terra::extract(ep, random_points) |>
  select(-ID)
elev = dplyr::filter(random_points, id %in% rownames(pa)) %>% 
  dplyr::pull(dem)
# rotating NMDS in accordance with altitude (proxy for humidity)
rotnmds = MDSrotate(nmds_pa, elev)
# extracting the first two axes
sc = vegan::scores(rotnmds, choices = 1:2, display = "sites")
rp = data.frame(id = as.numeric(rownames(sc)),
                sc = sc[, 1])
# join the predictors (dem, ndvi and terrain attributes)
rp = dplyr::inner_join(random_points, rp, by = "id")
# saveRDS(rp, "extdata/15-rp_exercises.rds")


## ----15-ex-e3, message=FALSE-------------------------------------------------------------------------------------
library(dplyr)
library(future)
library(mlr3)
library(mlr3spatiotempcv)
library(mlr3learners)
library(mlr3viz)
library(paradox)
library(ranger)

# in case you have not run the previous exercises, run:
# rp = readRDS("extdata/15-rp_exercises.rds")

# define the task
task = mlr3spatiotempcv::as_task_regr_st(
  select(rp, -id, -spri),
  target = "sc", 
  id = "mongon")

# define the learners
mlr3::mlr_learners
# linear model
lrn_lm = mlr3::lrn("regr.lm", predict_type = "response")
# random forest
lrn_rf = mlr3::lrn("regr.ranger", predict_type = "response")
# now define the AutoTuner of the random forest
search_space = paradox::ps(
  mtry = paradox::p_int(lower = 1, upper = ncol(task$data()) - 1),
  sample.fraction = paradox::p_dbl(lower = 0.2, upper = 0.9),
  min.node.size = paradox::p_int(lower = 1, upper = 10)
)
at_rf = mlr3tuning::AutoTuner$new(
  learner = lrn_rf,
  # spatial partitioning
  resampling = mlr3::rsmp("spcv_coords", folds = 5),
  # performance measure
  measure = mlr3::msr("regr.rmse"),
  search_space = search_space,
  # random search with 50 iterations
  terminator = mlr3tuning::trm("evals", n_evals = 50),
  tuner = mlr3tuning::tnr("random_search")
)
# define the resampling strategy
rsmp_sp = mlr3::rsmp("repeated_spcv_coords", folds = 5, repeats = 100)

# create the benchmark design
design_grid = mlr3::benchmark_grid(
  tasks = task,
  learners = list(lrn_lm, at_rf),
  resamplings = rsmp_sp)
print(design_grid)
# execute the outer loop sequentially and parallelize the inner loop
future::plan(list("sequential", "multisession"), 
             workers = floor(future::availableCores() / 2))
set.seed(10112022)
# reduce verbosity
lgr::get_logger("mlr3")$set_threshold("warn")
lgr::get_logger("bbotk")$set_threshold("info")
# BE CAREFUL: Running the benchmark might take quite some time
# therefore, we have stored the result of the benchmarking in
# extdata/15-bmr-exercises.rds (see below)
tictoc::tic()
progressr::with_progress(expr = {
  bmr = mlr3::benchmark(
    design = design_grid,
    # New argument `encapsulate` for `resample()` and `benchmark()` to
    # conveniently enable encapsulation and also set the fallback learner to the
    # respective featureless learner. This is simply for convenience, configuring
    # each learner individually is still possible and allows a more fine-grained
    # control
    encapsulate = "evaluate",
    store_backends = FALSE,
    store_models = FALSE)
})
tictoc::toc()

# stop parallelization
future:::ClusterRegistry("stop")
# we have saved the result as follows
# saveRDS(bmr, file = "extdata/15-bmr_exercises.rds")
# READ IT IN in in case you don't want to run the spatial CV yourself as it is computationally
# demanding
# bmr = readRDS("extdata/15-bmr_exercises.rds")

# mean RMSE
bmr$aggregate(measures = msr("regr.rmse"))
# or computed manually
agg = bmr$aggregate(measures = msr("regr.rmse"))

# lm performs slightly better when considering the mean rmse
purrr::map(agg$resample_result, ~ mean(.$score(msr("regr.rmse"))$regr.rmse))
# however, looking at the median, the random forest performs slightly better
purrr::map(agg$resample_result, ~ median(.$score(msr("regr.rmse"))$regr.rmse))

# make a boxplot (when using autoplot, mlr3viz needs to be attached!)
library(mlr3viz)
autoplot(bmr, measure = msr("regr.rmse"))

# or doing it "manually"
# extract the AUROC values and put them into one data.table
d = purrr::map_dfr(agg$resample_result, ~ .$score(msr("regr.rmse")))
# create the boxplots
library(ggplot2)
ggplot(data = d, mapping = aes(x = learner_id, y = regr.rmse)) +
  geom_boxplot(fill = c("lightblue2", "mistyrose2")) +
  theme_bw() +
  labs(y = "RMSE", x = "model")


## In fact, `lm` performs at least as good the random forest model, and thus should be preferred since it is much easier to understand and computationally much less demanding (no need for fitting hyperparameters).

## But keep in mind that the used dataset is small in terms of observations and predictors and that the response-predictor relationships are also relatively linear.

