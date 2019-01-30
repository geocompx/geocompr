## ----03-attribute-operations-1, message=FALSE----------------------------
library(sf)
library(raster)
library(dplyr)
library(stringr) # for working with strings (pattern matching)

## ----03-attribute-operations-2, results='hide'---------------------------
library(spData)

## ----03-attribute-operations-3, eval=FALSE-------------------------------
#> methods(class = "sf") # methods for sf objects, first 12 shown

## ----03-attribute-operations-4-------------------------------------------
#>  [1] aggregate             cbind                 coerce               
#>  [4] initialize            merge                 plot                 
#>  [7] print                 rbind                 [                    
#> [10] [[<-                  $<-                   show                 

## ----03-attribute-operations-5, eval=FALSE, echo=FALSE-------------------
#> # Another way to show sf methods:
#> attributes(methods(class = "sf"))$info %>%
#>   filter(!visible)

## The geometry column of `sf` objects is typically called `geometry` but any name can be used.

## ----03-attribute-operations-7-------------------------------------------
dim(world) # it is a 2 dimensional object, with rows and columns
nrow(world) # how many rows?
ncol(world) # how many columns?

## ----03-attribute-operations-8-------------------------------------------
world_df = st_set_geometry(world, NULL)
class(world_df)

## ----03-attribute-operations-9, eval=FALSE-------------------------------
#> world[1:6, ] # subset rows by position
#> world[, 1:3] # subset columns by position
#> world[, c("name_long", "lifeExp")] # subset columns by name

## ----03-attribute-operations-10------------------------------------------
sel_area = world$area_km2 < 10000
summary(sel_area) # a logical vector
small_countries = world[sel_area, ]

## ----03-attribute-operations-11------------------------------------------
small_countries = world[world$area_km2 < 10000, ]

## ----03-attribute-operations-12, eval=FALSE------------------------------
#> small_countries = subset(world, area_km2 < 10000)

## **raster** and **dplyr** packages have a function called `select()`.

## ----03-attribute-operations-14------------------------------------------
world1 = dplyr::select(world, name_long, pop)
names(world1)

## ----03-attribute-operations-15------------------------------------------
# all columns between name_long and pop (inclusive)
world2 = dplyr::select(world, name_long:pop)

## ----03-attribute-operations-16------------------------------------------
# all columns except subregion and area_km2 (inclusive)
world3 = dplyr::select(world, -subregion, -area_km2)

## ----03-attribute-operations-17------------------------------------------
world4 = dplyr::select(world, name_long, population = pop)
names(world4)

## ----03-attribute-operations-18, eval=FALSE------------------------------
#> world5 = world[, c("name_long", "pop")] # subset columns by name
#> names(world5)[names(world5) == "pop"] = "population" # rename column manually

## ----03-attribute-operations-19, eval=FALSE------------------------------
#> # create throw-away data frame
#> d = data.frame(pop = 1:10, area = 1:10)
#> # return data frame object when selecting a single column
#> d[, "pop", drop = FALSE] # equivalent to d["pop"]
#> select(d, pop)
#> # return a vector when selecting a single column
#> d[, "pop"]
#> pull(d, pop)

## ----03-attribute-operations-20, echo=FALSE, eval=FALSE------------------
#> x1 = d[, "pop", drop = FALSE] # equivalent to d["pop"]
#> x2 = d["pop"]
#> identical(x1, x2)

## ----03-attribute-operations-21, eval = FALSE----------------------------
#> # data frame object
#> world[, "pop"]
#> # vector objects
#> world$pop
#> pull(world, pop)

## ----03-attribute-operations-22, eval=FALSE------------------------------
#> slice(world, 3:5)

## ----03-attribute-operations-23, eval=FALSE------------------------------
#> # Countries with a life expectancy longer than 82 years
#> world6 = filter(world, lifeExp > 82)

## ----operators, echo=FALSE-----------------------------------------------
operators = c("`==`", "`!=`", "`>, <`", "`>=, <=`", "`&, |, !`")
operators_exp = c("Equal to", "Not equal to", "Greater/Less than",
                  "Greater/Less than or equal", 
                  "Logical operators: And, Or, Not")
