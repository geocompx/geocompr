# Aim: generate package metrics on common mapping packages
remotes::install_github("ropenscilabs/packagemetrics")

# generic mapping packages ------------------------------------------------
generic_map_pkgs = c(
  "cartography",
  "ggplot2",
  "googleway",
  "ggspatial",
  "leaflet",
  "mapview",
  "plotly",
  "rasterVis",
  "tmap"
)
generic_map_pkgs = packagemetrics::package_list_metrics(generic_map_pkgs)
# pkg_table = packagemetrics::metrics_table(pkg_df)
readr::write_csv(generic_map_pkgs, "extdata/generic_map_pkgs.csv")

# specific purpose mapping packages ---------------------------------------
specific_map_pkgs = c(
  "cartogram",
  "geogrid",
  "geofacet",
  "globe",
  "linemap"
)

specific_map_pkgs = packagemetrics::package_list_metrics(specific_map_pkgs)
# pkg_table = packagemetrics::metrics_table(pkg_df)
readr::write_csv(specific_map_pkgs, "extdata/specific_map_pkgs.csv")
