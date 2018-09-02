## ---- message=FALSE------------------------------------------------------
library(sf)
library(raster)
library(RQGIS)
library(mlr)
library(dplyr)
library(vegan)

## ----study-area-mongon, echo=FALSE, fig.cap="The Mt. Mongón study area, from Muenchow, Schratz, and Brenning (2017).", out.width="60%"----
knitr::include_graphics("https://user-images.githubusercontent.com/1825120/38989956-6eae7c9a-43d0-11e8-8f25-3dd3594f7e74.png")

## ------------------------------------------------------------------------
data("study_area", "random_points", "comm", "dem", "ndvi")

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # create hillshade
## hs = hillShade(terrain(dem), terrain(dem, "aspect"))
## # plot the data
## par(mar = rep(1, 4))
## plot(hs, col = gray(0:100 / 100), legend = FALSE, axes = FALSE, box = FALSE)
## plot(dem, axes = FALSE, add = TRUE, alpha = 0.5, legend = FALSE)
## axis(1)
## axis(2)
## plot(st_geometry(random_points), add = TRUE)
## plot(st_geometry(study_area), add = TRUE)
## # white margins between axes and plot are too wide

## ---- echo=FALSE, message=FALSE, fig.cap="Study mask (polygon), location of the sampling sites (black points) and DEM in the background."----
library("latticeExtra")
library("grid")
hs = hillShade(terrain(dem), terrain(dem, "aspect"))
spplot(dem, col.regions = terrain.colors(50), alpha.regions = 0.5,
       scales = list(draw = TRUE,
                     tck = c(1, 0)),
       colorkey = list(space = "right", title = "m asl",
                               width = 0.5, height = 0.5,
                       axis.line = list(col = "black")),
       sp.layout = list(
         list("sp.points", as(random_points, "Spatial"), pch = 16,
              col = "black", cex = 0.8, first = FALSE),
         list("sp.polygons", as(study_area, "Spatial"), 
              col = "black", first = FALSE)
       )
       ) + 
  latticeExtra::as.layer(spplot(hs, col.regions = gray(0:100 / 100)), 
                         under = TRUE)
grid.text("m asl", x = unit(0.8, "npc"), y = unit(0.75, "npc"), 
          gp = gpar(cex = 0.8))


## ---- eval=FALSE---------------------------------------------------------
## get_usage("saga:sagawetnessindex")
## #>ALGORITHM: Saga wetness index
## #>	DEM <ParameterRaster>
## #>  ...
## #>	SLOPE_TYPE <ParameterSelection>
## #>  ...
## #>	AREA <OutputRaster>
## #>	SLOPE <OutputRaster>
## #>	AREA_MOD <OutputRaster>
## #>	TWI <OutputRaster>
## #> ...
## #>SLOPE_TYPE(Type of Slope)
## #>	0 - [0] local slope
## #>	1 - [1] catchment slope
## #> ...

## ---- eval=FALSE---------------------------------------------------------
## # environmental predictors: catchment slope and catchment area
## ep = run_qgis(alg = "saga:sagawetnessindex",
##               DEM = dem,
##               SLOPE_TYPE = 1,
##               SLOPE = tempfile(fileext = ".sdat"),
##               AREA = tempfile(fileext = ".sdat"),
##               load_output = TRUE,
##               show_output_paths = FALSE)

## ---- eval=FALSE---------------------------------------------------------
## ep = c(dem, ndvi, ep) %>%
##   stack()
## names(ep) = c("dem", "ndvi", "carea", "cslope")

## ---- eval=FALSE---------------------------------------------------------
## ep$carea = log10(ep$carea)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## saveRDS(brick(ep), "extdata/14-ep.rds")

## ---- echo=FALSE---------------------------------------------------------
ep = readRDS("extdata/14-ep.rds")

## ------------------------------------------------------------------------
random_points[, names(ep)] = raster::extract(ep, as(random_points, "Spatial"))

## ------------------------------------------------------------------------
# sites 35 to 40 and corresponding occurrences of the first five species in the
# table
comm[35:40, 1:5]

## ------------------------------------------------------------------------
pa = decostand(comm, "pa")

## ---- eval=FALSE, message=FALSE------------------------------------------
## set.seed(25072018)
## nmds = metaMDS(comm = pa, k = 4, try = 500)
## nmds$stress
## #> ...
## #> Run 498 stress 0.08834745
## #> ... Procrustes: rmse 0.004100446  max resid 0.03041186
## #> Run 499 stress 0.08874805
## #> ... Procrustes: rmse 0.01822361  max resid 0.08054538
## #> Run 500 stress 0.08863627
## #> ... Procrustes: rmse 0.01421176  max resid 0.04985418
## #> *** Solution reached
## #> 0.08831395

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## saveRDS(nmds, "extdata/14-nmds.rds")

## ---- include=FALSE------------------------------------------------------
nmds = readRDS("extdata/14-nmds.rds")

## ----xy-nmds, fig.cap="Plotting the first NMDS axis against altitude.", fig.asp=1, out.width="60%"----
elev = dplyr::filter(random_points, id %in% rownames(pa)) %>% 
  dplyr::pull(dem)
# rotating NMDS in accordance with altitude (proxy for humidity)
rotnmds = MDSrotate(nmds, elev)
# extracting the first two axes
sc = scores(rotnmds, choices = 1:2)
# plotting the first axis against altitude
plot(y = sc[, 1], x = elev, xlab = "elevation in m", 
     ylab = "First NMDS axis", cex.lab = 0.8, cex.axis = 0.8)

## ------------------------------------------------------------------------
# construct response-predictor matrix
# id- and response variable
rp = data.frame(id = as.numeric(rownames(sc)),
                sc = sc[, 1])
