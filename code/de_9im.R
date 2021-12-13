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
#' p3 = st_sfc(st_polygon(list(rbind(c(0.7, 0.3), c(0.7, 0.95), c(0.9, 0.95), c(0.7, 0.3)))))
#' p4 = st_sfc(st_polygon(list(rbind(c(0.6, 0.1), c(0.7, 0.5), c(0.9, 0.5), c(0.6, 0.1)))))
#' p5 = st_sfc(st_polygon(list(rbind(c(0, 0.2), c(0, 1), c(0.9, 1), c(0, 0.2)))))
#' de_9im(x, p3)
de_9im = function(x,
                  y,
                  object_names = c("x", "y"),
                  plot = TRUE,
                  funs = list(
                    "st_intersects",
                    "st_disjoint",
                    "st_touches",
                    "st_crosses",
                    "st_within",
                    "st_contains",
                    "st_contains_properly",
                    "st_overlaps",
                    "st_equals",
                    "st_covers",
                    "st_covered_by"
                    # ,
                    # "st_equals_exact" # requuires par argument
                    ),
                  include_relate = TRUE,
                  sparse = FALSE,
                  output = "character",
                  collapse = " ✓\n"
                  ) {
  require("sf")
  if (is(x, "sfc") && is(y, "sfc")) {
    x = st_sf(data.frame(Object = object_names[1]), geometry = x)
    y = st_sf(data.frame(Object = object_names[2]), geometry = y)
  }
  xy = rbind(x, y)
  funs_matched = lapply(funs, match.fun)
  res = lapply(seq(length(funs)), function(i) {
    funs_matched[[i]](x, y, sparse = sparse)
  })
  res = unlist(res)
  if(output == "character") {
    res = unlist(funs)[res]
  }
  if(include_relate) {
    relation = sf::st_relate(x, y)
    relate_text = paste0(" \nDE-9IM string: \n", relation) 
    res = c(res, relate_text)
  }
  if(plot) {
    res_text = paste(res, collapse = collapse)
    message("Object x has the following spatial relations to y: ", res_text)
    res = de_9im_plot(xy, label = res_text)
  }
  res
}

de_9im_plot = function(xy, label = "test", alpha = 0.5, show.legend = FALSE, x = 0.1, y = 0.95, theme = ggplot2::theme_void()) {
  require("ggplot2", quietly = TRUE)
  # browser()
  ggplot(xy) + geom_sf(aes(fill = Object), alpha = alpha, show.legend = show.legend) +
    annotate("text", x = 0.1, y = 0.95, label = label, hjust = "left", vjust = "top") +
    theme
}

# # Test code to functionalize:
# theme_set(new = theme_void())
# g1 = ggplot(ps1) + geom_sf(aes(fill = Object), alpha = 0.5, show.legend = FALSE)
# # g1 + annotate("text", x = 0.3, y = 0.9, label = "st_intersects(Polygon1, Polygon2)")
# g1 + annotate("text", x = 0.1, y = 0.95, label = "intersects TRUE\ndisjoint     FALSE\ntouches    TRUE\n", hjust = "left", vjust = "top")
# # Try annotating only which type of relations apply
# # g1 + annotate("text", x = 0.1, y = 0.95, label = "Relations: intersects, touches", hjust = "left", vjust = "top")
# g1an = g1 + 
#
