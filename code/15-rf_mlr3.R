library(dplyr)
library(mlr3)
library(mlr3extralearners)
library(mlr3learners)
library(mlr3tuning)
library(mlr3spatiotempcv)
library(qgisprocess)
library(raster)
library(sf)
library(vegan)

data("study_area", "random_points", "comm", "dem", "ndvi", 
     package = "spDataLarge")
alg = "saga:sagawetnessindex"
args = qgis_arguments(alg)
qgis_show_help(alg)

ep = qgis_run_algorithm(alg = "saga:sagawetnessindex",
                        DEM = dem,
                        SLOPE_TYPE = 1, 
                        SLOPE = tempfile(fileext = ".sdat"),
                        AREA = tempfile(fileext = ".sdat"),
                        .quiet = TRUE)
# do not use stack, since it won't read in the data and therefore won't change 
# the origin
ep = lapply(ep[c("AREA", "SLOPE")], `[`) |>
  brick()
# make sure all rasters share the same origin
origin(ep) = origin(dem)
ep = stack(dem, ndvi, ep) 
ep$carea = log10(ep$carea)
ep$carea = log10(ep$carea)
names(ep) = c("dem", "ndvi", "carea", "cslope")
ep$carea = log10(ep$carea)

data(ep, package = "spDataLarge")
random_points[, names(ep)] = raster::extract(ep, random_points)
# presence-absence matrix
pa = decostand(comm, "pa")  # 100 rows (sites), 69 columns (species)
# keep only sites in which at least one species was found
pa = pa[rowSums(pa) != 0, ]  # 84 rows, 69 columns
nmds = readRDS("extdata/14-nmds.rds")

elev = dplyr::filter(random_points, id %in% rownames(pa)) %>% 
  dplyr::pull(dem)
# rotating NMDS in accordance with altitude (proxy for humidity)
rotnmds = MDSrotate(nmds, elev)
# extracting the first axes
sc = scores(rotnmds, choices = 1:2)
# construct response-predictor matrix
# id- and response variable
rp = data.frame(id = as.numeric(rownames(sc)), sc = sc[, 1])
# join the predictors (dem, ndvi and terrain attributes)
rp = inner_join(random_points, rp, by = "id")

# create task
task = TaskRegrST$new(id = "mongon", backend = dplyr::select(rp, -id, -spri),
                      target = "sc")
rp = dplyr::select(rp, -id, -spri)
rp[, c("x", "y")] = st_coordinates(rp)
rp = st_drop_geometry(rp)
task = TaskRegrST$new(id = "mongon", backend = rp, target = "sc",
                    extra_args = list(coordinate_names = c("x", "y")))
lrn_rf = lrn("regr.ranger", predict_type = "response")

search_space = ps(
  mtry = p_int(lower = 1, upper = ncol(task$data()) - 1),
  sample.fraction = p_dbl(lower = 0.2, upper = 0.9),
  min.node.size = p_int(lower = 1, upper = 10)
)
at = AutoTuner$new(
  learner = lrn_rf,
  # spatial partitioning
  resampling = rsmp("spcv_coords", folds = 5),
  # performance measure
  measure = msr("regr.rmse"),
  search_space = search_space,
  # random search with 50 iterations
  terminator = trm("evals", n_evals = 50),
  tuner = tnr("random_search")
)
at$train(task)
at$tuning_result
at$predict(task)
