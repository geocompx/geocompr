library(tidyverse)
library(spData)
library(sf)
# found by searching for "global coffee data"
# u = "http://www.ico.org/prices/m1-exports.pdf"
# download.file(u, "data.pdf")
# install.packages("pdftables") # also requires an api key
# pdftables::convert_pdf(input_file = "data.pdf", output_file = "extdata/coffee-data-messy.csv")
d = read_csv("extdata/coffee-data-messy.csv")
coffee_data = slice(d, -c(1:5)) %>% 
  select(name_long = 1, y16 = 2, y17 = 3) %>% 
  mutate_at(2:3, str_replace, " ", "") %>% 
  mutate_at(2:3, as.integer)
write_csv(coffee_data, "extdata/coffee-data.csv")
world_coffee = left_join(world, coffee_data)
plot(world_coffee[c("y16", "y17")])
# library(tmap)
# qtm(world_coffee, "y17", fill.title = "Thousand 60kg bags")
# tmap_mode("view") # for an interactive version