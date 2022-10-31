# Filename: 15-rf_mlr3.R (2022-04-14)

# TO DO: use spatially cross-validated tuned hyperparameters to make a spatial prediction of the floristic composition of the Mount Mongón

# Author(s): jannes.muenchow

#**********************************************************
# CONTENTS----
#**********************************************************

# 1 attach packages and data
# 2 preprocessing
# 3 modeling

#**********************************************************
# 1 attach packages and data----
#**********************************************************

# attach packages
library(dplyr)
library(mlr3)
library(mlr3extralearners)
library(mlr3learners)
library(mlr3tuning)
library(mlr3spatiotempcv)
library(qgisprocess)
library(raster)
library(terra)
library(sf)
library(vegan)

# attach data
data("study_area", "random_points", "comm", package = "spDataLarge")
dem = terra::rast(system.file("raster/dem.tif", package = "spDataLarge"))
ndvi = terra::rast(system.file("raster/ndvi.tif", package = "spDataLarge"))

#**********************************************************
# 2 preprocessing----
#**********************************************************

alg = "saga:sagawetnessindex"
args = qgis_arguments(alg)
qgis_show_help(alg)

ep = qgis_run_algorithm(alg = "saga:sagawetnessindex",
                        DEM = dem,
                        SLOPE_TYPE = 1, 
                        SLOPE = tempfile(fileext = ".sdat"),
                        AREA = tempfile(fileext = ".sdat"),
                        .quiet = TRUE)
# read in catchment area and catchment slope
ep = ep[c("AREA", "SLOPE")] |>
  unlist() |>
  terra::rast()
names(ep) = c("carea", "cslope")
# make sure all rasters share the same origin
origin(ep) = origin(dem)
ep = c(dem, ndvi, ep) 
ep$carea = log10(ep$carea)
random_points[, names(ep)] = 
  # first column is an ID column we don't need
  terra::extract(ep, terra::vect(random_points))[, -1]

# presence-absence matrix
pa = decostand(comm, "pa")  # 100 rows (sites), 69 columns (species)
# keep only sites in which at least one species was found
pa = pa[rowSums(pa) != 0, ]  # 84 rows, 69 columns
nmds = readRDS("extdata/15-nmds.rds")

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

#**********************************************************
# 3 modeling----
#**********************************************************

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

# predict to new data
pred_terra = terra::predict(ep, model = at)
names(pred_terra) = "pred"

# doing it "manually"
newdata = as.data.frame(as.matrix(ep))
colSums(is.na(newdata))  # 0 NAs
# but assuming there were results in a more generic approach
ind = rowSums(is.na(newdata)) == 0
tmp = at$predict_newdata(newdata = newdata[ind, ], task = task)
newdata[ind, "pred"] = as.data.table(tmp)[["response"]]
pred_2 = pred_terra
pred_2[] = newdata$pred
# same as
# values(pred_2) = newdata$pred
# all.equal(pred_terra, pred_2)  # does not work, don't know why
identical(values(pred_terra), values(pred_2))  # TRUE
plot(pred_terra - pred_2)  # just 0s, perfect
plot(c(pred, pred_2))