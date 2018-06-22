## ---- message=FALSE------------------------------------------------------
library(sf)
library(raster)
library(tidyverse)

## ---- results='hide'-----------------------------------------------------
library(spData)

## ---- eval=FALSE---------------------------------------------------------
## methods(class = "sf") # methods for sf objects, first 12 shown

## ------------------------------------------------------------------------
#>  [1] aggregate             cbind                 coerce               
#>  [4] initialize            merge                 plot                 
#>  [7] print                 rbind                 [                    
#> [10] [[<-                  $<-                   show                 

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # Another way to show sf methods:
## attributes(methods(class = "sf"))$info %>%
##   filter(!visible)

## The geometry column of `sf` objects is typically called `geometry` but any name can be used.

## ------------------------------------------------------------------------
dim(world) # it is a 2 dimensional object, with rows and columns
nrow(world) # how many rows?
ncol(world) # how many columns?

## ------------------------------------------------------------------------
world_df = st_set_geometry(world, NULL)
class(world_df)

## ---- eval=FALSE---------------------------------------------------------
## world[1:6, ] # subset rows by position
## world[, 1:3] # subset columns by position
## world[, c("name_long", "lifeExp")] # subset columns by name

## ------------------------------------------------------------------------
sel_area = world$area_km2 < 10000
summary(sel_area) # a logical vector
small_countries = world[sel_area, ]

## ------------------------------------------------------------------------
small_countries = world[world$area_km2 < 10000, ]

## ---- eval=FALSE---------------------------------------------------------
## small_countries = subset(world, area_km2 < 10000)

## **raster** and **dplyr** packages have a function called `select()`.

## ------------------------------------------------------------------------
world1 = dplyr::select(world, name_long, pop)
names(world1)

## ------------------------------------------------------------------------
# all columns between name_long and pop (inclusive)
world2 = dplyr::select(world, name_long:pop)

## ------------------------------------------------------------------------
# all columns except subregion and area_km2 (inclusive)
world3 = dplyr::select(world, -subregion, -area_km2)

## ------------------------------------------------------------------------
world4 = dplyr::select(world, name_long, population = pop)
names(world4)

## ---- eval=FALSE---------------------------------------------------------
## world5 = world[, c("name_long", "pop")] # subset columns by name
## names(world5)[names(world5) == "pop"] = "population" # rename column manually

## ---- eval=FALSE---------------------------------------------------------
## # create throw-away dataframe
## d = data.frame(pop = 1:10, area = 1:10)
## # return dataframe object when selecting a single column
## d[, "pop", drop = FALSE]
## select(d, pop)
## # return a vector when selecting a single column
## d[, "pop"]
## pull(d, pop)

## ---- eval = FALSE-------------------------------------------------------
## # dataframe object
## world[, "pop"]
## # vector objects
## world$pop
## pull(world, pop)

## ---- eval=FALSE---------------------------------------------------------
## slice(world, 3:5)

## ---- eval=FALSE---------------------------------------------------------
## # Countries with a life expectancy longer than 82 years
## world6 = filter(world, lifeExp > 82)

## ----operators, echo=FALSE-----------------------------------------------
operators = c("`==`", "`!=`", "`>, <`", "`>=, <=`", "`&, |, !`")
operators_exp = c("Equal to", "Not equal to", "Greater/Less than", "Greater/Less than or equal", "Logical operators: And, Or, Not")
knitr::kable(data_frame(Symbol = operators, Name = operators_exp), caption = "Table of comparison operators that result in boolean (TRUE/FALSE) outputs.")

## ------------------------------------------------------------------------
world7 = world %>%
  filter(continent == "Asia") %>%
  dplyr::select(name_long, continent) %>%
  slice(1:5)

## ------------------------------------------------------------------------
world8 = slice(
  dplyr::select(
    filter(world, continent == "Asia"),
    name_long, continent),
  1:5)

## ------------------------------------------------------------------------
world_agg1 = aggregate(pop ~ continent, FUN = sum, data = world, na.rm = TRUE)
class(world_agg1)

## ------------------------------------------------------------------------
world_agg2 = aggregate(world["pop"], by = list(world$continent),
                       FUN = sum, na.rm = TRUE)
class(world_agg2)

## ------------------------------------------------------------------------
world_agg3 = world %>%
  group_by(continent) %>%
  summarize(pop = sum(pop, na.rm = TRUE))

## ---- eval=FALSE---------------------------------------------------------
## world %>%
##   summarize(pop = sum(pop, na.rm = TRUE), n = n())

## ---- eval=FALSE---------------------------------------------------------
## world %>%
##   dplyr::select(pop, continent) %>%
##   group_by(continent) %>%
##   summarize(pop = sum(pop, na.rm = TRUE), n_countries = n()) %>%
##   top_n(n = 3, wt = pop) %>%
##   st_set_geometry(value = NULL)

## ----continents, echo=FALSE----------------------------------------------
options(scipen = 999)
world %>% 
  dplyr::select(pop, continent) %>% 
  group_by(continent) %>% 
  summarize(pop = sum(pop, na.rm = TRUE), n_countries = n()) %>% 
  top_n(n = 3, wt = pop) %>%
  st_set_geometry(value = NULL) %>% 
  knitr::kable(caption = "The top 3 most populous continents, and the number of countries in each.")

