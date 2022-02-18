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
library(dplyr)

# attach data
data("landslides", package = "RSAGA")
# in sperrorest and mlr there is also landslide data available, however, this
# corresponds to the year 2000 and uses another DEM
# data("ecuador", package = "sperrorest")
# or using the mlr package
# slides = getTaskData(spatial.task)
# coords = spatial.task$coordinates

#**********************************************************
# 2 DATA PREPROCESSING-------------------------------------
#**********************************************************

# landslide points
non_pts = dplyr::filter(landslides, lslpts == FALSE)
# select landslide points
lsl_pts = dplyr::filter(landslides, lslpts == TRUE)
# randomly select 175 non-landslide points
set.seed(11042018)
non_pts_sub = sample_n(non_pts, size = nrow(lsl_pts))
# create smaller landslide dataset (lsl)
lsl = bind_rows(non_pts_sub, lsl_pts)
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
set_env(dev = FALSE)
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
log10_carea = log10(carea)
names(log10_carea) = "log10_carea"
names(dem) = "elev"
# add log_carea
ta = addLayer(x = ta, dem, log10_carea)
# extract values to points, i.e., create predictors
lsl[, names(ta)] = raster::extract(ta, lsl[, c("x", "y")])

# corresponding data is available in spDataLarge
# data("lsl", package = "spDataLarge")
# data("ta", package = "spDataLarge")

#**********************************************************
# 4 MODELING-----------------------------------------------
#**********************************************************

# attach data
# data("lsl", package = "spDataLarge")
# data("ta", package = "spDataLarge")

coords = lsl[, c("x", "y")]
data = dplyr::select(lsl, -x, -y)

# 3.1 create a mlr task====================================
#**********************************************************
# id = name of the task
# target = response variable
# spatial: setting up the scene for spatial cv (hence x and y will not be used
# as predictors but as coordinates for kmeans clustering)
# all variables in data will be used in the model

task = makeClassifTask(id = "lsl_glm_spatial", data = data,
                       target = "lslpts", positive = "TRUE",
                       coordinates = coords)


task_nsp = makeClassifTask(id = "lsl_glm_nonspatial", 
                           data = data,
                           target = "lslpts", positive = "TRUE")

# 3.2 Construct a learner and run the model================
#**********************************************************
# cl: class of learner, here binomial model GLM from the stats package
# link: logit link
# predict.type: probability
# fix.factors.prediction: ?

lrn = makeLearner(cl = "classif.binomial",
                  link = "logit",
                  predict.type = "prob",
                  # I guess we don't need it, right?
                  fix.factors.prediction = FALSE)

# training the model (percentage of test and training datasets?)
mod_sp = train(learner = lrn, task = task)
head(predict(mod_sp, task = task))
# exactly the same as, and needed for model interpretation
fit = glm(lslpts ~ ., data = data, family = "binomial")
head(predict(fit, type = "response"))
mod_nsp = train(learner = lrn, task = task_nsp)
# unpacking the model
m_sp = getLearnerModel(mod_sp)
summary(m_sp)
m_nsp = getLearnerModel(mod_nsp)
summary(m_nsp)

# coefficients are just the same
coefficients(m_sp)
coefficients(m_nsp)
identical(coefficients(m_sp), coefficients(m_nsp))

# 3.3 Spatial cross-validation=============================
#**********************************************************

# specify the reampling method, i.e. spatial CV with 10 repetitions and 5 folds
# -> in each repetition dataset will be splitted into five folds (kmeans)
# method: RepCV -> non-spatial partitioning
# method: SpRepCV -> spatial partioning
resampling = makeResampleDesc(method = "SpRepCV", folds = 5, reps = 100)
resampling_nsp = makeResampleDesc(method = "RepCV", folds = 5, reps = 100)
# apply the reampling by calling the resample function needed for using the same
# (randomly) selected folds/partitioning in different models spatial vs.
# non-spatial or glm vs. GAM 
set.seed(012348)  
# why do we need the seed?
# the seed is needed when to make sure
# that always the same spatial partitions are used when reruning the code
sp_cv = mlr::resample(learner = lrn, task = task,
                      resampling = resampling,
                      measures = mlr::auc)
conv_cv = mlr::resample(learner = lrn, task = task_nsp,
                        resampling = resampling_nsp,
                        measures = mlr::auc)
# Visualization of overfitting in the nsp-case
boxplot(sp_cv$measures.test$auc,
        conv_cv$measures.test$auc)

# save your result
# saveRDS(sp_cv, file = "extdata/sp_cv.rds")
# saveRDS(conv_cv, file = "extdata/conv_cv.rds")

#**********************************************************
# 4 SPATIAL PREDICTION-------------------------------------
#**********************************************************

pred = raster::predict(object = ta, model = m_sp, fun = predict,
                       type = "response")
hs = hillShade(out$SLOPE * pi / 180, out$ASPECT * pi / 180, 40, 270)
plot(hs, col = gray(seq(0, 1, length.out = 100)), legend = FALSE)
# plot(pred, col = RColorBrewer::brewer.pal("YlOrRd", n =  9), add = TRUE, 
#      alpha = 0.6)
plot(pred, col = RColorBrewer::brewer.pal(name = "Reds", 9), add = TRUE, 
     alpha = 0.6)
vignette(package = "RSAGA")

# make the prediciton "manually"
ta_2 = stack(ta)
newdata = as.data.frame(as.matrix(ta_2))
colSums(is.na(newdata))  # ok, there are NAs
ind = rowSums(is.na(newdata)) == 0
tmp = mlr::predictLearner(.learner = lrn, mod_sp, newdata[ind, ])
newdata[ind, "pred"] = tmp[, 2]
# check
identical(values(pred), newdata$pred)
pred_2 = ta$slope
values(pred_2) = newdata$pred
all.equal(pred, pred_2)
plot(stack(pred, pred_2))