knitr::kable(tibble(Symbol = operators, Name = operators_exp), 
             caption = paste("Comparison operators that return Booleans",
                             "(TRUE/FALSE)."),
             caption.short = "Comparison operators that return Booleans.",
             booktabs = TRUE)

## ----03-attribute-operations-24------------------------------------------
world7 = world %>%
  filter(continent == "Asia") %>%
  dplyr::select(name_long, continent) %>%
  slice(1:5)

## ----03-attribute-operations-25------------------------------------------
world8 = slice(
  dplyr::select(
    filter(world, continent == "Asia"),
    name_long, continent),
  1:5)

## ----03-attribute-operations-26------------------------------------------
world_agg1 = aggregate(pop ~ continent, FUN = sum, data = world, na.rm = TRUE)
class(world_agg1)

## ----03-attribute-operations-27------------------------------------------
world_agg2 = aggregate(world["pop"], by = list(world$continent),
                       FUN = sum, na.rm = TRUE)
class(world_agg2)

## ----03-attribute-operations-28------------------------------------------
world_agg3 = world %>%
  group_by(continent) %>%
  summarize(pop = sum(pop, na.rm = TRUE))

## ----03-attribute-operations-29, eval=FALSE------------------------------
#> world %>%
#>   summarize(pop = sum(pop, na.rm = TRUE), n = n())

## ----03-attribute-operations-30, eval=FALSE------------------------------
#> world %>%
#>   dplyr::select(pop, continent) %>%
#>   group_by(continent) %>%
#>   summarize(pop = sum(pop, na.rm = TRUE), n_countries = n()) %>%
#>   top_n(n = 3, wt = pop) %>%
#>   st_set_geometry(value = NULL)

## ----continents, echo=FALSE----------------------------------------------
options(scipen = 999)
world %>% 
  dplyr::select(pop, continent) %>% 
  group_by(continent) %>% 
  summarize(pop = sum(pop, na.rm = TRUE), n_countries = n()) %>% 
  top_n(n = 3, wt = pop) %>%
  st_set_geometry(value = NULL) %>% 
  knitr::kable(caption = paste("The top 3 most populous continents,", 
                               "and the number of countries in each."),
               caption.short = "Top 3 most populous continents.",
               booktabs = TRUE)

## More details are provided in the help pages (which can be accessed via `?summarize` and `vignette(package = "dplyr")` and Chapter 5 of [R for Data Science](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarize).

## ----03-attribute-operations-32, warning=FALSE---------------------------
world_coffee = left_join(world, coffee_data)
class(world_coffee)

## ----coffeemap, fig.cap="World coffee production (thousand 60-kg bags) by country, 2017. Source: International Coffee Organization.", fig.scap="World coffee production by country."----
names(world_coffee)
plot(world_coffee["coffee_production_2017"])

## ----03-attribute-operations-33, warning=FALSE---------------------------
coffee_renamed = rename(coffee_data, nm = name_long)
world_coffee2 = left_join(world, coffee_renamed, by = c(name_long = "nm"))

## ----03-attribute-operations-34, eval=FALSE, echo=FALSE------------------
#> identical(world_coffee, world_coffee2)
#> nrow(world)
#> nrow(world_coffee)

## ----03-attribute-operations-35, warning=FALSE---------------------------
world_coffee_inner = inner_join(world, coffee_data)
nrow(world_coffee_inner)

## ----03-attribute-operations-36------------------------------------------
setdiff(coffee_data$name_long, world$name_long)

## ----03-attribute-operations-37------------------------------------------
str_subset(world$name_long, "Dem*.+Congo")

## ----03-attribute-operations-38, eval=FALSE, echo=FALSE------------------
#> # aim: test names in coffee_data and world objects
#> str_subset(coffee_data$name_long, "Ivo|Congo,")
#> .Last.value %in% str_subset(world$name_long, "Ivo|Dem*.+Congo")

## ----03-attribute-operations-39, warning=FALSE---------------------------
coffee_data$name_long[grepl("Congo,", coffee_data$name_long)] = 
  str_subset(world$name_long, "Dem*.+Congo")
world_coffee_match = inner_join(world, coffee_data)
nrow(world_coffee_match)

## ----03-attribute-operations-40, warning=FALSE---------------------------
coffee_world = left_join(coffee_data, world)
class(coffee_world)

