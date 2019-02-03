# devtools::install_github('walkerke/tigris')
# devtools::install_github('walkerke/tidycensus')
# devtools::install_github('ateucher/rmapshaper', ref = 'sf')
library(tigris)
library(tidycensus)
library(sf)
library(tidyverse)
library(units)
library(rmapshaper)

options(tigris_class = "sf")

# census data -------------------------------------------------------------
census_api_key("YOUR API KEY") # http://api.census.gov/data/key_signup.html

# v15 = load_variables(2015, "acs5", cache = TRUE)
# View(v15)
# v15 %>% select(concept) %>% unique() %>% View
# B01003_001E - total pop

total_pop_10 = get_acs(geography = "state", variables = "B01003_001E", year = 2010) %>% 
  select(GEOID, total_pop_10 = estimate)
total_pop_15 = get_acs(geography = "state", variables = "B01003_001E", year = 2015) %>% 
  select(GEOID, total_pop_15 = estimate)

## groups - Census Bureau-designated regions

# spatial data  -----------------------------------------------------------
us_states = states(cb = TRUE, resolution = '5m') 
us_states_large = states()
# extract regions ---------------------------------------------------------
us_regions = us_states_large %>% 
  filter(DIVISION != 0) %>%
  filter(NAME != "Alaska", NAME != "Hawaii") %>% 
  mutate(REGION = factor(REGION, labels = c("Norteast", "Midwest", "South", "West"))) %>% 
  select(NAME, REGION) %>% 
  st_drop_geometry()

# cont states -------------------------------------------------------------
us_states49 = us_states %>% 
  filter(NAME != "Alaska", NAME != "Hawaii") %>% 
  inner_join(us_regions, by = "NAME") %>% 
  ms_simplify(keep = 0.05) %>% 
  select(GEOID, NAME, REGION) %>%
  mutate(AREA = units::set_units(st_area(.), km^2)) %>% 
  left_join(., total_pop_10, by = "GEOID") %>% 
  left_join(., total_pop_15, by = "GEOID")
  
us_states = us_states49
save(us_states, file = "data/us_states.rda", compress = "bzip2")

# hawaii ------------------------------------------------------------------
hawaii2 = us_states_large %>% 
  filter(DIVISION != 0) %>%
  filter(NAME == "Hawaii") %>% 
  ms_simplify(keep = 0.05, keep_shapes = TRUE, explode = TRUE) %>%
  aggregate(by = list(.$GEOID), first) %>%
  select(GEOID, NAME, REGION) %>%
  mutate(REGION = factor(REGION, labels = c("West"))) %>% 
  mutate(AREA = units::set_units(st_area(.), km^2)) %>% 
  left_join(., total_pop_10, by = "GEOID") %>% 
  left_join(., total_pop_15, by = "GEOID") %>% 
  st_transform("+proj=aea +lat_1=8 +lat_2=18 +lat_0=13 +lon_0=-157 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs ")

# removes island outside Hawaii
hawaii_bbox = st_as_sfc(st_bbox(c(xmin = -450000, xmax = 235806.2, ymax = 1100000, ymin = 650905.7), crs = st_crs(hawaii2)))
hawaii2 = hawaii2 %>% 
  st_intersection(hawaii_bbox)

hawaii = hawaii2

save(hawaii, file = "data/hawaii.rda", compress = "bzip2")
# alaska ------------------------------------------------------------------
alaska = us_states_large %>% 
  filter(DIVISION != 0) %>% 
  filter(NAME == "Alaska") %>% 
  ms_simplify(keep = 0.05, keep_shapes = TRUE, explode = TRUE) %>% 
  aggregate(by = list(.$GEOID), first) %>% 
  select(GEOID, NAME, REGION) %>%
  mutate(REGION = factor(REGION, labels = c("West"))) %>% 
  mutate(AREA = units::set_units(st_area(.), km^2)) %>% 
  left_join(., total_pop_10, by = "GEOID") %>% 
  left_join(., total_pop_15, by = "GEOID") %>% 
  st_transform(3467)

save(alaska, file = "data/alaska.rda", compress = "bzip2")

# non-spatial data --------------------------------------------------------
# B06011_001E - Median income in the past 12 months --!!Total:
median_income_10 = get_acs(geography = "state", variables = "B06011_001E", endyear = 2010) %>% 
  select(NAME, median_income_10 = estimate)
median_income_15 = get_acs(geography = "state", variables = "B06011_001E", endyear = 2015) %>% 
  select(NAME, median_income_15 = estimate)
# B17001_002E - Income in the past 12 months below poverty level:
poverty_level_10 = get_acs(geography = "state", variables = "B17001_002E", endyear = 2010) %>% 
  select(NAME, poverty_level_10 = estimate)
poverty_level_15 = get_acs(geography = "state", variables = "B17001_002E", endyear = 2015) %>% 
  select(NAME, poverty_level_15 = estimate)

us_state_eco = median_income_10 %>% 
  filter(NAME != "Puerto Rico") %>% 
  left_join(median_income_15, by = "NAME") %>% 
  left_join(poverty_level_10, by = "NAME") %>% 
  left_join(poverty_level_15, by = "NAME") %>% 
  rename(state = NAME)

us_states_df = us_state_eco
save(us_states_df, file = "data/us_states_df.rda")