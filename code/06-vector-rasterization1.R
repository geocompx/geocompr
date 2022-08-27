library(sf)
library(tmap)
library(spData)
library(terra)

if(!exists("cycle_hire_osm_projected")) {
  cycle_hire_osm_projected = st_transform(cycle_hire_osm, "EPSG:27700")
  raster_template = rast(ext(cycle_hire_osm_projected), resolution = 1000,
                         crs = "EPSG:27700")
  
  ch_raster1 = rasterize(vect(cycle_hire_osm_projected), raster_template, field = 1)
  
  ch_raster2 = rasterize(vect(cycle_hire_osm_projected), raster_template, 
                         field = 1, fun = "length")
  
  ch_raster3 = rasterize(vect(cycle_hire_osm_projected), raster_template, 
                         field = "capacity", fun = sum)
}

r0p = tm_shape(cycle_hire_osm_projected) + 
  tm_symbols(col = "capacity", title.col = "Capacity: ", size = 0.1) + 
  tm_layout(main.title = "A. Points", main.title.size = 1, 
            legend.position = c("right", "bottom"), legend.frame = TRUE)

r1p = tm_shape(ch_raster1) + 
  tm_raster(legend.show = TRUE, title = "Values: ") + 
  tm_layout(main.title = "B. Presence/absence", main.title.size = 1, 
            legend.position = c("right", "bottom"), legend.frame = TRUE)

r2p = tm_shape(ch_raster2) + 
  tm_raster(legend.show = TRUE, title = "Values: ") + 
  tm_layout(main.title = "C. Count", main.title.size = 1,
            legend.position = c("right", "bottom"), legend.frame = TRUE)

r3p = tm_shape(ch_raster3) + 
  tm_raster(legend.show = TRUE, title = "Values: ") +
  tm_layout(main.title = "D. Aggregated capacity", main.title.size = 1,
            legend.position = c("right", "bottom"), legend.frame = TRUE)

tmap_arrange(r0p, r1p, r2p, r3p, ncol = 2)
