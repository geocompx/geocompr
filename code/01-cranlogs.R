# Code to download logs of various packages
# By Robin Lovelace and Colin Gillespie:
# https://github.com/csgillespie/efficientR
# Edited by Jakub Nowosad

# attach the packages -----------------------------------------------------
library(cranlogs)
library(tidyverse)
library(ggplot2)
options(scipen = 99)

# which packages to track:
pkgs = c("sp", "raster", "sf", "terra", "stars")

# read packages downloads -------------------------------------------------
# and calculate rolling median
dd_top = cran_downloads(packages = pkgs, from = "2013-01-01", to = Sys.Date()) %>% 
  group_by(package) %>% 
  mutate(Downloads = zoo::rollmedian(count, k = 91, na.pad = TRUE))

# plot and save -----------------------------------------------------------
ggfig = ggplot(data = dd_top, mapping = aes(date, Downloads, color = package)) +
  geom_line() +
  labs(x = "Date", color = "Package: ") +
  scale_color_brewer(type = "qual", palette = "Set1") +
  theme_bw() +
  scale_y_log10(limits = c(10, NA))
ggfig
ggsave("figures/01-cranlogs.png", ggfig, width = 6, height = 3, dpi = 150)
# magick::image_read("figures/spatial-package-growth.png")
