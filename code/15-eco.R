# Filename: casma.R (2017-09-26)
#
# TO DO: Model ordination scores of Mt. Mongón
#
# Author(s): Jannes Muenchow
#
#**********************************************************
# CONTENTS-------------------------------------------------
#**********************************************************
#
# 1. ATTACH PACKAGES AND DATA
# 2. ORDINATIONS
# 3. MODELING
# 4. SPATIAL PREDICTION
#
#**********************************************************
# 1 ATTACH PACKAGES AND DATA-------------------------------
#**********************************************************

# attach packages
library(vegan)
library(dplyr)
library(RQGIS)
library(raster)
library(mgcv)
library(sf)

# attach data
data("random_points", "study_area", "comm", "dem", "ndvi")
# add altitude to random_points
random_points$dem = raster::extract(dem, random_points)

#**********************************************************
# 2 ORDINATIONS--------------------------------------------
#**********************************************************

# presence absence matrix
pa = decostand(comm, "pa")

# DCA
dca = decorana(pa)
# proportion of variance
dca$evals / sum(dca$evals)                                      
# cumulative proportion
cumsum(dca$evals / sum(dca$evals))  # 44% and 72%

# NMDS
# nmds = metaMDS(comm, k = 3, try = 500)
nmds = metaMDS(pa, k = 3, try = 500)
# best approach:
# pa, k = 4
# stress: 8.8
# explained variance first axis: 61%, first 2 axes: 0.77
# and plot(scores_1 ~ elev) looks reasonable

nmds
# Standard deviations of the axes
apply(scores(nmds), 2, sd)

# goodness of fit expressed as explained variance
cor(vegdist(pa), dist(scores(nmds)[, 1:2]))^2  # 0.83 first two axes
cor(vegdist(pa), dist(scores(nmds)[, 1]))^2  # 0.62 only the first axis

elev = dplyr::filter(random_points, id %in% rownames(pa)) %>% 
  dplyr::pull(dem)
plot(scores(nmds), type = "n", xlim = c(-1, 1))
# text(scores(nmds), labels = rownames(pa))
text(scores(nmds), labels = elev)

# Rotates NMDS result so that the first dimension is parallel to an
# environmental variable (works quite good)

rotnmds = MDSrotate(nmds, elev)  # proxy for elevation
cor(vegdist(pa), dist(scores(rotnmds)[, 1]))^2  # 0.59 only the first axis
cor(vegdist(pa), dist(scores(rotnmds)[, 1:2]), method = "spearman")
plot(rotnmds, type = "n", xlim = c(-1, 1))
text(rotnmds, labels = elev, cex = 0.8)

# plot(x = elev, y = scores(rotnmds)[, 1])
# plot(elev, y = scores(rotnmds)[, 2])
plot(x = elev, y = scores(nmds)[, 1])
# plot(elev, scores(nmds)[, 2])
resp = scores(nmds)[, 1]
resp = scores(rotnmds)[, 1]
fit = gam(resp ~ s(elev))
summary(fit)  # deviance explained unrotated: 80%; rotated: 77.9%
plot(resp ~ elev)
# avoid spaghetti plot
I1 = order(elev)
lines(x = elev[I1], y = predict(fit)[I1],  col = "red")
# text(x = elev, y = resp, labels = rownames(d))

# ISOMAP
source(file.path("D:/uni/science/projects/ecology/asia/Mongolia/", 
                 "TINN-R/functions/bestisomap.r"))
# Isomap
pa = decostand(d, "pa")
bestiso = bestisomap(vegdist(d, "altGower")) 
# geo distances
geod = isomapdist(vegdist(d, "bray"), k = 69, ndim = 3)
# Secondly, subject the geodesic distances to a multidimensional scaling, i.e. perform an isomap ordination
iso = cmdscale(geod, k = 3, eig = TRUE)
# cmdscale does not automatically provide species scores, a function of the BiodiversityR package does the trick
library(BiodiversityR)
# species scores
isospec = 
  as.data.frame(add.spec.scores(iso, d, 
                                method = "pcoa.scores", multi = 0.15,
                                Rscale = TRUE)$cproj)



# percentage data: first axis 70%, first and second axis 83%
# my bad; this was the result when the first col was the id...
plot(elev, bestiso$Scores[, 1])
# pa: explained variance first two axes = 70.6 % (k = 32)
resp = bestiso$Scores[, 3]
fit = gam(resp ~ s(elev))
summary(fit)  # deviance explained 91%
plot(resp ~ elev)
# avoid spaghetti plot
I1 = order(elev)
lines(x = elev[I1], y = predict(fit)[I1],  col = "red")
gam.check(fit)
# model validation only necessary if we want to do statistical inference
resids = residuals(fit, type = "pearson")
plot(resids ~ elev)  # maybe slight indication of heterogeneity, but ok
hist(resids)  # ok
plot(resids ~ fitted(fit))  # ok
