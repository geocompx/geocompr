## ----13-ex-e0, message=FALSE------------------------------------------------------------------------------------------------------------------------------
library(sf)
library(spDataLarge)


## ----13-transport-29, eval=FALSE, echo=FALSE--------------------------------------------------------------------------------------------------------------
## sum(route_cycleway$distance)
## sum(st_length(route_cycleway))


## ----13-transport-30, echo=FALSE, eval=FALSE--------------------------------------------------------------------------------------------------------------
## sum(route_cycleway$all) / sum(desire_lines$all) # around 2%
## d_intersect = desire_lines[route_cycleway, , op = st_crosses]
## sum(d_intersect$all) / sum(desire_lines$all) # around 2%