# join the predictors (dem, ndvi and terrain attributes)
rp = inner_join(random_points, rp, by = "id")

## ----tree, fig.cap="Simple example of a decision tree with three internal nodes and four terminal nodes."----
library("tree")
tree_mo = tree(sc ~ dem, data = rp)
plot(tree_mo)
text(tree_mo, pretty = 0)

## ------------------------------------------------------------------------
# extract the coordinates into a separate dataframe
coords = sf::st_coordinates(rp) %>% 
  as.data.frame() %>%
  rename(x = X, y = Y)
# only keep response and predictors which should be used for the modeling
rp = dplyr::select(rp, -id, -spri) %>%
  st_set_geometry(NULL)

## ------------------------------------------------------------------------
# create task
task = makeRegrTask(data = rp, target = "sc", coordinates = coords)
# learner
lrn_rf = makeLearner(cl = "regr.ranger", predict.type = "response")

## ------------------------------------------------------------------------
# spatial partitioning
perf_level = makeResampleDesc("SpCV", iters = 5)
# specifying random search
ctrl = makeTuneControlRandom(maxit = 50L)

## ------------------------------------------------------------------------
# specifying the search space
ps = makeParamSet(
  makeIntegerParam("mtry", lower = 1, upper = ncol(rp) - 1),
  makeNumericParam("sample.fraction", lower = 0.2, upper = 0.9),
  makeIntegerParam("min.node.size", lower = 1, upper = 10)
)

## ---- eval=FALSE---------------------------------------------------------
## # hyperparamter tuning
## set.seed(02082018)
## tune = tuneParams(learner = lrn_rf,
##                   task = task,
##                   resampling = perf_level,
##                   par.set = ps,
##                   control = ctrl,
##                   measures = mlr::rmse)
## #>...
## #> [Tune-x] 49: mtry=3; sample.fraction=0.533; min.node.size=5
## #> [Tune-y] 49: rmse.test.rmse=0.5636692; time: 0.0 min
## #> [Tune-x] 50: mtry=1; sample.fraction=0.68; min.node.size=5
## #> [Tune-y] 50: rmse.test.rmse=0.6314249; time: 0.0 min
## #> [Tune] Result: mtry=4; sample.fraction=0.887; min.node.size=10 :
## #> rmse.test.rmse=0.5104918

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## saveRDS(tune, "extdata/14-tune.rds")

## ---- echo=FALSE---------------------------------------------------------
tune = readRDS("extdata/14-tune.rds")

## ------------------------------------------------------------------------
# learning using the best hyperparameter combination
lrn_rf = makeLearner(cl = "regr.ranger",
                     predict.type = "response",
                     mtry = tune$x$mtry, 
                     sample.fraction = tune$x$sample.fraction,
                     min.node.size = tune$x$min.node.size)
# doing the same more elegantly using setHyperPars()
# lrn_rf = setHyperPars(makeLearner("regr.ranger", predict.type = "response"),
#                       par.vals = tune$x)
# train model
model_rf = train(lrn_rf, task)
# to retrieve the ranger output, run:
# mlr::getLearnerModel(model_rf)
# which corresponds to:
# ranger(sc ~ ., data = rp, 
#        mtry = tune$x$mtry, 
#        sample.fraction = tune$x$sample.fraction,
#        min.node.sie = tune$x$min.node.size)

## ------------------------------------------------------------------------
# convert raster stack into a dataframe
new_data = as.data.frame(as.matrix(ep))
# apply the model to the dataframe
pred_rf = predict(model_rf, newdata = new_data)
# put the predicted values into a raster
pred = dem
# replace altitudinal values by rf-prediction values
pred[] = pred_rf$data$response

## ----rf-pred, echo=FALSE, fig.cap="Predictive mapping of the floristic gradient clearly revealing distinct vegetation belts.", fig.width = 10, fig.height = 10----
library("latticeExtra")
library("grid")

# create a color palette
blue = rgb(0, 0, 146, maxColorValue = 255)
lightblue = rgb(0, 129, 255, maxColorValue = 255)
turquoise = rgb(0, 233, 255, maxColorValue = 255)
green = rgb(142, 255, 11, maxColorValue = 255)
yellow = rgb(245, 255, 8, maxColorValue = 255)
orange = rgb(255, 173, 0, maxColorValue = 255)
lightred = rgb(255, 67, 0, maxColorValue = 255)
red = rgb(170, 0, 0, maxColorValue = 255)
pal = colorRampPalette(c(blue, lightblue, turquoise, green, yellow, 
                         orange, lightred, red))

# restrict the prediction to your study area
pred = mask(pred, study_area) %>%
  trim
# create a hillshade
hs = hillShade(terrain(dem), terrain(dem, "aspect")) %>%
  mask(., study_area) 
spplot(extend(pred, 2), col.regions = pal(50), alpha.regions = 0.7,
       scales = list(draw = TRUE,
                     tck = c(1, 0), 
                     cex = 0.8),
       colorkey = list(space = "right", width = 0.5, height = 0.5,
                       axis.line = list(col = "black")),
       sp.layout = list(
         # list("sp.points", as(random_points, "Spatial"), pch = 16,
         #      col = "black", cex = 0.8, first = FALSE),
         list("sp.polygons", as(study_area, "Spatial"), 
              col = "black", first = FALSE, lwd = 3)
       )
       ) + 
  latticeExtra::as.layer(spplot(hs, col.regions = gray(0:100 / 100)), 
                         under = TRUE)
grid.text("NMDS1", x = unit(0.75, "npc"), y = unit(0.75, "npc"), 
          gp = gpar(cex = 0.8))

