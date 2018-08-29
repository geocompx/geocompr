# Code to download logs of various packages
# By Robin Lovelace and Colin Gillespie:
# https://github.com/csgillespie/efficientR
# Edited by Jakub Nowosad

# attach the packages -----------------------------------------------------
library(cranlogs)
library(tidyverse)
library(ggplot2)

# read packages downloads -------------------------------------------------
# and calculate rolling mean
dd = cranlogs::cran_downloads(packages = c("sp", "raster", "sf", "tmap", 
                                           "spatstat", "leaflet", "ggmap"),
                              from = "2013-01-01", to = Sys.Date()) %>% 
  group_by(package) %>% 
  mutate(Downloads = zoo::rollmean(count, k = 30, na.pad = TRUE))

# extract names of the top 5 packages -------------------------------------
top_pkgs = dd %>% 
  filter(date > (Sys.Date() - 30)) %>% 
  group_by(package) %>%
  dplyr::summarise(Downloads = mean(Downloads, na.rm = TRUE)) %>% 
  top_n(n = 5, wt = Downloads) %>% 
  pull(package)

# filter only the top 5 packages ------------------------------------------
dd = dplyr::filter(dd, Downloads > 0, package %in% top_pkgs)

# plot and save -----------------------------------------------------------
ggfig = ggplot(data = dd, mapping = aes(date, Downloads, color = package)) +
  geom_line() +
  labs(x = "Date", color = "Package: ") +
  scale_color_brewer(type = "qual", palette = "Set1") +
  theme_bw()
ggsave("figures/spatial-package-growth.png", ggfig)
