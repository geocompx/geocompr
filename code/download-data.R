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
# remotes::install_github("ropenscilabs/rnaturalearth")
library(wbstats)
library(rnaturalearth)
library(tidyverse)
library(sf)
library(viridis)

# query_lifeexp = wbsearch(pattern = "life expectancy")
# query_gdp = wbsearch("GDP")

wb_data_create = function(indicator, our_name, year, ...){
        df = wb(indicator = indicator, startdate = year, enddate = year, ...) %>%
                as_data_frame() %>%
                select(iso_a2=iso2c, value) %>%
                mutate(indicator = our_name) %>%
                spread(indicator, value)
        return(df)
}

## IMPORTANT - repeat if a server is down

data_pop = wb_data_create(indicator = "SP.POP.TOTL", our_name = "pop", year = 2014, country = "countries_only")
data_lifeexp = wb_data_create(indicator = "SP.DYN.LE00.IN", our_name = "lifeExp", year = 2014, country = "countries_only")
data_gdp = wb_data_create("NY.GDP.PCAP.PP.KD", "gdpPercap", year = 2014, country = "countries_only")

world_sf = ne_countries(returnclass = 'sf') %>%
        left_join(., data_pop, by = c('iso_a2')) %>%
        left_join(., data_lifeexp, by = c('iso_a2')) %>%
        left_join(., data_gdp, by = c('iso_a2')) %>%
        mutate(area_km2 = raster::area(as(., "Spatial")) / 1000000) %>%
        select(iso_a2, name_long, continent, region_un, subregion, type, area_km2, pop, lifeExp, gdpPercap)

# world_sf %>% st_write(., 'wrld.gpkg')

plot(world_sf)
ggplot(world_sf, aes(fill=pop)) +
        geom_sf() +
        scale_fill_viridis() +
        theme_void()

# zion borders ---------------------------------------------
library(sf)
library(tidyverse)

dir.create('data')
download.file("https://irma.nps.gov/DataStore/DownloadFile/570816", "data/nps_boundary.zip")
unzip("data/nps_boundary.zip", exdir = "data")
st_read('data/nps_boundary.shp') %>%
  filter(PARKNAME=="Zion") %>% 
  st_transform(., 26912) %>% 
  st_write('data/zion.gpkg', delete_dsn = TRUE)

dir(path="data", pattern="nps_boundary.*", full.names = TRUE) %>%
  file.remove(.)

# landsat -------------------------------------------------------
# https://aws.amazon.com/public-data-sets/landsat/
download_landsat8 = function(destination_filename, band){
  filename = paste0("http://landsat-pds.s3.amazonaws.com/L8/038/034/LC80380342015230LGN00/LC80380342015230LGN00_B", band, ".TIF")
  download.file(filename, destination_filename, method='auto')
}

download_landsat8('data/landsat_b2.tif', 2)
download_landsat8('data/landsat_b3.tif', 3)
download_landsat8('data/landsat_b4.tif', 4)
download_landsat8('data/landsat_b5.tif', 5)

# landsat crop
library(raster)
zion = st_read('data/zion.gpkg') %>% 
  st_buffer(., 500) %>% 
  as(., "Spatial") %>% 
  extent(.)

zion_crop = function(landsat_filename, zion){
  new_name = paste0(stringr::str_sub(landsat_filename, end=-5), '_zion.tif')
  landsat_filename %>% 
    raster(.) %>% 
    crop(., zion) %>% 
    writeRaster(., new_name, overwrite=TRUE, datatype="INT2U", options=c("COMPRESS=DEFLATE"))
  landsat_filename %>%
    file.remove(.)
}

zion_landsats = c('data/landsat_b2.tif',
                   'data/landsat_b3.tif',
                   'data/landsat_b4.tif',
                   'data/landsat_b5.tif')

zion_landsats %>% 
  map(~zion_crop(., zion))

### worldbank data -------------------------------------------------------------
library(wbstats)
library(tidyverse)
library(sf)
library(rnaturalearth)


wbsearch("HDI")
wbsearch("urbanization")
wbsearch("unemployment")
wbsearch("Population growth rate")
wbsearch("literacy")
# wbsearch("poverty")
# wbsearch("migration")
# wbsearch("net exports")
wbsearch("education")
# worldbank wiki

# query_lifeexp = wbsearch(pattern = "life expectancy")
# query_gdp = wbsearch("GDP")

wb_data_create = function(indicator, our_name, year, ...){
  df = wb(indicator = indicator, startdate = year, enddate = year, ...) %>%
    as_data_frame() %>%
    select(iso_a2=iso2c, value) %>%
    mutate(indicator = our_name) %>%
    spread(indicator, value)
  return(df)
}

## IMPORTANT - repeat if a server is down

data_hdi = wb_data_create(indicator = "UNDP.HDI.XD", our_name = "HDI", year = 2011, country = "countries_only")
data_urbanpop = wb_data_create(indicator = "SP.URB.TOTL", our_name = "urban_pop", year = 2014, country = "countries_only")
data_unemployment = wb_data_create(indicator = "SL.UEM.TOTL.NE.ZS", our_name = "unemployment", year = 2014, country = "countries_only")
data_popgrowth = wb_data_create(indicator = "SP.POP.GROW", our_name = "pop_growth", year = 2014, country = "countries_only")
data_literacy = wb_data_create(indicator = "SE.ADT.LITR.ZS", our_name = "literacy", year = 2014, country = "countries_only")
# data_tertiary_edu_per_100000 = wb_data_create(indicator = "UIS.TE_100000.56", our_name = "tertiary_edu_per_100000", year = 2014, country = "countries_only")

country_names = ne_countries(returnclass = 'sf') %>%
  select(name = name_long, iso_a2) %>%
  st_drop_geometry()
  
world_df = data_hdi %>% 
  full_join(., data_urbanpop, by = c('iso_a2')) %>%
  full_join(., data_unemployment, by = c('iso_a2')) %>%
  full_join(., data_popgrowth, by = c('iso_a2')) %>% 
  full_join(., data_literacy, by = c('iso_a2')) %>%
  # full_join(., data_tertiary_edu_per_100000, by = c('iso_a2')) %>% 
  right_join(., country_names, by = c('iso_a2')) %>% 
  select(name, everything()) %>% 
  mutate(name = stringi::stri_trans_general(name, "latin-ascii"))

write_csv(worldbank_df, 'data/worldbank_df.csv')
save(worldbank_df, file = "data/worldbank_df.rda", compress = "bzip2")
