#' # example for tmap
#' library(tmap)
#' m = qtm(world) +
#'   tm_shape(urban_agglomerations) +
#'   tm_dots(size = "population_millions") +
#'   tm_facets(by = "year")
#' f = "/tmp/urban-animated-print.png"
save_print_quality = function(m = NULL, f, width = 2000, height = 2000) {
  if(!is.null(m)) {
    if(is(object = m, class2 = "tmap")) {
      tmap::tmap_save(tm = m, filename = f, width = width, height = height)
    }
  }
  i = magick::image_read(f)
  i_clean = magick::image_trim(i)
  magick::image_write(i_clean, f)
}
