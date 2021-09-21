# Code to download logs of various packages
# By Robin Lovelace and Colin Gillespie:
# https://github.com/csgillespie/efficientR
# Edited by Jakub Nowosad

# attach the packages -----------------------------------------------------
library(cranlogs)
library(tidyverse)
library(ggplot2)

# which packages to track:
pkgs = c("sp", "raster", "sf", "terra", 
         "raster", "stars")

# read packages downloads -------------------------------------------------
# and calculate rolling mean
dd = cran_downloads(packages = pkgs, from = "2013-01-01", to = Sys.Date()) %>% 
  group_by(package) %>% 
  mutate(Downloads = zoo::rollmean(count, k = 30, na.pad = TRUE))

# extract names of the top 5 packages -------------------------------------
top_pkgs = dd %>% 
  filter(date > (Sys.Date() - 30)) %>% 
  group_by(package) %>%
  dplyr::summarise(Downloads = mean(Downloads, na.rm = TRUE)) %>% 
  top_n(n = 8, wt = Downloads) %>% 
  pull(package)

# filter only the top 5 packages ------------------------------------------
dd_top = dplyr::filter(dd, Downloads > 0, package %in% top_pkgs)

# plot and save -----------------------------------------------------------
ggfig = ggplot(data = dd_top, mapping = aes(date, Downloads, color = package)) +
  geom_line() +
  labs(x = "Date", color = "Package: ") +
  scale_color_brewer(type = "qual", palette = "Set1") +
  theme_bw() +
  scale_y_log10(limits = c(10, NA))
ggfig
ggsave("figures/spatial-package-growth.png", ggfig, width = 6, height = 3, dpi = 150)
# magick::image_read("figures/spatial-package-growth.png")
