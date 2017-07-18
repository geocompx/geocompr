# devtools::install_github('walkerke/tigris')
# devtools::install_github('walkerke/tidycensus')
library(tigris)
library(tidycensus)
library(sf)
library(tidyverse)
library(units)
options(tigris_class = "sf")

## census data
census_api_key("YOUR API KEY") # http://api.census.gov/data/key_signup.html

# v15 <- load_variables(2015, "acs5", cache = TRUE) 
# View(v15)
# B01003_001E - total pop
# B06011_001E - Median income in the past 12 months --!!Total:

total_pop_10 <- get_acs(geography = "state", variables = "B01003_001E", year = 2010) %>% 
  select(GEOID, total_pop_10 = estimate)
total_pop_15 <- get_acs(geography = "state", variables = "B01003_001E", year = 2015) %>% 
  select(GEOID, total_pop_15 = estimate)

median_income_10 <- get_acs(geography = "state", variables = "B06011_001E", year = 2010) %>% 
  select(GEOID, median_income_10 = estimate)
median_income_15 <- get_acs(geography = "state", variables = "B06011_001E", year = 2015) %>% 
  select(GEOID, median_income_15 = estimate)

## groups - Census Bureau-designated regions
## spatial data 
us_states = states(resolution = "20m") 
us_states49 = us_states %>% 
  filter(DIVISION != 0) %>% 
  filter(NAME != "Alaska", NAME != "Hawaii") %>% 
  select(GEOID, NAME, REGION) %>%
  mutate(REGION = factor(REGION, labels = c("Norteast", "Midwest", "South", "West"))) %>% 
  mutate(AREA = units::set_units(st_area(.), km^2)) %>% 
  left_join(., total_pop_10, by = "GEOID") %>% 
  left_join(., total_pop_15, by = "GEOID") %>% 
  left_join(., median_income_10, by = "GEOID") %>% 
  left_join(., median_income_15, by = "GEOID") 
  
plot(us_states49["REGION"])
