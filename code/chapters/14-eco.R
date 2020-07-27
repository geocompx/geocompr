## ----14-eco-1, message=FALSE---------------------------------------------
library(sf)
library(raster)
library(RQGIS)
library(mlr)
library(dplyr)
library(vegan)

## ----study-area-mongon, echo=FALSE, fig.cap="The Mt. Mongón study area, from Muenchow, Schratz, and Brenning (2017).", out.width="60%", fig.scap="The Mt. Mongón study area."----
knitr::include_graphics("https://user-images.githubusercontent.com/1825120/38989956-6eae7c9a-43d0-11e8-8f25-3dd3594f7e74.png")

## ----14-eco-2------------------------------------------------------------
data("study_area", "random_points", "comm", "dem", "ndvi", package = "spDataLarge")

## ----14-eco-3------------------------------------------------------------
# sites 35 to 40 and corresponding occurrences of the first five species in the
# community matrix
comm[35:40, 1:5]

## ----14-eco-4, eval=FALSE, echo=FALSE------------------------------------
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

## ----sa-mongon, echo=FALSE, message=FALSE, fig.cap="Study mask (polygon), location of the sampling sites (black points) and DEM in the background.", fig.scap="Study mask, location of the sampling sites."----
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


## ----14-eco-5, eval=FALSE------------------------------------------------
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

## ----14-eco-6, eval=FALSE------------------------------------------------
## # environmental predictors: catchment slope and catchment area
## ep = run_qgis(alg = "saga:sagawetnessindex",
##               DEM = dem,
##               SLOPE_TYPE = 1,
##               SLOPE = tempfile(fileext = ".sdat"),
##               AREA = tempfile(fileext = ".sdat"),
##               load_output = TRUE,
##               show_output_paths = FALSE)

## ----14-eco-7, eval=FALSE------------------------------------------------
## ep = stack(c(dem, ndvi, ep))
## names(ep) = c("dem", "ndvi", "carea", "cslope")

## ----14-eco-8, eval=FALSE------------------------------------------------
## ep$carea = log10(ep$carea)

## ----14-eco-9------------------------------------------------------------
data("ep", package = "spDataLarge")

## ----14-eco-10-----------------------------------------------------------
random_points[, names(ep)] = raster::extract(ep, random_points)

## ----14-eco-11-----------------------------------------------------------
# presence-absence matrix
pa = decostand(comm, "pa")  # 100 rows (sites), 69 columns (species)
# keep only sites in which at least one species was found
pa = pa[rowSums(pa) != 0, ]  # 84 rows, 69 columns

## ----14-eco-12, eval=FALSE, message=FALSE--------------------------------
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

## ----14-eco-13, eval=FALSE, echo=FALSE-----------------------------------
## saveRDS(nmds, "extdata/14-nmds.rds")

## ----14-eco-14, include=FALSE--------------------------------------------
nmds = readRDS("extdata/14-nmds.rds")

## ----xy-nmds, fig.cap="Plotting the first NMDS axis against altitude.", fig.scap = "First NMDS axis against altitude plot.", fig.asp=1, out.width="60%"----
elev = dplyr::filter(random_points, id %in% rownames(pa)) %>% 
  dplyr::pull(dem)
# rotating NMDS in accordance with altitude (proxy for humidity)
rotnmds = MDSrotate(nmds, elev)
# extracting the first two axes
sc = scores(rotnmds, choices = 1:2)
# plotting the first axis against altitude
plot(y = sc[, 1], x = elev, xlab = "elevation in m", 
     ylab = "First NMDS axis", cex.lab = 0.8, cex.axis = 0.8)

