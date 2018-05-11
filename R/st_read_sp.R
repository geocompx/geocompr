#' Fast reading of spatial data into Spatial classes
#' 
#' @description 
#' Wrapper function to read a file with [sf::st_read()] and the convert the result to a `Spatial` data class
#' 
#' @param dsn The path of the data source
#' @param ... Arguments passed to `sf::st_read()`
#' @export
#' @md
#' @examples 
#' x = st_read_sp(system.file("shapes/wrld.gpkg", package = "spData"))
#' class(x)
st_read_sp = function(dsn, ...) {
  x = sf::st_read(dsn, ...)
  as(object = x, Class = "Spatial")
}