## In most cases, the geometry column is only useful in an `sf` object.

## ----03-attribute-operations-42------------------------------------------
world_new = world # do not overwrite our original data
world_new$pop_dens = world_new$pop / world_new$area_km2

## ----03-attribute-operations-43, eval=FALSE------------------------------
#> world %>%
#>   mutate(pop_dens = pop / area_km2)

## ----03-attribute-operations-44, eval=FALSE------------------------------
#> world %>%
#>   transmute(pop_dens = pop / area_km2)

## ----03-attribute-operations-45, eval=FALSE------------------------------
#> world_unite = world %>%
#>   unite("con_reg", continent:region_un, sep = ":", remove = TRUE)

## ----03-attribute-operations-46, eval=FALSE------------------------------
#> world_separate = world_unite %>%
#>   separate(con_reg, c("continent", "region_un"), sep = ":")

## ----03-attribute-operations-47, echo=FALSE, eval=FALSE------------------
#> identical(world, world_separate)

## ----03-attribute-operations-48, eval=FALSE------------------------------
#> world %>%
#>   rename(name = name_long)

## ----03-attribute-operations-49, eval=FALSE, echo=FALSE------------------
#> abbreviate(names(world), minlength = 1) %>% dput()

## ----03-attribute-operations-50, eval=FALSE------------------------------
#> new_names = c("i", "n", "c", "r", "s", "t", "a", "p", "l", "gP", "geom")
#> world %>%
#>   set_names(new_names)

## ----03-attribute-operations-51------------------------------------------
world_data = world %>% st_set_geometry(NULL)
class(world_data)

## ----03-attribute-operations-52, message=FALSE, eval = FALSE-------------
#> elev = raster(nrows = 6, ncols = 6, res = 0.5,
#>               xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
#>               vals = 1:36)

## ----03-attribute-operations-53, eval = FALSE----------------------------
#> grain_order = c("clay", "silt", "sand")
#> grain_char = sample(grain_order, 36, replace = TRUE)
#> grain_fact = factor(grain_char, levels = grain_order)
#> grain = raster(nrows = 6, ncols = 6, res = 0.5,
#>                xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
#>                vals = grain_fact)

## ----03-attribute-operations-54, include = FALSE-------------------------
library(spData)
data("elev")
data("grain")

## `raster` objects can contain values of class `numeric`, `integer`, `logical` or `factor`, but not `character`.

## ----03-attribute-operations-56------------------------------------------
levels(grain)[[1]] = cbind(levels(grain)[[1]], wetness = c("wet", "moist", "dry"))
levels(grain)

## ----03-attribute-operations-57------------------------------------------
factorValues(grain, grain[c(1, 11, 35)])

## ----cont-raster, echo = FALSE, message = FALSE, fig.width = 7, fig.height = 2.5, fig.cap = "Raster datasets with numeric (left) and categorical values (right).", fig.scap="Raster datasets with numeric and categorical values."----
source("https://github.com/Robinlovelace/geocompr/raw/master/code/03-cont-raster-plot.R", print.eval = TRUE)

## ----03-attribute-operations-58, eval = FALSE----------------------------
#> # row 1, column 1
#> elev[1, 1]
#> # cell ID 1
#> elev[1]

## ----03-attribute-operations-59, eval = FALSE----------------------------
#> r_stack = stack(elev, grain)
#> names(r_stack) = c("elev", "grain")
#> # three ways to extract a layer of a stack
#> raster::subset(r_stack, "elev")
#> r_stack[["elev"]]
#> r_stack$elev

## ----03-attribute-operations-60------------------------------------------
elev[1, 1] = 0
elev[]

## ----03-attribute-operations-61------------------------------------------
elev[1, 1:2] = 0

## ----03-attribute-operations-62, eval = FALSE----------------------------
#> cellStats(elev, sd)

## If you provide the `summary()` and `cellStats()` functions with a raster stack or brick object, they will summarize each layer separately, as can be illustrated by running: `summary(brick(elev, grain))`.

## ----03-attribute-operations-64, eval=FALSE------------------------------
#> hist(elev)

## Some function names clash between packages (e.g., `select()`, as discussed in a previous note).

## ----03-attribute-operations-66------------------------------------------
library(spData)
data(us_states)
data(us_states_df)

