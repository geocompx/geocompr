## ----04-ex-e0, include=TRUE, message=FALSE----------------------------------------------------------------------------------------------------------------
library(sf)
library(dplyr)
library(spData)


## ----04-ex-e1---------------------------------------------------------------------------------------------------------------------------------------------
library(tmap)
# tmap_mode("view")
qtm(nz) + qtm(nz_height)
canterbury = nz |> filter(Name == "Canterbury")
canterbury_height = nz_height[canterbury, ]
nz_not_canterbury_height = nz_height[canterbury, , op = st_disjoint]
nrow(canterbury_height) # answer: 70

plot(st_geometry(nz))
plot(st_geometry(canterbury), col = "yellow", add = TRUE)
plot(nz_not_canterbury_height$geometry, pch = 1, col = "blue", add = TRUE)
plot(canterbury_height$geometry, pch = 4, col = "red", add = TRUE)


## ----04-ex-e2---------------------------------------------------------------------------------------------------------------------------------------------
nz_height_count = aggregate(nz_height, nz, length)
nz_height_combined = cbind(nz, count = nz_height_count$elevation)
nz_height_combined |> 
  st_drop_geometry() |> 
  dplyr::select(Name, count) |> 
  arrange(desc(count)) |> 
  slice(2)


## ----04-ex-e3---------------------------------------------------------------------------------------------------------------------------------------------
# Base R way:
nz_height_count = aggregate(nz_height, nz, length)
nz_height_combined = cbind(nz, count = nz_height_count$elevation)
plot(nz_height_combined)

# Tidyverse way:
nz_height_joined = st_join(nz_height, nz |> select(Name))
# Calculate n. points in each region - this contains the result
nz_height_counts = nz_height_joined |> 
  group_by(Name) |> 
  summarise(count = n())

# Optionally join results with nz geometries:
nz_height_combined = left_join(nz, nz_height_counts |> sf::st_drop_geometry())
# plot(nz_height_combined) # Check: results identical to base R result

# Generate a summary table
nz_height_combined |> 
  st_drop_geometry() |> 
  dplyr::select(Name, count) |> 
  arrange(desc(count)) |> 
  na.omit()


## ----04-ex-4-1--------------------------------------------------------------------------------------------------------------------------------------------
colorado = us_states[us_states$NAME == "Colorado", ]
plot(us_states$geometry)
plot(colorado$geometry, col = "grey", add = TRUE)


## ----04-ex-4-2--------------------------------------------------------------------------------------------------------------------------------------------
intersects_with_colorado = us_states[colorado, , op = st_intersects]
plot(us_states$geometry, main = "States that intersect with Colorado")
plot(intersects_with_colorado$geometry, col = "grey", add = TRUE)


## ----04-ex-4-3--------------------------------------------------------------------------------------------------------------------------------------------
# Alternative but more verbose solutions
# 2: With intermediate object, one list for each state
sel_intersects_colorado = st_intersects(us_states, colorado)
sel_intersects_colorado_list = lengths(sel_intersects_colorado) > 0
intersects_with_colorado = us_states[sel_intersects_colorado_list, ]

# 3: With intermediate object, one index for each state
sel_intersects_colorado2 = st_intersects(colorado, us_states)
sel_intersects_colorado2
us_states$NAME[unlist(sel_intersects_colorado2)]

# 4: With tidyverse
us_states |> 
  st_filter(y = colorado, .predicate = st_intersects)


## ----04-ex-4-4--------------------------------------------------------------------------------------------------------------------------------------------
touches_colorado = us_states[colorado, , op = st_touches]
plot(us_states$geometry, main = "States that touch Colorado")
plot(touches_colorado$geometry, col = "grey", add = TRUE)


## ----04-ex-4-5--------------------------------------------------------------------------------------------------------------------------------------------
washington_to_cali = us_states |> 
  filter(grepl(pattern = "Columbia|Cali", x = NAME)) |> 
  st_centroid() |> 
  st_union() |> 
  st_cast("LINESTRING")
