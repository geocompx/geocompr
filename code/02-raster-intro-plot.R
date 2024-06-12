# first intro plot -----------------------------------------------------------
library(terra)
library(sf)
library(tmap)
library(spData)
set.seed(2021-09-09)
small_ras = rast(matrix(1:16, 4, 4, byrow = TRUE))
crs(small_ras) = "EPSG:4326"
polys = st_as_sf(as.polygons(small_ras, na.rm = FALSE))
polys$lyr.1 = as.character(polys$lyr.1)
polys$vals = sample.int(100, 16)
polys$vals[c(7, 9)] = "NA"
suppressWarnings({polys$valsn = as.numeric(polys$vals)})

tm1 = tm_shape(polys) +
  tm_borders(col = "black") +
  tm_text(text = "lyr.1") +
  tm_title("A. Cell IDs") +
  tm_layout(frame = FALSE)

tm2 = tm_shape(polys) +
  tm_borders(col = "black") +
  tm_text(text = "vals")  +
  tm_title("B. Cell values") +
  tm_layout(frame = FALSE)

tm3 = tm_shape(polys) +
  tm_fill(fill = "valsn", 
          fill.scale = tm_scale(values = "RdBu", value.na = "white"),
          fill.legend = tm_legend(show = FALSE)) +
  tm_title("C. Colored values") +
  tm_layout(frame = FALSE)

tmap_arrange(tm1, tm2, tm3, nrow = 1)

