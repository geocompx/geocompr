library(tmap)
library(spData)
tmap_options(main.title.size = 1)

cols = c("clay" = "brown", "sand" = "rosybrown", "silt" = "sandybrown")

p1p = tm_shape(grain) + tm_raster(legend.show = FALSE, palette = cols) +
  tm_layout(main.title = "Raster", frame = FALSE)

if(!exists("grain_poly")) {
  grain_poly = rasterToPolygons(grain) %>% 
    st_as_sf()
  grain_poly2 = grain_poly %>% 
    group_by(layer) %>%
    summarize()
}

p2p = tm_shape(grain_poly) + tm_polygons("layer", legend.show = FALSE, palette = cols, lwd = 3) +
  tm_layout(main.title = "Polygons", frame = FALSE)

p3p = tm_shape(grain_poly2) + tm_polygons("layer", legend.show = FALSE, palette = cols, lwd = 3) +
  tm_layout(main.title = "Aggregated polygons", frame = FALSE)

tmap_arrange(p1p, p2p, p3p, ncol = 3)
