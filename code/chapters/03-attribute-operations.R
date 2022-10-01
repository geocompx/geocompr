## ----03-attribute-operations-1, message=FALSE-------------------------------------------------------------------------------------------------------------
library(sf)      # vector data package introduced in Chapter 2
library(terra)   # raster data package introduced in Chapter 2
library(dplyr)   # tidyverse package for data frame manipulation


## ----03-attribute-operations-2, results='hide'------------------------------------------------------------------------------------------------------------
library(spData)  # spatial data package introduced in Chapter 2


## ---- eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
## # Aim: find a bus stop in central London
## library(osmdata)
## london_coords = c(-0.1, 51.5)
## london_bb = c(-0.11, 51.49, -0.09, 51.51)
## bb = tmaptools::bb(london_bb)
## osm_data = opq(bbox = london_bb) |>
##   add_osm_feature(key = "highway", value = "bus_stop") |>
##   osmdata_sf()
## osm_data_points = osm_data$osm_points
## osm_data_points[4, ]
## point_vector = round(sf::st_coordinates(osm_data_points[4, ]), 3)
## point_df = data.frame(name = "London bus stop", point_vector)
## point_sf = sf::st_as_sf(point_df, coords = c("X", "Y"))


## ----03-attribute-operations-3, eval=FALSE----------------------------------------------------------------------------------------------------------------
## methods(class = "sf") # methods for sf objects, first 12 shown


## ----03-attribute-operations-4----------------------------------------------------------------------------------------------------------------------------
#>  [1] aggregate             cbind                 coerce               
#>  [4] initialize            merge                 plot                 
#>  [7] print                 rbind                 [                    
#> [10] [[<-                  $<-                   show                 


## ----03-attribute-operations-5, eval=FALSE, echo=FALSE----------------------------------------------------------------------------------------------------
## # Another way to show sf methods:
## attributes(methods(class = "sf"))$info |>
##   dplyr::filter(!visible)


## The geometry column of `sf` objects is typically called `geometry` or `geom` but any name can be used.

## The following command, for example, creates a geometry column named g:

## 

## `st_sf(data.frame(n = world$name_long), g = world$geom)`

## 

## This enables geometries imported from spatial databases to have a variety of names such as `wkb_geometry` and `the_geom`.


## ----03-attribute-operations-7----------------------------------------------------------------------------------------------------------------------------
class(world) # it's an sf object and a (tidy) data frame
dim(world)   # it is a 2 dimensional object, with 177 rows and 11 columns


## ----03-attribute-operations-8----------------------------------------------------------------------------------------------------------------------------
world_df = st_drop_geometry(world)
class(world_df)
ncol(world_df)


## ----03-attribute-operations-9, eval=FALSE----------------------------------------------------------------------------------------------------------------
## world[1:6, ]    # subset rows by position
## world[, 1:3]    # subset columns by position
## world[1:6, 1:3] # subset rows and columns by position
## world[, c("name_long", "pop")] # columns by name
## world[, c(T, T, F, F, F, F, F, T, T, F, F)] # by logical indices
## world[, 888] # an index representing a non-existent column


## ---- eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
## # these fail
## world[c(1, 5), c(T, T)]
## world[c(1, 5), c(T, T, F, F, F, F, F, T, T, F, F, F)]


## ----03-attribute-operations-10---------------------------------------------------------------------------------------------------------------------------
i_small = world$area_km2 < 10000
summary(i_small) # a logical vector
small_countries = world[i_small, ]


## ----03-attribute-operations-11---------------------------------------------------------------------------------------------------------------------------
small_countries = world[world$area_km2 < 10000, ]


## ----03-attribute-operations-12, eval=FALSE---------------------------------------------------------------------------------------------------------------
## small_countries = subset(world, area_km2 < 10000)


## ---- echo=FALSE, eval=FALSE------------------------------------------------------------------------------------------------------------------------------
## # Aim: benchmark base vs dplyr subsetting
## # Could move elsewhere?
## i = sample(nrow(world), size = 10)
## benchmark_subset = bench::mark(
##   world[i, ],
##   world |> slice(i)
## )
## benchmark_subset[c("expression", "itr/sec", "mem_alloc")]
## # # October 2021 on laptop with CRAN version of dplyr:
## # # A tibble: 2 × 3
## #   expression         `itr/sec` mem_alloc
## #   <bch:expr>             <dbl> <bch:byt>
## # 1 world[i, ]             1744.    5.55KB
## # 2 world |> slice(i)      671.    4.45KB


## ----03-attribute-operations-14---------------------------------------------------------------------------------------------------------------------------
world1 = dplyr::select(world, name_long, pop)
names(world1)


