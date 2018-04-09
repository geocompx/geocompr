# Aim: generate package metrics on common mapping packages
devtools::install_github("ropenscilabs/packagemetrics")
map_pkgs = c(
  "cartography",
  "cartogram",
  "ggplot2",
  "globe",
  "leaflet",
  "maps",
  "mapmisc",
  "mapview",
  "plotly",
  "raster",
  "rasterVis",
  "rworldmap",
  "sf",
  "tmap"
)
map_pkgs = packagemetrics::package_list_metrics(map_pkgs)
# pkg_table = packagemetrics::metrics_table(pkg_df)
readr::write_csv(map_pkgs, "extdata/map_pkgs.csv")
