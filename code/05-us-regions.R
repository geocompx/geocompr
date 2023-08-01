library(tmap)
library(spData)
library(dplyr)
library(sf)

regions = aggregate(x = us_states[, "total_pop_15"], by = list(us_states$REGION),
                    FUN = sum, na.rm = TRUE)
us_states_facet = select(us_states, REGION, total_pop_15) |>
  mutate(Level = "State")
regions_facet = dplyr::rename(regions, REGION = Group.1) |>
  mutate(Level = "Region")
us_facet = rbind(us_states_facet, regions_facet) |>
  mutate(Level = factor(Level, levels = c("State", "Region"))) |>
  st_cast("MULTIPOLYGON")

tm_shape(us_facet) +
  tm_polygons("total_pop_15", fill.legend = tm_legend("Total population:")) +
  tm_facets(by = "Level", ncols = 2, drop.units = TRUE)