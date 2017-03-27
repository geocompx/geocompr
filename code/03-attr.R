## ---- eval=FALSE---------------------------------------------------------
## # subsetting simple feature rows
## w[1:3, ]

## ------------------------------------------------------------------------
# subsetting simple feature columns
selc = 1:3
w_few_cols = w[selc]
head(w_few_cols)

## ---- message=FALSE------------------------------------------------------
library(dplyr)

## ------------------------------------------------------------------------
# subsetting simple feature columns by name
w_few_cols2 = w[c('name', 'continent')]

#OR

w_few_cols2 = w %>%
        select(., name, continent)

head(w_few_cols2)

## ------------------------------------------------------------------------
# ==, !=, >, >=, <, <=, &, |

# subsetting simple feature rows by values
w_few_rows = w[w$pop_est>1000000000, ]

#OR
w_few_rows = w %>% 
        filter(., pop_est>1000000000)

head(w_few_rows)

## ------------------------------------------------------------------------
# add a new column
w$area = raster::area(as(w, "Spatial")) / 1000000 #it there any function for area calculation on sf object?
w$pop_density = w$pop_est / w$area

# OR

w = w %>% 
        mutate(area=raster::area(as(., "Spatial")) / 1000000) %>% 
        mutate(pop_density=pop_est/area)

## ------------------------------------------------------------------------
# data summary
summary(w)

# data summary by groups
w_continents = w %>% 
        group_by(continent) %>% 
        summarise(continent_pop=sum(pop_est), country_n=n())
w_continents

## ------------------------------------------------------------------------
# sort variables
## by name
w_continents %>% 
        arrange(continent)
## by population (in descending order)
w_continents %>% 
        arrange(-continent_pop)

## ------------------------------------------------------------------------
w_st = w
st_geometry(w_st) = NULL
class(w_st)

# OR

w_st2 = w
w_st2 = w_st2 %>% st_set_geometry(., NULL)
class(w_st2)

