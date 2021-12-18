library(tmap)
library(sf)
library(terra)

elev = rast(system.file("raster/elev.tif", package = "spData"))
elev_agg = aggregate(elev, fact = 2, fun = mean)
elev_poly1 = st_as_sf(as.polygons(elev, dissolve = FALSE)[1])
elev_poly1_cen = st_centroid(elev_poly1)
elev_points4 = st_as_sf(as.points(elev_agg)[c(1, 2, 4, 5)])

xy_1 = xyFromCell(elev, 1)
xy_2 = xyFromCell(elev_agg, c(1, 2, 4, 5))
elev_lines1 = st_linestring(rbind(xy_1, xy_2[1, ]))
elev_lines2 = st_linestring(rbind(xy_1, xy_2[2, ]))
elev_lines3 = st_linestring(rbind(xy_1, xy_2[3, ]))
elev_lines4 = st_linestring(rbind(xy_1, xy_2[4, ]))
elev_lines_all = st_sfc(elev_lines1, elev_lines2, elev_lines3, elev_lines4)

tm_shape(elev_agg) +
  tm_raster(style = "cont", title = "") + 
  tm_shape(elev_lines_all) +
  tm_lines() +
  tm_shape(elev_poly1) +
  tm_borders(lwd = 2) +
  tm_shape(elev_points4) +
  tm_dots(size = 1.1, shape = 21, col = "salmon") +
  tm_shape(elev_poly1_cen) +
  tm_dots(size = 1.2, shape = 4) +
  tm_layout(frame = FALSE, legend.outside = TRUE, legend.outside.size = 0.1)
