#' This function visualises sf objects and returns info on the 
#' types of spatial relationship there is between them
#' 
#' Context: [robinlovelace/geocompr#677](https://github.com/Robinlovelace/geocompr/issues/677)
#' 
#' @examples 
#' library(sf)
#' x = st_sfc(st_polygon(list(rbind(c(0, 0), c(1, 0), c(1, 1), c(0, 0)))))
#' y = st_sfc(st_polygon(list(rbind(c(0, 0), c(0, 1), c(1, 1), c(0, 0)))))
#' de_9im(x, y)
de_9im = function(x, y, object_names = c("x", "y"), funs = list("st_intersects", "st_disjoint"), sparse = FALSE) {
  requireNamespace("sf", quietly = TRUE)
  if(is(x, "sfc") && is(y, "sfc")) {
    x = st_sf(data.frame(Object = object_names[1]), geometry = x)
    y = st_sf(data.frame(Object = object_names[2]), geometry = y)
  }
  xy = rbind(x, y)
  funs_matched = lapply(funs, match.fun)
  res = lapply(seq(length(funs)), function(i) {
    funs_matched[[i]](x, y, sparse = sparse)
  })
  unlist(res)
}

# # Test code to functionalize:
# theme_set(new = theme_void())
# g1 = ggplot(ps1) + geom_sf(aes(fill = Object), alpha = 0.5, show.legend = FALSE)
# # g1 + annotate("text", x = 0.3, y = 0.9, label = "st_intersects(Polygon1, Polygon2)")
# g1 + annotate("text", x = 0.1, y = 0.95, label = "intersects TRUE\ndisjoint     FALSE\ntouches    TRUE\n", hjust = "left", vjust = "top") 
# # Try annotating only which type of relations apply
# # g1 + annotate("text", x = 0.1, y = 0.95, label = "Relations: intersects, touches", hjust = "left", vjust = "top")
# g1an = g1 + annotate("text", x = 0.1, y = 0.95, label = "Relations: intersects, touches\nDE-9IM: FF2F11212", hjust = "left", vjust = "top")
# 
# g2 = ggplot(ps2) + geom_sf(aes(fill = Object), alpha = 0.5, show.legend = FALSE)
# g2an = g2 + annotate("text", x = 0.1, y = 0.95, label = "Relations: intersects,\ntouches, overlaps\nDE-9IM: 212101212", hjust = "left", vjust = "top")