## ----03-attribute-operations-15---------------------------------------------------------------------------------------------------------------------------
# all columns between name_long and pop (inclusive)
world2 = dplyr::select(world, name_long:pop)


## ----03-attribute-operations-16---------------------------------------------------------------------------------------------------------------------------
# all columns except subregion and area_km2 (inclusive)
world3 = dplyr::select(world, -subregion, -area_km2)


## ----03-attribute-operations-17---------------------------------------------------------------------------------------------------------------------------
world4 = dplyr::select(world, name_long, population = pop)


## ----03-attribute-operations-18, eval=FALSE---------------------------------------------------------------------------------------------------------------
## world5 = world[, c("name_long", "pop")] # subset columns by name
## names(world5)[names(world5) == "pop"] = "population" # rename column manually


## ----03-attribute-operations-21, eval = FALSE-------------------------------------------------------------------------------------------------------------
## pull(world, pop)
## world$pop
## world[["pop"]]


## ----03-attribute-operations-19, eval=FALSE, echo=FALSE---------------------------------------------------------------------------------------------------
## # create throw-away data frame
## d = data.frame(pop = 1:10, area = 1:10)
## # return data frame object when selecting a single column
## d[, "pop", drop = FALSE] # equivalent to d["pop"]
## select(d, pop)
## # return a vector when selecting a single column
## d[, "pop"]
## pull(d, pop)


## ----03-attribute-operations-20, echo=FALSE, eval=FALSE---------------------------------------------------------------------------------------------------
## x1 = d[, "pop", drop = FALSE] # equivalent to d["pop"]
## x2 = d["pop"]
## identical(x1, x2)


## ----03-attribute-operations-22, eval=FALSE---------------------------------------------------------------------------------------------------------------
## slice(world, 1:6)


## ----03-attribute-operations-23, eval=FALSE---------------------------------------------------------------------------------------------------------------
## world7 = filter(world ,area_km2 < 10000) # countries with a small area
## world7 = filter(world, lifeExp > 82)      # with high life expectancy


## ----operators0, echo=FALSE-------------------------------------------------------------------------------------------------------------------------------
if (knitr::is_html_output()){
  operators = c("`==`", "`!=`", "`>`, `<`", "`>=`, `<=`", "`&`, <code>|</code>, `!`")
} else {
  operators = c("==", "!=", ">, <", ">=, <=", "&, |, !")
}


## ----operators, echo=FALSE--------------------------------------------------------------------------------------------------------------------------------
operators_exp = c("Equal to", "Not equal to", "Greater/Less than",
                  "Greater/Less than or equal", 
                  "Logical operators: And, Or, Not")
knitr::kable(tibble(Symbol = operators, Name = operators_exp), 
             caption = paste("Comparison operators that return Booleans",
                             "(TRUE/FALSE)."),
             caption.short = "Comparison operators that return Booleans.",
             booktabs = TRUE)


## ----03-attribute-operations-24---------------------------------------------------------------------------------------------------------------------------
world7 = world |>
  filter(continent == "Asia") |>
  dplyr::select(name_long, continent) |>
  slice(1:5)


## ----03-attribute-operations-25---------------------------------------------------------------------------------------------------------------------------
world8 = slice(
  dplyr::select(
    filter(world, continent == "Asia"),
    name_long, continent),
  1:5)


## ----03-attribute-operations-25-2-------------------------------------------------------------------------------------------------------------------------
world9_filtered = filter(world, continent == "Asia")
world9_selected = dplyr::select(world9_filtered, continent)
world9 = slice(world9_selected, 1:5)


## ----03-attribute-operations-26---------------------------------------------------------------------------------------------------------------------------
world_agg1 = aggregate(pop ~ continent, FUN = sum, data = world,
                       na.rm = TRUE)
class(world_agg1)


## ----03-attribute-operations-27---------------------------------------------------------------------------------------------------------------------------
world_agg2 = aggregate(world["pop"], list(world$continent), FUN = sum, 
                       na.rm = TRUE)
class(world_agg2)
nrow(world_agg2)


## ----03-attribute-operations-28---------------------------------------------------------------------------------------------------------------------------
world_agg3 = world |>
  group_by(continent) |>
  summarize(pop = sum(pop, na.rm = TRUE))


## ----03-attribute-operations-29---------------------------------------------------------------------------------------------------------------------------
world_agg4  = world |> 
  group_by(continent) |> 
  summarize(pop = sum(pop, na.rm = TRUE), `area_sqkm` = sum(area_km2), n = n())


