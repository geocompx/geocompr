# Filename: 13_partitioning.R (2018-03-08)
#
# TO DO: show the difference between spatial and random partitioning
#
# Author(s): Jannes Muenchow
#
#**********************************************************
# CONTENTS-------------------------------------------------
#**********************************************************
#
# 1. ATTACH PACKAGES AND DATA
# 2. DATA PREPARATION
# 3. LATTICE SOLUTION
# 4. MLR SOLUTION
#
#**********************************************************
# 1 ATTACH PACKAGES AND DATA-------------------------------
#**********************************************************

# attach packages
library(grid)
library(gridExtra)
library(lattice)
library(latticeExtra)
library(sperrorest)
library(tidyr)

# attach data
data(lsl, package = "spDataLarge")

#**********************************************************
# 2 DATA PREPARATION---------------------------------------
#**********************************************************

# non-spatial partitioning
resamp_nsp = sperrorest::partition_cv(lsl, nfold = 5, repetition = 1)
# plot(resamp_nsp, data = lsl)
# spatial partitioning
resamp_sp = sperrorest::partition_kmeans(lsl, nfold = 5, repetition = 1)
# plot(resamp_sp, data = lsl)

# extract spatial partitioning points
spp = lsl[, c("x", "y")]
spp[, paste("fold", 1:5)] = lapply(resamp_sp$`1`, function(x) {
  spp[x$test, "fold"] = 1
  spp[is.na(spp$fold), "fold"] = 0
  spp$fold = as.logical(spp$fold)
  spp$fold
})
# melt the data frame
spp = tidyr::pivot_longer(spp, `fold 1`:`fold 5`)
names(spp) = c("x", "y", "fold", "value")
# xyplot(y ~ x | fold, groups = value, data = spp, layout = c(5, 1), asp = "iso",
#        pch = 16)
spp$mode = "spatial partitioning"

# extract random partitioning points
rpp = lsl[, c("x", "y")]
rpp[, paste("fold", 1:5)] = lapply(resamp_nsp$`1`, function(x) {
  rpp[x$test, "fold"] = 1
  rpp[is.na(rpp$fold), "fold"] = 0
  rpp$fold = as.logical(rpp$fold)
  rpp$fold
})
# melt the data frame
rpp = tidyr::pivot_longer(rpp, `fold 1`:`fold 5`)
names(rpp) = c("x", "y", "fold", "value")
# xyplot(y ~ x | fold, groups = value, data = rpp, layout = c(5, 1), asp = "iso",
#        pch = 16)
rpp$mode = "random partitioning"
# rbind spatial and random partitioning points
pp = rbind(spp, rpp)

#**********************************************************
# 3 LATTICE SOLUTION---------------------------------------
#**********************************************************

# plot both partitionings
p_1 = xyplot(y ~ x | fold + mode, groups = factor(value), data = pp,
             xlab = "", ylab = "", cex = 0.6, 
             key = list(space = "bottom", columns = 2,
                        text = list(c("training data", "test data"), cex = 1),
                        points = list(col = c("salmon", "lightblue"), pch = 16)),
             col = c("salmon", "lightblue"),
             layout = c(5, 2), asp = "iso", pch = 16,
             scales = list(tck = c(1, 0),
                           alternating = c(0, 1, 0, 0, 1),
                           y = list(rot = 90, cex = 0.7),
                           x = list(cex = 0.7)),
             between = list(y = 0.5), as.table = TRUE)

p_2 = useOuterStrips(
  p_1, 
  strip = strip.custom(bg = c("white"),
                       par.strip.text = list(cex = 0.8)),
  strip.left = strip.custom(bg = "white", 
                            par.strip.text = list(cex = 0.8))
  )

png(filename = "figures/13_partitioning.png",res = 200, units = "cm", 
    width = 18, height = 11)
# plot(arrangeGrob(p_2, ncol = 1))
print(p_2)
dev.off()

#**********************************************************
# 3 MLR SOLUTION-------------------------------------------
#**********************************************************

# attach packages
# remotes::install_github("pat-s/mlr@plot_spatial_partitions")
# library(mlr)
# rdesc = makeResampleDesc("SpRepCV", folds = 5, reps = 4)
# r = resample(makeLearner("classif.qda"), spatial.task, rdesc)
# plots = createSpatialResamplingPlots(spatial.task, r, crs = 32717,
#                                      repetitions = 2,
#                                      x.axis.breaks = c(-79.065, -79.085), 
#                                      y.axis.breaks = c(-3.970, -4))
# cowplot::plot_grid(plotlist = plots[["Plots"]], ncol = 5, nrow = 2, 
#                    labels = plots[["Labels"]])



