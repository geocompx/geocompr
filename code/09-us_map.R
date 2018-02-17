library(sf)
library(spData)
library(tidyverse)
library(tmap)
library(grid)

us_states2163 = st_transform(us_states, 2163)

us_states_area = st_area(st_as_sfc(st_bbox(us_states2163)))
hawaii_area = st_area(st_as_sfc(st_bbox(hawaii)))
alaska_area = st_area(st_as_sfc(st_bbox(alaska)))

us_states_hawaii_ratio = as.numeric(hawaii_area/us_states_area)
us_states_alaska_ratio = as.numeric(alaska_area/us_states_area)

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

grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 1, heights = unit(c(us_states_alaska_ratio, 1), "null"))))
print(alaska_map, vp = viewport(layout.pos.row = 1))
print(us_states_map, vp = viewport(layout.pos.row = 2))
print(hawaii_map, vp = viewport(x = 0.25, y = 0.1,
                                height = us_states_hawaii_ratio))

