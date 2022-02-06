library(tmap)
library(dplyr)
library(tidyr)
library(sf)

statepop = historydata::us_state_populations %>%
  dplyr::select(-GISJOIN) %>% rename(NAME = state)
statepop_wide = spread(statepop, year, population, sep = "_")
statepop_sf = left_join(spData::us_states, statepop_wide, by = "NAME") %>% 
  st_transform(2163)
year_vars = names(statepop_sf)[grepl("year", names(statepop_sf))]
facet_anim = tm_shape(statepop_sf) + tm_fill(year_vars) + tm_facets(free.scales.fill = FALSE, 
                                                                    ncol = 1, nrow = 1)
tmap_animation(tm = facet_anim, filename = "figures/09-us_pop.gif")