## ----03-attribute-operations-30---------------------------------------------------------------------------------------------------------------------------
world_agg5 = world |> 
  st_drop_geometry() |>                      # drop the geometry for speed
  dplyr::select(pop, continent, area_km2) |> # subset the columns of interest  
  group_by(continent) |>                     # group by continent and summarize:
  summarize(Pop = sum(pop, na.rm = TRUE), Area = sum(area_km2), N = n()) |>
  mutate(Density = round(Pop / Area)) |>     # calculate population density
  slice_max(Pop, n = 3) |>                   # keep only the top 3
  arrange(desc(N))                           # arrange in order of n. countries


## ----continents, echo=FALSE-------------------------------------------------------------------------------------------------------------------------------
options(scipen = 999)
knitr::kable(
  world_agg5,
  caption = "The top 3 most populous continents ordered by number of countries.",
  caption.short = "Top 3 most populous continents.",
  booktabs = TRUE
)


## More details are provided in the help pages (which can be accessed via `?summarize` and `vignette(package = "dplyr")` and Chapter 5 of [R for Data Science](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarize).


## ----03-attribute-operations-32, warning=FALSE------------------------------------------------------------------------------------------------------------
world_coffee = left_join(world, coffee_data)
class(world_coffee)


## ----coffeemap, fig.cap="World coffee production (thousand 60-kg bags) by country, 2017. Source: International Coffee Organization.", fig.scap="World coffee production by country."----
names(world_coffee)
plot(world_coffee["coffee_production_2017"])


## ----03-attribute-operations-33, warning=FALSE------------------------------------------------------------------------------------------------------------
coffee_renamed = rename(coffee_data, nm = name_long)
world_coffee2 = left_join(world, coffee_renamed, by = c(name_long = "nm"))


## ----03-attribute-operations-34, eval=FALSE, echo=FALSE---------------------------------------------------------------------------------------------------
## identical(world_coffee, world_coffee2)
## nrow(world)
## nrow(world_coffee)


## ----03-attribute-operations-35, warning=FALSE------------------------------------------------------------------------------------------------------------
world_coffee_inner = inner_join(world, coffee_data)
nrow(world_coffee_inner)


## ----03-attribute-operations-36---------------------------------------------------------------------------------------------------------------------------
setdiff(coffee_data$name_long, world$name_long)


## ----03-attribute-operations-37---------------------------------------------------------------------------------------------------------------------------
(drc = stringr::str_subset(world$name_long, "Dem*.+Congo"))


## ---- echo=FALSE, eval=FALSE------------------------------------------------------------------------------------------------------------------------------
## world$name_long[grepl(pattern = "Dem*.+Congo", world$name_long)] # base R


## ----03-attribute-operations-38, eval=FALSE, echo=FALSE---------------------------------------------------------------------------------------------------
## # aim: test names in coffee_data and world objects
## str_subset(coffee_data$name_long, "Ivo|Congo,")
## .Last.value %in% str_subset(world$name_long, "Ivo|Dem*.+Congo")


## ----03-attribute-operations-39, warning=FALSE------------------------------------------------------------------------------------------------------------
coffee_data$name_long[grepl("Congo,", coffee_data$name_long)] = drc
world_coffee_match = inner_join(world, coffee_data)
nrow(world_coffee_match)


## ----03-attribute-operations-40, warning=FALSE------------------------------------------------------------------------------------------------------------
coffee_world = left_join(coffee_data, world)
class(coffee_world)


## In most cases, the geometry column is only useful in an `sf` object.

## The geometry column can only be used for creating maps and spatial operations if R 'knows' it is a spatial object, defined by a spatial package such as **sf**.

## Fortunately, non-spatial data frames with a geometry list column (like `coffee_world`) can be coerced into an `sf` object as follows: `st_as_sf(coffee_world)`.


## ----03-attribute-operations-42---------------------------------------------------------------------------------------------------------------------------
world_new = world # do not overwrite our original data
world_new$pop_dens = world_new$pop / world_new$area_km2


## ----03-attribute-operations-43, eval=FALSE---------------------------------------------------------------------------------------------------------------
## world |>
##   mutate(pop_dens = pop / area_km2)


## ----03-attribute-operations-44, eval=FALSE---------------------------------------------------------------------------------------------------------------
## world |>
##   transmute(pop_dens = pop / area_km2)


## ----03-attribute-operations-45, eval=FALSE---------------------------------------------------------------------------------------------------------------
## world_unite = world |>
##   tidyr::unite("con_reg", continent:region_un, sep = ":", remove = TRUE)


## ----03-attribute-operations-46, eval=FALSE---------------------------------------------------------------------------------------------------------------
## world_separate = world_unite |>
##   tidyr::separate(con_reg, c("continent", "region_un"), sep = ":")


## ----03-attribute-operations-47, echo=FALSE, eval=FALSE---------------------------------------------------------------------------------------------------
## identical(world, world_separate)


## ----03-attribute-operations-48, eval=FALSE---------------------------------------------------------------------------------------------------------------
## world |>
##   rename(name = name_long)


