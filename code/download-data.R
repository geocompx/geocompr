# Code used to download data from external sources

# cycle hire data (OSM)
library(osmdata)
library(dplyr)
library(sf)
q = add_feature(opq = opq("London"), key = "network", value = "tfl_cycle_hire")
lnd_cycle_hire = osmdata_sf(q)
lnd_cycle_p = lnd_cycle_hire$osm_points
names(lnd_cycle_p)
lnd_cycle_p_mini = select(lnd_cycle_p, osm_id, name, capacity, cyclestreets_id, description)
cycle_hire_osm = lnd_cycle_p_mini
devtools::use_data(cycle_hire_osm)

object.size(lnd_cycle_p) / 1000000
object.size(lnd_cycle_p_mini) / 1000000

# cycle hire data (official)
cycle_hire = cycle_hire_orig = readr::read_csv("http://cyclehireapp.com/cyclehirelive/cyclehire.csv", col_names = FALSE, skip = TRUE)
c_names = c("id", "name", "area", "lat", "lon", "nbikes", "nempty")
names(cycle_hire) = c_names
cycle_hire_small = cycle_hire[c_names]
cycle_hire = st_as_sf(cycle_hire_small, coords = c("lon", "lat"))
plot(cycle_hire) # looks right
class(cycle_hire) # class sf and tbl
devtools::use_data(cycle_hire)

