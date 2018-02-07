# Filename: spatial_cv.R (2018-02-06)
#
# TO DO: Introducing spatial cross-validation with the help of mlr
#
# Author(s): Jannes Muenchow
#
#**********************************************************
# CONTENTS-------------------------------------------------
#**********************************************************
#
# 1. ATTACH PACKAGES AND DATA
# 2. DATA PREPROCESSING
# 3. TERRAIN ATTRIBUTES
# 4. MODELING 
# 5. SPATIAL PREDICTION
#
#**********************************************************
# 1 ATTACH PACKAGES AND DATA-------------------------------
#**********************************************************

# attach packages
library(RSAGA)
library(RQGIS)
library(sf)
library(mlr)
library(raster)

# attach data
data("landslides", package = "RSAGA")

#**********************************************************
# 2 DATA PREPROCESSING-------------------------------------
#**********************************************************

# landslide points
non = landslides[landslides$lslpts == FALSE, ]
ind = sample(1:nrow(non), nrow(landslides[landslides$lslpts == TRUE, ]) + 75)
lsl = rbind(non[ind, ], landslides[landslides$lslpts == TRUE, ])
# tmp = st_as_sf(landslides, coords = c("x", "y"), crs = 32717)

# digital elevation model
dem = 
  raster(dem$data, 
         crs = "+proj=utm +zone=17 +south +datum=WGS84 +units=m +no_defs",
         xmn = dem$header$xllcorner, 
         xmx = dem$header$xllcorner + dem$header$ncols * dem$header$cellsize,
         ymn = dem$header$yllcorner,
         ymx = dem$header$yllcorner + dem$header$nrows * dem$header$cellsize)
# plot(dem)
# plot(dplyr::filter(lsl, lslpts == TRUE), add = TRUE, pch = 16)

# # compare with SAGA version
# dem$header
# env = rsaga.env(path = "C:/OSGeo4W64/apps/saga")
# # Write the DEM to a SAGA grid:
# write.sgrd(data = dem, file = "dem", header = dem$header, env = env)
# tmp_2 = raster("dem.sdat")
# # header is the same, but some numeric/decimal place inconsistencies
# all.equal(tmp, tmp_2)
# tmp - tmp_2

#**********************************************************
# 3 COMPUTING TERRAIN ATTRIBUTES---------------------------
#**********************************************************

# slope, aspect, curvatures
find_algorithms("curvature")
alg = "saga:slopeaspectcurvature"
get_usage(alg)
# terrain attributes (ta)
out = run_qgis(alg, ELEVATION = dem, METHOD = 6, UNIT_SLOPE = "degree",
               UNIT_ASPECT = "degree",
               ASPECT = file.path(tempdir(), "aspect.tif"),
               SLOPE = file.path(tempdir(), "slope.tif"),
               C_PLAN = file.path(tempdir(), "cplan.tif"),
               C_PROF = file.path(tempdir(), "cprof.tif"),
               load_output = TRUE)
# hillshade (needs radians)
# hs = hillShade(out$SLOPE * pi / 180, out$ASPECT * pi / 180, 40, 270)
# plot(hs, col = gray(seq(0, 1, length.out = 100)), legend = FALSE)
# plot(dem, add = TRUE, alpha = 0.6)
# plot(dplyr::filter(lsl, lslpts == TRUE), add = TRUE, pch = 16)


# use brick because then the layers will be in memory and not on disk
ta = brick(out[names(out) != "ASPECT"])
names(ta) = c("slope", "cplan", "cprof")
# catchment area
find_algorithms("[Cc]atchment")
alg = "saga:flowaccumulationtopdown"
get_usage(alg)
carea = run_qgis(alg, ELEVATION = dem, METHOD = 4, 
                 FLOW = file.path(tempdir(), "carea.tif"),
                 load_output = TRUE)
# transform carea
log_carea = log10(carea)
names(log_carea) = "log_carea"
# add log_carea
ta = addLayer(x = ta, log_carea)
# extract values to points, i.e., create predictors
lsl[, names(ta)] = raster::extract(ta, lsl[, c("x", "y")])

# save input data
save(dem, lsl, ta, file = "extdata/spatialcv.Rdata")

#**********************************************************
# 4 MODELING-----------------------------------------------
#**********************************************************

coords = lsl[, c("x", "y")]
data = dplyr::select(lsl, -x, -y)
# data_nonspatial = dplyr::select(data, -x, -y)

# 3.1 create a mlr task====================================
#**********************************************************
# id = name of the task
# target = response variable
# spatial: setting up the scene for spatial cv (hence x and y will not be used
# as predictors but as coordinates for kmeans clustering)
# all variables in data will be used in the model

task_spatial = makeClassifTask(id = "lsl_glm_spatial", data = data,
                               target = "lslpts", positive = "TRUE",
                               # default: spatial = FALSE for spatial important
                               # that coordinates are named x and y,
                               coordinates = coords)


task_nonspatial = makeClassifTask(id = "lsl_glm_nonspatial", 
                                  data = data,
                                  target = "lslpts", positive = "TRUE")

# 3.2 Construct a learner and run the model================
#**********************************************************
# cl: class of learner, here binomial model GLM from the stats package
# link: logit link
# predict.type: probability
# fix.factors.prediction: ?

lrn_glm = makeLearner(cl = "classif.binomial",
                      link = "logit",
                      predict.type = "prob",
                      fix.factors.prediction = TRUE)
# training the model (percentage of test and training datasets?)
model_spatial = train(learner = lrn_glm, task = task_spatial)
model_nonspatial = train(learner = lrn_glm, task = task_nonspatial)
# unpacking the model
m_sp = getLearnerModel(model_spatial)
summary(m_sp)
m_nsp = getLearnerModel(model_nonspatial)
summary(m_nsp)

# interesting, coefficients are just the same
coefficients(m_sp)
coefficients(m_nsp)
identical(coefficients(m_sp), coefficients(m_nsp))

# 3.3 Spatial cross-validation=============================
#**********************************************************

# specify the reampling method, i.e. spatial CV with 10 repetitions and 5 folds
# -> in each repetition dataset will be splitted into five folds (kmeans)
# method: RepCV -> non-spatial partitioning
# method: SpRepCV -> spatial partioning
resampling_spatial = makeResampleDesc(method = "SpRepCV", folds = 5, reps = 10)
resampling_nsp = makeResampleDesc(method = "RepCV", folds = 5, reps = 10)
# apply the reampling by calling the resample function
set.seed(12345)  # why do we have the seed again??
spcv_glm = mlr::resample(learner = lrn_glm, task = task_spatial,
                    resampling = resampling_spatial,
                    measures = list(auc))
nspcv_glm = mlr::resample(learner = lrn_glm, task = task_nonspatial,
                          resampling = resampling_nsp,
                          measures = list(auc))
# Visualization of overfitting in the nsp-case
boxplot(spcv_glm$measures.test$auc,
        nspcv_glm$measures.test$auc)

#**********************************************************
# 4 SPATIAL PREDICTION-------------------------------------
#**********************************************************

pred = raster::predict(object = ta, model = m_sp, fun = predict,
                       type = "response")
plot(hs, col = gray(seq(0, 1, length.out = 100)), legend = FALSE)
# plot(pred, col = RColorBrewer::brewer.pal("YlOrRd", n =  9), add = TRUE, 
#      alpha = 0.6)
plot(pred, col = RColorBrewer::brewer.pal(name = "Reds", 9), add = TRUE, 
     alpha = 0.6)
vignette(package = "RSAGA")