states_crossed = us_states[washington_to_cali, , op = st_crosses]
states_crossed$NAME
plot(us_states$geometry, main = "States crossed by a straight line\n from the District of Columbia to central California")
plot(states_crossed$geometry, col = "grey", add = TRUE)
plot(washington_to_cali, add = TRUE)


## ----04-ex-e5---------------------------------------------------------------------------------------------------------------------------------------------
library(terra)
dem = rast(system.file("raster/dem.tif", package = "spDataLarge"))
ndvi = rast(system.file("raster/ndvi.tif", package = "spDataLarge"))

#1
dem_rcl = matrix(c(-Inf, 300, 0, 300, 500, 1, 500, Inf, 2), ncol = 3, byrow = TRUE)
dem_reclass = classify(dem, dem_rcl)
levels(dem_reclass) = data.frame(id = 0:2, cats = c("low", "medium", "high"))
plot(dem_reclass)

#2
zonal(c(dem, ndvi), dem_reclass, fun = "mean")


## ----04-ex-e6---------------------------------------------------------------------------------------------------------------------------------------------
# from the focal help page (?terra::focal()):
# Laplacian filter: filter=matrix(c(0,1,0,1,-4,1,0,1,0), nrow=3)
# Sobel filters (for edge detection): 
# fx=matrix(c(-1,-2,-1,0,0,0,1,2,1), nrow=3) 
# fy=matrix(c(1,0,-1,2,0,-2,1,0,-1), nrow=3)

# just retrieve the first channel of the R logo
r = rast(system.file("ex/logo.tif", package = "terra"))
# compute the Sobel filter
filter_x = matrix(c(-1, -2, -1, 0, 0, 0, 1, 2, 1), nrow = 3)
sobel_x = focal(r, w = filter_x)
plot(sobel_x, col = c("white", "black"))

filter_y = matrix(c(1, 0, -1, 2, 0, -2, 1, 0, -1), nrow = 3)
sobel_y = focal(r, w = filter_y)
plot(sobel_y, col = c("black", "white"))


## ----04-ex-e7---------------------------------------------------------------------------------------------------------------------------------------------
file = system.file("raster/landsat.tif", package = "spDataLarge")
multi_rast = rast(file)

ndvi_fun = function(nir, red){
  (nir - red) / (nir + red)
}
ndvi_rast = lapp(multi_rast[[c(4, 3)]], fun = ndvi_fun)
plot(ndvi_rast)

ndwi_fun = function(green, nir){
    (green - nir) / (green + nir)
}

ndwi_rast = lapp(multi_rast[[c(2, 4)]], fun = ndwi_fun)
plot(ndwi_rast)

two_rasts = c(ndvi_rast, ndwi_rast)
names(two_rasts) = c("ndvi", "ndwi")

# correlation -- option 1
layerCor(two_rasts, fun = cor)

# correlation -- option 2
two_rasts_df = as.data.frame(two_rasts)
cor(two_rasts_df$ndvi, two_rasts_df$ndwi)


## ----04-ex-e8---------------------------------------------------------------------------------------------------------------------------------------------
# Fetch the DEM data for Spain
spain_dem = geodata::elevation_30s(country = "Spain", path = ".", mask = FALSE)

# Reduce the resolution by a factor of 20 to speed up calculations
spain_dem = aggregate(spain_dem, fact = 20)

# According to the documentation, terra::distance() will calculate distance
# for all cells that are NA to the nearest cell that are not NA. To calculate
# distance to the coast, we need a raster that has NA values over land and any
# other value over water
water_mask = is.na(spain_dem)
water_mask[water_mask == 0] = NA

# Use the distance() function on this mask to get distance to the coast
distance_to_coast = distance(water_mask)
# convert distance into km
distance_to_coast_km = distance_to_coast / 1000

# Plot the result
plot(distance_to_coast_km, main = "Distance to the coast (km)")


## ----04-ex-e9---------------------------------------------------------------------------------------------------------------------------------------------
# now let's weight each 100 altitudinal meters by an additional distance of 10 km
distance_to_coast_km2 = distance_to_coast_km + ((spain_dem / 100) * 10)
# plot the result
plot(distance_to_coast_km2)
# visualize the difference
plot(distance_to_coast_km - distance_to_coast_km2)