## More details are provided in the help pages (which can be accessed via `?summarize` and `vignette(package = "dplyr")` and Chapter 5 of [R for Data Science](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarize).

## ------------------------------------------------------------------------
world_coffee = left_join(world, coffee_data)
class(world_coffee)

## ----coffeemap, fig.cap="World coffee production (thousand 60 kg bags) by country, 2017. Source: International Coffee Organization."----
names(world_coffee)
plot(world_coffee["coffee_production_2017"])

## ------------------------------------------------------------------------
coffee_renamed = rename(coffee_data, nm = name_long)
world_coffee2 = left_join(world, coffee_renamed, by = c(name_long = "nm"))

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## identical(world_coffee, world_coffee2)
## nrow(world)
## nrow(world_coffee)

## ------------------------------------------------------------------------
world_coffee_inner = inner_join(world, coffee_data)
nrow(world_coffee_inner)

## ------------------------------------------------------------------------
setdiff(coffee_data$name_long, world$name_long)

## ------------------------------------------------------------------------
str_subset(world$name_long, "Ivo|Cong")

## ------------------------------------------------------------------------
coffee_data_match = mutate_if(coffee_data, is.character, recode,
            `Congo, Dem. Rep. of` = "Democratic Republic of the Congo",
            `Côte d'Ivoire` = "Ivory Coast")
world_coffee_match = inner_join(world, coffee_data_match)
nrow(world_coffee_match)

## ------------------------------------------------------------------------
coffee_world = left_join(coffee_data_match, world)
class(coffee_world)

## In most cases the geometry column is only useful in an `sf` object.

## ------------------------------------------------------------------------
world_new = world # do not overwrite our original data
world_new$pop_dens = world_new$pop / world_new$area_km2

## ---- eval=FALSE---------------------------------------------------------
## world %>%
##   mutate(pop_dens = pop / area_km2)

## ---- eval=FALSE---------------------------------------------------------
## world %>%
##   transmute(pop_dens = pop / area_km2)

## ---- eval=FALSE---------------------------------------------------------
## world_unite = world %>%
##   unite("con_reg", continent:region_un, sep = ":", remove = TRUE)

## ---- eval=FALSE---------------------------------------------------------
## world_separate = world_unite %>%
##   separate(con_reg, c("continent", "region_un"), sep = ":")

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## identical(world, world_separate)

## ---- eval=FALSE---------------------------------------------------------
## world %>%
##   rename(name = name_long)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## abbreviate(names(world), minlength = 1) %>% dput()

## ---- eval=FALSE---------------------------------------------------------
## new_names = c("i", "n", "c", "r", "s", "t", "a", "p", "l", "gP", "geom")
## world %>%
##   set_names(new_names)

## ------------------------------------------------------------------------
world_data = world %>% st_set_geometry(NULL)
class(world_data)

## ---- message=FALSE, eval = FALSE----------------------------------------
## elev = raster(nrow = 6, ncol = 6, res = 0.5,
##               xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
##               vals = 1:36)

## ---- eval = FALSE-------------------------------------------------------
## grain_order = c("clay", "silt", "sand")
## grain_char = sample(grain_order, 36, replace = TRUE)
## grain_fact = factor(grain_char, levels = grain_order)
## grain = raster(nrow = 6, ncol = 6, res = 0.5,
##                xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
##                vals = grain_fact)

## ---- include = FALSE----------------------------------------------------
library(spData)
data("elev")
data("grain")

## `raster` objects can contain values of class `numeric`, `integer`, `logical` or `factor`, but not `character`.

## ------------------------------------------------------------------------
levels(grain)[[1]] = cbind(levels(grain)[[1]], wetness = c("wet", "moist", "dry"))
levels(grain)

## ------------------------------------------------------------------------
factorValues(grain, grain[c(1, 11, 35)])

## ----cont-raster, echo = FALSE, message = FALSE, fig.width = 7, fig.height = 3, fig.cap = "Raster datasets with numeric (left) and categorical values (right)."----
source("code/03-cont-raster-plot.R")

## ---- eval = FALSE-------------------------------------------------------
## # row 1, column 1
## elev[1, 1]
## # cell ID 1
## elev[1]

## ---- eval = FALSE-------------------------------------------------------
## r_stack = stack(elev, grain)
## names(r_stack) = c("elev", "grain")
## # three ways to extract a layer of a stack
## raster::subset(r_stack, "elev")
## r_stack[["elev"]]
## r_stack$elev

## ------------------------------------------------------------------------
elev[1, 1] = 0
elev[]

## ------------------------------------------------------------------------
elev[1, 1:2] = 0

## ---- eval = FALSE-------------------------------------------------------
## cellStats(elev, sd)

## If you provide the `summary()` and `cellStats()` functions with a raster stack or brick object, they will summarize each layer separately, as can be illustrated by running: `summary(brick(elev, grain))`

## ---- eval=FALSE---------------------------------------------------------
## hist(elev)

## Some function names clash between packages (e.g. `select`, as discussed in a previous note).

## ------------------------------------------------------------------------
library(spData)
data(us_states)
data(us_states_df)

