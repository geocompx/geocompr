## ---- echo=FALSE, include=FALSE------------------------------------------
if(!exists("world"))
        source("code/01-introduction.R")

## ------------------------------------------------------------------------
class(world)

## ------------------------------------------------------------------------
dim(world) # it is a 2 dimensional object, with rows and columns
nrow(world) # how many rows?
ncol(world) # how many columns?

## ------------------------------------------------------------------------
world_df = world
st_geometry(world_df) = NULL
class(world_df)

## ---- eval=FALSE---------------------------------------------------------
#> world[1:6, ] # subset rows

## ---- eval=FALSE---------------------------------------------------------
#> world[, 1:3] # subset columns

## ---- message=FALSE------------------------------------------------------
library(dplyr)

## ------------------------------------------------------------------------
world_orig = world # create copy of world dataset for future reference
world = select(world_orig, name, continent, population = pop_est)
head(world, n = 2)

## ---- eval=FALSE---------------------------------------------------------
#> world2 = world_orig[c("name", "continent", "pop_est")] # subset columns by name
#> names(world2)[3] = "population" # rename column manually

## ------------------------------------------------------------------------
world4 = world_orig %>%
        select(name, continent)

## ------------------------------------------------------------------------
# ==, !=, >, >=, <, <=, &, |

# subsetting simple feature rows by values
world_few_rows = world[world$population > 1000000000,]

#OR
world_few_rows = world %>% 
        filter(population > 1000000000)

head(world_few_rows)

## ------------------------------------------------------------------------
# add a new column
world$area = raster::area(as(world, "Spatial")) / 1000000 #it there any function for area calculation on sf object?
world$pop_density = world$population / world$area

# OR

world = world %>% 
        mutate(area = raster::area(as(., "Spatial")) / 1000000) %>%
        mutate(pop_density = population / area)

## ---- results='hide'-----------------------------------------------------
# data summary (not shown)
summary(world)

# data summary by groups (not shown)
world_continents = world %>% 
        group_by(continent) %>% 
        summarise(continent_pop = sum(population), country_n = n())
                  world_continents

## ------------------------------------------------------------------------
# sort variables
## by name
world_continents %>% 
        arrange(continent)
## by population (in descending order)
world_continents %>% 
        arrange(-continent_pop)

## ------------------------------------------------------------------------
world_st = world
st_geometry(world_st) = NULL
class(world_st)

# OR

world_st2 = world
world_st2 = world_st2 %>% st_set_geometry(NULL)
class(world_st2)

