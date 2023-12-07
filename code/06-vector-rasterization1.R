library(sf)
library(tmap)
library(spData)
library(terra)

if (!exists("cycle_hire_osm_projected")) {
  cycle_hire_osm_projected = st_transform(cycle_hire_osm, "EPSG:27700")
  raster_template = rast(ext(cycle_hire_osm_projected), resolution = 1000,
                         crs = "EPSG:27700")
  
  ch_raster1 = rasterize(vect(cycle_hire_osm_projected), raster_template, field = 1)
  
  ch_raster2 = rasterize(vect(cycle_hire_osm_projected), raster_template, 
                         field = 1, fun = "length")
  
  ch_raster3 = rasterize(vect(cycle_hire_osm_projected), raster_template, 
                         field = "capacity", fun = sum, na.rm = TRUE)
}

r0p = tm_shape(cycle_hire_osm_projected) + 
  tm_symbols(fill = "capacity", size = 0.3, 
             fill.legend = tm_legend("Capacity: ")) + 
  tm_title("A. Points") +
  tm_layout(legend.position = c("right", "bottom"), legend.frame = TRUE, 
  inner.margins = c(0.02, 0.02, 0.02, 0.35))

r1p = tm_shape(ch_raster1) + 
  tm_raster(col.scale = tm_scale_categorical(values = cols4all::c4a(n = 1, "hcl.blues3", reverse = TRUE)),
            col.legend = tm_legend("Values: ")) + 
  tm_title("B. Presence/absence") +
  tm_layout(legend.position = c("right", "bottom"), legend.frame = TRUE, 
  inner.margins = c(0.02, 0.02, 0.02, 0.35))

r2p = tm_shape(ch_raster2) + 
  tm_raster(col.legend = tm_legend("Values: ")) + 
  tm_title("C. Count") +
  tm_layout(legend.position = c("right", "bottom"), legend.frame = TRUE, 
  inner.margins = c(0.02, 0.02, 0.02, 0.35))

r3p = tm_shape(ch_raster3) + 
  tm_raster(col.legend = tm_legend("Values: ")) + 
  tm_title("D. Aggregated capacity") +
  tm_layout(legend.position = c("right", "bottom"), legend.frame = TRUE, 
  inner.margins = c(0.02, 0.02, 0.02, 0.35))

tmap_arrange(r0p, r1p, r2p, r3p, ncol = 2)