## ----14-eco-15, eval=FALSE, echo=FALSE-----------------------------------
## # scores and rotated scores in one figure
## p1 = xyplot(scores(rotnmds)[, 2] ~ scores(rotnmds)[, 1], pch = 16,
##              col = "lightblue", xlim = c(-3, 2), ylim = c(-2, 2),
##              xlab = list("Dimension 1", cex = 0.8),
##              ylab = list("Dimension 2", cex = 0.8),
##              scales = list(x = list(relation = "same", cex = 0.8),
##                            y = list(relation = "same", cex = 0.8),
##                            # ticks on top are suppressed
##                            tck = c(1, 0),
##                            # plots axes labels only in row and column 1 and 4
##                            alternating = c(1, 0, 0, 1),
##                            draw = TRUE),
##              # we have to use the same colors in the legend as used for the plot
##              # points
##              par.settings = simpleTheme(col = c("lightblue", "salmon"),
##                                         pch = 16, cex = 0.9),
##              # also the legend point size should be somewhat smaller
##              auto.key = list(x = 0.7, y = 0.9, text = c("unrotated", "rotated"),
##                              between = 0.5, cex = 0.9),
##              panel = function(x, y, ...) {
##                            # Plot the points
##                            panel.points(x, y, cex = 0.6, ...)
##                            panel.points(x = scores(nmds)[, 1],
##                                         y = scores(nmds)[, 2],
##                                         col = "salmon", pch = 16, cex = 0.6)
##                            panel.arrows(x0 = scores(nmds)[, 1],
##                                         y0 = scores(nmds)[, 2],
##                                         x1 = x,
##                                         y1 = y,
##                                         length = 0.04,
##                                         lwd = 0.4)
##             })
## 
## plot(scores(nmds, choices = 1:2))
## points(scores(rotnmds, choices = 1:2), col = "lightblue", pch = 16)
## 
## 
## sc = scores(nmds, choices = 1:2) %>% as.data.frame
## sc$id = rownames(sc) %>% as.numeric
## rp = inner_join(select(sc, id), st_set_geometry(random_points, NULL))
## fit_1 = envfit(nmds, select(rp, dem))
## fit_2 = envfit(rotnmds, select(rp, dem))
## par(mfrow = c(1, 2))
## plot(nmds, display = "sites")
## plot(fit_1)
## plot(rotnmds, display = "sites")
## plot(fit_2)

## ----14-eco-16-----------------------------------------------------------
# construct response-predictor matrix
# id- and response variable
rp = data.frame(id = as.numeric(rownames(sc)), sc = sc[, 1])
# join the predictors (dem, ndvi and terrain attributes)
rp = inner_join(random_points, rp, by = "id")

## ----14-eco-17, eval=FALSE-----------------------------------------------
## library("tree")
## tree_mo = tree(sc ~ dem, data = rp)
## plot(tree_mo)
## text(tree_mo, pretty = 0)

## ----14-eco-18, echo=FALSE, eval=TRUE------------------------------------
library("tree")
tree_mo = tree(sc ~ dem, data = rp)

## ----14-eco-19, eval=FALSE, echo=FALSE-----------------------------------
## png("figures/14_tree.png", width = 1100, height = 700, units = "px", res = 300)
## par(mar = rep(1, 4))
## plot(tree_mo)
## text(tree_mo, pretty = 0)
## dev.off()

## ----tree, echo=FALSE, fig.cap="Simple example of a decision tree with three internal nodes and four terminal nodes.", fig.scap="Simple example of a decision tree."----
knitr::include_graphics("figures/14_tree.png")

## ----14-eco-20-----------------------------------------------------------
# extract the coordinates into a separate data frame
coords = sf::st_coordinates(rp) %>% 
  as.data.frame() %>%
  rename(x = X, y = Y)
# only keep response and predictors which should be used for the modeling
rp = dplyr::select(rp, -id, -spri) %>%
  st_set_geometry(NULL)

## ----14-eco-21-----------------------------------------------------------
# create task
task = makeRegrTask(data = rp, target = "sc", coordinates = coords)
# learner
lrn_rf = makeLearner(cl = "regr.ranger", predict.type = "response")

## ----14-eco-22-----------------------------------------------------------
# spatial partitioning
perf_level = makeResampleDesc("SpCV", iters = 5)
# specifying random search
ctrl = makeTuneControlRandom(maxit = 50L)

## ----14-eco-23-----------------------------------------------------------
# specifying the search space
ps = makeParamSet(
  makeIntegerParam("mtry", lower = 1, upper = ncol(rp) - 1),
  makeNumericParam("sample.fraction", lower = 0.2, upper = 0.9),
  makeIntegerParam("min.node.size", lower = 1, upper = 10)
)

## ----14-eco-24, eval=FALSE-----------------------------------------------
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

## ----14-eco-25, eval=FALSE, echo=FALSE-----------------------------------
## saveRDS(tune, "extdata/14-tune.rds")

## ----14-eco-26, echo=FALSE-----------------------------------------------
tune = readRDS("extdata/14-tune.rds")

## ----14-eco-27-----------------------------------------------------------
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

## ----14-eco-28-----------------------------------------------------------
# convert raster stack into a data frame
new_data = as.data.frame(as.matrix(ep))
# apply the model to the data frame
pred_rf = predict(model_rf, newdata = new_data)
# put the predicted values into a raster
pred = dem
# replace altitudinal values by rf-prediction values
pred[] = pred_rf$data$response

## ----rf-pred, echo=FALSE, fig.cap="Predictive mapping of the floristic gradient clearly revealing distinct vegetation belts.", fig.width = 10, fig.height = 10, fig.scap="Predictive mapping of the floristic gradient."----
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

