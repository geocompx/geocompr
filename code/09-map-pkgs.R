# Aim: generate package metrics on common mapping packages
devtools::install_github("ropenscilabs/packagemetrics")
map_pkgs = c(
  "cartography",
  "ggmap",
  "globe",
  "maps",
  "mapmisc",
  "plotly",
  "raster",
  "rworldmap",
  "sf",
  "tmap"
)
library(packagemetrics)
library(tidyverse)
map_pkgs = packagemetrics::package_list_metrics(map_pkgs)
# pkg_table = packagemetrics::metrics_table(pkg_df)
write_csv(map_pkgs, "extdata/map_pkgs.csv")
