# Code to download logs of various packages
# By Robin Lovelace and Colin Gillespie:
# https://github.com/csgillespie/efficientR
library(cranlogs)
library(tidyverse)
# exclude maps 
dd = cranlogs::cran_downloads(packages = c("sp", "raster", "sf", "tmap", "spatstat", "leaflet", "ggmap"),
                              from = "2013-01-01", to = Sys.Date())
dd$Downloads <- ave(
  dd$count,
  dd$package,
  FUN = function(x)
    zoo::rollmean(x, k = 30, na.pad = T)
)
top_pkgs = dd %>% 
  filter(date > (Sys.Date() - 30)) %>% 
  group_by(package) %>%
  summarise(Downloads = mean(Downloads, na.rm = TRUE)) %>% 
  top_n(n = 5, wt = Downloads) %>% 
  pull(package)
dd = dplyr::filter(dd, Downloads > 0, package %in% top_pkgs)

library(ggplot2)
ggfig = ggplot(data = dd, mapping = aes(date, Downloads, color = package)) +
  geom_line() +
  labs(x = "Date", color = "Package: ")
ggsave("figures/spatial-package-growth.png", ggfig)
