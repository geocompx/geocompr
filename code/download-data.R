# Code used to download data from external sources

# cycle hire data (OSM) ---------------------------------------------------------
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

# cycle hire data (official) ---------------------------------------------------
library(osmdata)
library(dplyr)
library(sf)
cycle_hire = cycle_hire_orig = readr::read_csv("http://cyclehireapp.com/cyclehirelive/cyclehire.csv", col_names = FALSE, skip = TRUE)
c_names = c("id", "name", "area", "lat", "lon", "nbikes", "nempty")
names(cycle_hire) = c_names
cycle_hire_small = cycle_hire[c_names]
cycle_hire = st_as_sf(cycle_hire_small, coords = c("lon", "lat"))
plot(cycle_hire) # looks right
class(cycle_hire) # class sf and tbl
devtools::use_data(cycle_hire)


# worldbank  ---------------------------------------------------
# install.packages("wbstats")
# devtools::install_github("ropenscilabs/rnaturalearth")
library(wbstats)
library(rnaturalearth)
library(tidyverse)
library(sf)
library(viridis)

# query_lifeexp <- wbsearch(pattern = "life expectancy")
# query_gdp <- wbsearch("GDP")

wb_data_create <- function(indicator, our_name, year, ...){
        df <- wb(indicator = indicator, startdate = year, enddate = year, ...) %>%
                as_data_frame() %>%
                select(iso_a2=iso2c, value) %>%
                mutate(indicator = our_name) %>%
                spread(indicator, value)
        return(df)
}

## IMPORTANT - repeat if a server is down

data_pop <- wb_data_create(indicator = "SP.POP.TOTL", our_name = "pop", year = 2014, country = "countries_only")
data_lifeexp <- wb_data_create(indicator = "SP.DYN.LE00.IN", our_name = "lifeExp", year = 2014, country = "countries_only")
data_gdp <- wb_data_create("NY.GDP.PCAP.PP.KD", "gdpPercap", year = 2014, country = "countries_only")

world_sf <- ne_countries(returnclass = 'sf') %>%
        left_join(., data_pop, by = c('iso_a2')) %>%
        left_join(., data_lifeexp, by = c('iso_a2')) %>%
        left_join(., data_gdp, by = c('iso_a2')) %>%
        mutate(area_km2 = raster::area(as(., "Spatial")) / 1000000) %>%
        select(iso_a2, name_long, continent, region_un, subregion, type, area_km2, pop, lifeExp, gdpPercap)

# world_sf %>% st_write(., 'data/wrld.gpkg')

plot(world_sf)
ggplot(world_sf, aes(fill=pop)) +
        geom_sf() +
        scale_fill_viridis() +
        theme_void()

# yellowstone borders ---------------------------------------------
library(sf)
download.file("http://www.wsgs.wyo.gov/gis-files/yellowstoneboundary.zip", "data/yellowstoneboundary.zip")
unzip("data/yellowstoneboundary.zip", exdir = "data")
st_read('data/YellowstoneBoundary/boundary.shp') %>% 
  st_transform(., 2246) %>% 
  st_write('data/yellowstone.gpkg')
file.remove('data/yellowstoneboundary.zip')
unlink('data/YellowstoneBoundary/', recursive = TRUE)

