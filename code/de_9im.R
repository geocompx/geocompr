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
                  collapse = " ✓\n",
                  tmap = TRUE
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
  if (output == "character") {
    res = unlist(funs)[res]
  }
  res_text2 = ""
  if (include_relate) {
    relation = sf::st_relate(x, y)
    res_text2 = paste0(" \nDE-9IM string: \n", relation) 
  }
  if (plot) {
    res_text1 = paste(res, collapse = collapse)
    collapse_no_break = gsub(pattern = "\\n", replacement = "", x = collapse)
    res_text1 = paste0(res_text1, collapse_no_break)
    message("Object x has the following spatial relations to y: ", res_text1, res_text2)
    if (tmap){
      res = de_9im_plot2(xy, label1 = res_text1, label2 = res_text2)
    } else {
      res = de_9im_plot(xy, label1 = res_text1, label2 = res_text2)
    }
  }
  res
}

de_9im_plot = function(xy, label1 = "test", label2 = "",
                       alpha = 0.5, show.legend = FALSE, x = 0.1, y = 0.95, 
                       theme = ggplot2::theme_void()) {
  require("ggplot2", quietly = TRUE)
  # browser()
  ggplot(xy) + 
    geom_sf(aes(fill = Object), alpha = alpha, show.legend = show.legend) +
    annotate("text", x = 0.1, y = 0.95, label = label1, hjust = "left", vjust = "top") +
    annotate("text", x = 0.1, y = 0.1, label = label2, hjust = "left", vjust = "bottom", 
             fontface = "italic") +
    theme
}

de_9im_plot2 = function(xy, label1 = "test", label2 = "",
                       alpha = 0.5, show.legend = FALSE, x = 0.1, y = 0.95, 
                       theme = ggplot2::theme_void()) {
  require("tmap", quietly = TRUE)
  # browser()
  # toDo: does not work yet
  st_crs(xy) = "EPSG:2180"
  tm_shape(xy) +
    tm_polygons("Object", fill.legend = tm_legend_hide(),
                fill_alpha = alpha,
                fill.scale = tm_scale(values = c("#E36939", "#6673E3"))) +
    tm_credits(label1, position = c(0.07, 0.62), just = "top") +
    tm_credits(label2, position = c(0.07, 0.32), fontface = "italic", just = "bottom") +
    tm_layout(frame = FALSE)
}
9
# # Test code to functionalize:
# theme_set(new = theme_void())
# g1 = ggplot(ps1) + geom_sf(aes(fill = Object), alpha = 0.5, show.legend = FALSE)
# # g1 + annotate("text", x = 0.3, y = 0.9, label = "st_intersects(Polygon1, Polygon2)")
# g1 + annotate("text", x = 0.1, y = 0.95, label = "intersects TRUE\ndisjoint     FALSE\ntouches    TRUE\n", hjust = "left", vjust = "top")
# # Try annotating only which type of relations apply
# # g1 + annotate("text", x = 0.1, y = 0.95, label = "Relations: intersects, touches", hjust = "left", vjust = "top")
# g1an = g1 + 
#
