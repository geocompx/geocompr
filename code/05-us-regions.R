# # with base R ----
# old_par = par()
# breaks = c(1e5, 5e6, 1e7, 7e7, 2e8)
# rdf = st_set_geometry(regions, NULL)
# us_states$region_pop = inner_join(dplyr::select(us_states, REGION),
#                                   dplyr::select(rdf, Group.1, total_pop_15),
#                                   by = c("REGION" = "Group.1")) %>% 
#   pull(total_pop_15)
# 
# par(mfrow = c(1, 2))
# plot(us_states[, "total_pop_15"], main = "US states", breaks = breaks, key.pos = NULL)
# plot(regions[, "total_pop_15"], main = "US regions", breaks = breaks, key.pos = NULL)
# par(old_par)
# with tmap ----
library(tmap)
us_states_facet = dplyr::select(us_states, REGION, total_pop_15) %>%
  mutate(Level = "State")
regions_facet = rename(regions, REGION = Group.1) %>%
  mutate(Level = "Region")
us_facet = rbind(us_states_facet, regions_facet) %>% 
  mutate(Level = factor(Level, levels = c("State", "Region")))

qtm(us_facet, "total_pop_15") +
  tm_facets(by = "Level", nrow = 1, drop.units = TRUE)