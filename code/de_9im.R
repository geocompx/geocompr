#' This function visualises sf objects and returns info on the 
#' types of spatial relationship there is between them
#' 
#' Context: [robinlovelace/geocompr#677](https://github.com/Robinlovelace/geocompr/issues/677)
#' 
#' @examples 
#' library(sf)
#' x = st_sfc(st_polygon(list(rbind(c(0, 0), c(1, 0), c(1, 1), c(0, 0)))))
#' y = st_sfc(st_polygon(list(rbind(c(0, 0), c(0, 1), c(1, 1), c(0, 0)))))
#' de_9im
de_9im = function(x, y, object_names = c("x", "y")) {
  if(is(x, "sfc") && is(y, "sfc")) {
    x = st_sf(data.frame(Object = object_names[1]), geometry = x)
    y = st_sf(data.frame(Object = object_names[2]), geometry = y)
  }
  browser()
  ps1 = rbind(psf1, psf2)
}