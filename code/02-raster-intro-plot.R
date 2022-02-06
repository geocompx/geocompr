# first intro plot -----------------------------------------------------------
library(terra)
library(sf)
library(tmap)
library(spData)
set.seed(2021-09-09)
small_ras = rast(matrix(1:16, 4, 4, byrow = TRUE))
crs(small_ras) = "EPSG:4326"
polys = st_as_sf(as.polygons(small_ras, na.rm = FALSE))
polys$vals = sample.int(100, 16)
polys$vals[c(7, 9)] = "NA"
suppressWarnings({polys$valsn = as.numeric(polys$vals)})

tm1 = tm_shape(polys) +
  tm_borders(col = "black") +
  tm_text(text = "lyr.1") +
  tm_layout(frame = FALSE, 
            main.title = "A. Cell IDs")

tm2 = tm_shape(polys) +
  tm_borders(col = "black") +
  tm_text(text = "vals") +
  tm_layout(frame = FALSE, 
            main.title = "B. Cell values")

tm3 = tm_shape(polys) +
  tm_fill(col = "valsn", colorNA = "white", 
          legend.show = FALSE, palette = "RdBu") +
  tm_layout(frame = FALSE, 
            main.title = "C. Colored values")

tmap_arrange(tm1, tm2, tm3, nrow = 1)