## ----03-attribute-operations-49, eval=FALSE, echo=FALSE---------------------------------------------------------------------------------------------------
## abbreviate(names(world), minlength = 1) |> dput()


## ----03-attribute-operations-50, eval=FALSE---------------------------------------------------------------------------------------------------------------
## new_names = c("i", "n", "c", "r", "s", "t", "a", "p", "l", "gP", "geom")
## world_new_names = world |>
##   setNames(new_names)


## ----03-attribute-operations-51---------------------------------------------------------------------------------------------------------------------------
world_data = world |> st_drop_geometry()
class(world_data)


## ----03-attribute-operations-52, message=FALSE, eval = FALSE----------------------------------------------------------------------------------------------
## elev = rast(nrows = 6, ncols = 6, resolution = 0.5,
##             xmin = -1.5, xmax = 1.5, ymin = -1.5, ymax = 1.5,
##             vals = 1:36)


## ----03-attribute-operations-53, eval = FALSE-------------------------------------------------------------------------------------------------------------
## grain_order = c("clay", "silt", "sand")
## grain_char = sample(grain_order, 36, replace = TRUE)
## grain_fact = factor(grain_char, levels = grain_order)
## grain = rast(nrows = 6, ncols = 6, resolution = 0.5,
##              xmin = -1.5, xmax = 1.5, ymin = -1.5, ymax = 1.5,
##              vals = grain_fact)


## ----03-attribute-operations-54, include = FALSE----------------------------------------------------------------------------------------------------------
elev = rast(system.file("raster/elev.tif", package = "spData"))
grain = rast(system.file("raster/grain.tif", package = "spData"))


## ----03-attribute-operations-56---------------------------------------------------------------------------------------------------------------------------
levels(grain) = data.frame(value = c(0, 1, 2), wetness = c("wet", "moist", "dry"))
levels(grain)


## ----cont-raster, echo = FALSE, message = FALSE, fig.asp=0.5, fig.cap = "Raster datasets with numeric (left) and categorical values (right).", fig.scap="Raster datasets with numeric and categorical values.", warning=FALSE----
# knitr::include_graphics("https://user-images.githubusercontent.com/1825120/146617366-7308535b-30f6-4c87-83f7-21702c7d993b.png")
source("https://github.com/Robinlovelace/geocompr/raw/main/code/03-cont-raster-plot.R", print.eval = TRUE)


## Categorical raster objects can also store information about the colors associated with each value using a color table.

## The color table is a data frame with three (red, green, blue) or four (alpha) columns, where each row relates to one value.

## Color tables in **terra** can be viewed or set with the `coltab()` function (see `?coltab`).

## Importantly, saving a raster object with a color table to a file (e.g., GeoTIFF) will also save the color information.


## ----03-attribute-operations-58, eval = FALSE-------------------------------------------------------------------------------------------------------------
## # row 1, column 1
## elev[1, 1]
## # cell ID 1
## elev[1]


## ----03-attribute-operations-60, results='hide'-----------------------------------------------------------------------------------------------------------
elev[1, 1] = 0
elev[]


## ----03-attribute-operations-61---------------------------------------------------------------------------------------------------------------------------
elev[1, c(1, 2)] = 0


## ----03-attribute-operations-61b, eval=FALSE--------------------------------------------------------------------------------------------------------------
## two_layers = c(grain, elev)
## two_layers[1] = cbind(c(1), c(4))
## two_layers[]


## ----03-attribute-operations-62, eval = FALSE-------------------------------------------------------------------------------------------------------------
## global(elev, sd)


## If you provide the `summary()` and `global()` functions with a multi-layered raster object, they will summarize each layer separately, as can be illustrated by running: `summary(c(elev, grain))`.


## ----03-attribute-operations-64, eval=FALSE---------------------------------------------------------------------------------------------------------------
## hist(elev)


## Some function names clash between packages (e.g., a function with the name `extract()` exist in both **terra** and **tidyr** packages).

## In addition to not loading packages by referring to functions verbosely (e.g., `tidyr::extract()`), another way to prevent function names clashes is by unloading the offending package with `detach()`.

## The following command, for example, unloads the **terra** package (this can also be done in the *package* tab which resides by default in the right-bottom pane in RStudio): `detach("package:terra", unload = TRUE, force = TRUE)`.

## The `force` argument makes sure that the package will be detached even if other packages depend on it.

## This, however, may lead to a restricted usability of packages depending on the detached package, and is therefore not recommended.


## ---- echo=FALSE, results='asis'--------------------------------------------------------------------------------------------------------------------------
res = knitr::knit_child('_03-ex.Rmd', quiet = TRUE, options = list(include = FALSE, eval = FALSE))
cat(res, sep = '\n')

