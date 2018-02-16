library(sf)
library(spData)
library(tidyverse)
library(tmap)

us_states2163 = st_transform(us_states, 2163)

us_states_area = st_area(st_as_sfc(st_bbox(us_states2163)))
hawaii_area = st_area(st_as_sfc(st_bbox(hawaii)))
alaska_area = st_area(st_as_sfc(st_bbox(alaska)))

us_states_hawaii_ratio = hawaii_area/us_states_area
us_states_alaska_ratio = alaska_area/us_states_area

us_states_map = tm_shape(us_states2163) +
  tm_polygons() + 
  tm_layout(frame = FALSE)

hawaii_map = tm_shape(hawaii) +
  tm_polygons() + 
  tm_layout(title = "Hawaii", frame = FALSE, bg.color = NA, 
            title.position = c("left", "bottom"))
alaska_map = tm_shape(alaska) +
  tm_polygons() + 
  tm_layout(title = "Alaska", frame = FALSE, bg.color = NA)


library(grid)

us_states_map

print(hawaii_map, vp = viewport(x = 0.4, y = 0.1,
                                width = us_states_hawaii_ratio,
                                height = us_states_hawaii_ratio))

print(alaska_map, vp = viewport(x = 0.5, y = 0.8, 
                                width = us_states_alaska_ratio, 
                                height = us_states_alaska_ratio))
