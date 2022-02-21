library(qgisprocess)
library(sf)
library(tmap)

data("incongruent", "aggregating_zones", package = "spData")
incongr_wgs = st_transform(incongruent, "EPSG:4326")
aggzone_wgs = st_transform(aggregating_zones, "EPSG:4326")

alg = "native:union"
union = qgis_run_algorithm(alg, INPUT = incongr_wgs, OVERLAY = aggzone_wgs)
union_sf = st_as_sf(union)

single = st_cast(union_sf, "MULTIPOLYGON") |> st_cast("POLYGON")
single$area = st_area(single)
x = 25000
units(x) = "m^2"
sub = dplyr::filter(single, area < x)


clean = qgis_run_algorithm("grass7:v.clean", input = union_sf, type = 4,
                           tool = 10, threshold = 25000, 
                           output = file.path(tempdir(), "clean.gpkg"))
clean_sf = st_as_sf(clean)

tm1 = tm_shape(union_sf) +
  tm_polygons(alpha = 0.2, lwd = 0.2) +
  tm_shape(sub) +
  tm_fill(col = "#C51111") +
  tm_layout(main.title = "Sliver polygons included",
            main.title.size = 1)

tm2 = tm_shape(clean_sf) +
  tm_polygons(alpha = 0.2, lwd = 0.2) +
  tm_layout(main.title = "Sliver polygons cleaned",
            main.title.size = 1)

sc_maps = tmap_arrange(tm1, tm2, nrow = 1)

# save the output
tmap_save(sc_maps, "figures/10-sliver.png",
          width = 12, height = 5, units = "cm")
