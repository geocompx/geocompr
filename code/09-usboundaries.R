# Aim: create animation showing shifting US boundaries
# depends on 17 MB USAboundariesData package
# link to script file that shows chaning state boundaries
# install.packages("USAboundaries")
library(USAboundaries)
dates = lubridate::as_date(unique(historydata::us_state_populations$year))
# USAboundaries::us_boundaries(map_date = dates[1])
# ...
library(tmap)
statepop = historydata::us_state_populations %>%
  dplyr::select(-GISJOIN) %>% rename(NAME = state)
statepop_wide = spread(statepop, year, population, sep = "_")
statepop_sf = left_join(spData::us_states, statepop_wide) %>% 
  st_transform(2163)
# map_dbl(statepop_sf, ~sum(is.na(.)))  # looks about right
year_vars = names(statepop_sf)[grepl("year", names(statepop_sf))]
facet_anim = tm_shape(statepop_sf) + tm_fill(year_vars) + tm_facets(free.scales.fill = FALSE, 
                                                                    ncol = 1, nrow = 1)
animation_tmap(tm = facet_anim, filename = "figures/09-us_pop.gif")