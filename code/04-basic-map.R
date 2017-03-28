## ---- echo=FALSE, include=FALSE------------------------------------------
if(!exists("world"))
        source("code/03-attr.R")

## ----sfplot, fig.cap="Plotting with sf, with multiple variables (left) and a single variable (right).", out.width="49%", fig.show='hold', warning=FALSE----
plot(world)
plot(world["population"])

## ---- fig.show='hide'----------------------------------------------------
plot(world["pop_density"])
africa = world_continents[1,]
plot(africa, add = TRUE, col = "red")

## ----nigeria, warning=FALSE, echo=FALSE, fig.cap="Map of Nigeria in context illustrating sf's plotting capabilities"----
nigeria = filter(world, name == "Nigeria")
bb_africa = st_bbox(africa)
plot(africa[2], col = "white", lwd = 3, main = "Nigeria in context", border = "lightgrey")
# plot(world, lty = 3, add = TRUE, border = "grey")
plot(world, add = TRUE, border = "grey")
plot(nigeria, col = "yellow", add = TRUE, border = "darkgrey")
ncentre = st_centroid(nigeria)
ncentre_num = st_coordinates(ncentre)
text(x = ncentre_num[1], y = ncentre_num[2], labels = "Nigeria")

## ---- out.width="50%", fig.cap="Centroids in Africa"---------------------
world_centroids = st_centroid(world)
plot(world_centroids[1])
africa_centroids = world_centroids[africa,]
plot(africa_centroids, add = TRUE, cex = 2)

## ------------------------------------------------------------------------
sel_africa = st_covered_by(world_centroids, africa, sparse = FALSE)
summary(sel_africa)

## ------------------------------------------------------------------------
africa_centroids2 = world_centroids[sel_africa,]
identical(africa_centroids, africa_centroids2)

