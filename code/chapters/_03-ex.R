## ----03-ex-e0, include=TRUE, message=FALSE----------------------------------------------------------------------------------------------------------------
library(sf)
library(dplyr)
library(terra)
library(spData)
data(us_states)
data(us_states_df)


## ----03-ex-e1---------------------------------------------------------------------------------------------------------------------------------------------
us_states_name = us_states["NAME"]
class(us_states_name)
attributes(us_states_name)
attributes(us_states_name$geometry)


## - It is of class `sf` and `data.frame`: it has 2 classes.

## - It is the `sf` class that makes in geographic.

## - More specifically it is the attributes of the object (`sf_column`) and the geometry column (such as `bbox`, `crs`) that make it geographic.


## ----03-ex-e2---------------------------------------------------------------------------------------------------------------------------------------------
us_states |> dplyr::select(total_pop_10, total_pop_15)

# or
us_states |> dplyr::select(starts_with("total_pop"))

# or
us_states |> dplyr::select(contains("total_pop"))

# or
us_states |> dplyr::select(matches("tal_p"))


## ----03-ex-e3---------------------------------------------------------------------------------------------------------------------------------------------
us_states |> 
  filter(REGION == "Midwest")

us_states |> filter(REGION == "West", AREA < units::set_units(250000, km^2), total_pop_15 > 5000000)
# or
us_states |> filter(REGION == "West", as.numeric(AREA) < 250000, total_pop_15 > 5000000)

us_states |> filter(REGION == "South", AREA > units::set_units(150000, km^2), total_pop_15 > 7000000)
# or
us_states |> filter(REGION == "South", as.numeric(AREA) > 150000, total_pop_15 > 7000000)


## ----03-ex-e4---------------------------------------------------------------------------------------------------------------------------------------------
us_states |> summarize(total_pop = sum(total_pop_15),
                        min_pop = min(total_pop_15),
                        max_pop = max(total_pop_15))


## ----03-ex-e5---------------------------------------------------------------------------------------------------------------------------------------------
us_states |>
  group_by(REGION) |>
  summarize(nr_of_states = n())


## ----03-ex-e6---------------------------------------------------------------------------------------------------------------------------------------------
us_states |>
  group_by(REGION) |>
  summarize(min_pop = min(total_pop_15),
            max_pop = max(total_pop_15),
            tot_pop = sum(total_pop_15))


## ----03-ex-e7---------------------------------------------------------------------------------------------------------------------------------------------
us_states_stats = us_states |>
  left_join(us_states_df, by = c("NAME" = "state"))
class(us_states_stats)


## ----03-ex-e8---------------------------------------------------------------------------------------------------------------------------------------------
us_states_df |>
  anti_join(st_drop_geometry(us_states), by = c("state" = "NAME"))


## ----03-ex-e9---------------------------------------------------------------------------------------------------------------------------------------------
us_states2 = us_states |>
  mutate(pop_dens_15 = total_pop_15/AREA,
         pop_dens_10 = total_pop_10/AREA)


## ----03-ex-e10--------------------------------------------------------------------------------------------------------------------------------------------
us_popdens_change = us_states2 |>
  mutate(pop_dens_diff_10_15 = pop_dens_15 - pop_dens_10,
         pop_dens_diff_10_15p = (pop_dens_diff_10_15/pop_dens_15) * 100)
plot(us_popdens_change["pop_dens_diff_10_15p"])


## ----03-ex-e11--------------------------------------------------------------------------------------------------------------------------------------------
us_states %>%
  setNames(tolower(colnames(.)))


## ----03-ex-e12--------------------------------------------------------------------------------------------------------------------------------------------
us_states_sel = us_states |>
  left_join(us_states_df, by = c("NAME" = "state")) |>
  dplyr::select(Income = median_income_15)


## ----03-ex-e13--------------------------------------------------------------------------------------------------------------------------------------------
us_pov_change = us_states |>
  left_join(us_states_df, by = c("NAME" = "state")) |>
  mutate(pov_change = poverty_level_15 - poverty_level_10)
 
# Bonus
us_pov_pct_change = us_states |>
  left_join(us_states_df, by = c("NAME" = "state")) |>
  mutate(pov_pct_10 = (poverty_level_10 / total_pop_10) * 100, 
         pov_pct_15 = (poverty_level_15 / total_pop_15) * 100) |>
  mutate(pov_pct_change = pov_pct_15 - pov_pct_10)


## ----03-ex-e14--------------------------------------------------------------------------------------------------------------------------------------------
us_pov_change_reg = us_pov_change |>
  group_by(REGION) |>
  summarize(min_state_pov_15 = min(poverty_level_15),
            mean_state_pov_15 = mean(poverty_level_15),
            max_state_pov_15 = max(poverty_level_15))

# Bonus
us_pov_change |>
  group_by(REGION) |>
  summarize(region_pov_change = sum(pov_change)) |>
  filter(region_pov_change == max(region_pov_change)) |>
  pull(REGION) |>
  as.character()


## ----03-ex-e15--------------------------------------------------------------------------------------------------------------------------------------------
r = rast(nrow = 9, ncol = 9, res = 0.5,
         xmin = 0, xmax = 4.5, ymin = 0, ymax = 4.5,
         vals = rnorm(81))
# using cell IDs
r[c(1, 9, 81 - 9 + 1, 81)]
r[c(1, nrow(r)), c(1, ncol(r))]


## ----03-ex-e16--------------------------------------------------------------------------------------------------------------------------------------------
grain = rast(system.file("raster/grain.tif", package = "spData"))
freq(grain) |> 
  arrange(-count )# the most common classes are silt and sand (13 cells)


## ----03-ex-e17--------------------------------------------------------------------------------------------------------------------------------------------
dem = rast(system.file("raster/dem.tif", package = "spDataLarge"))
hist(dem)
boxplot(dem)

# we can also use ggplot2 after converting SpatRaster to a data frame
library(ggplot2)
ggplot(as.data.frame(dem), aes(dem)) + geom_histogram()
ggplot(as.data.frame(dem), aes(dem)) + geom_boxplot()

