library(sf)
library(ggplot2)

## sfc objects creation ---------
point_sfc = st_sfc(st_point(c(1, 1)), crs = 4326)
linestring_sfc = st_sfc(st_linestring(rbind(c(0.8, 1), c(0.8, 1.2), c(1, 1.2))), crs = 4326)
polygon_sfc = st_sfc(st_polygon(list(rbind(c(1.2, 0.6), c(1.4, 0.6), c(1.4, 0.8), c(1.2, 0.8), c(1.2, 0.6)))), crs = 4326)
multipoint_sfc = st_sfc(st_multipoint(rbind(c(1, 0.6), c(1.4, 1.1))), crs = 4326)
multilinestring_sfc = st_sfc(st_multilinestring(list(rbind(c(1.2, 1), c(1.2, 1.4)),
                                                     rbind(c(1.4, 0.4), c(1.6, 0.6), c(1.6, 0.8)))), crs = 4326)
multipolygon_sfc = st_sfc(st_multipolygon(list(list(rbind(c(1.4, 1.2), c(1.6, 1.4), c(1.4, 1.4), c(1.4, 1.2))),
                                               list(rbind(c(0.6, 0.6), c(0.9, 0.6), c(0.9, 0.9), c(0.6, 0.9), c(0.6, 0.6)),
                                                    rbind(c(0.7, 0.7), c(0.8, 0.7), c(0.8, 0.8), c(0.7, 0.7))))), 
                          crs = 4326)


## sf objects creation ---------
point_sf = st_sf(geometry = point_sfc)
linestring_sf = st_sf(geometry = linestring_sfc)
polygon_sf = st_sf(geometry = polygon_sfc)
mutlipoint_sf = st_sf(geometry = multipoint_sfc)
multilinestring_sf = st_sf(geometry = multilinestring_sfc)
multipolygon_sf = st_sf(geometry = multipolygon_sfc)
geometrycollection_sf = st_cast(c(point_sfc,
                                   linestring_sfc,
                                   polygon_sfc,
                                   multipoint_sfc,
                                   multilinestring_sfc,
                                   multipolygon_sfc), "GEOMETRYCOLLECTION")

# ## single plots ----------
# p_point_sf = ggplot() + geom_sf(data = point_sf) + labs(title = "POINT")
# p_point_sf
# 
# p_linestring_sf = ggplot() + geom_sf(data = linestring_sf) + labs(title = "LINESTRING")
# p_linestring_sf
# 
# p_polygon_sf = ggplot() + geom_sf(data = polygon_sf) + labs(title = "POLYGON")
# p_polygon_sf
# 
# p_multipoint_sf = ggplot() + geom_sf(data = mutlipoint_sf) + labs(title = "MULTIPOINT")
# p_multipoint_sf
# 
# p_multilinestring_sf = ggplot() + geom_sf(data = multilinestring_sf) + labs(title = "MULTILINESTRING")
# p_multilinestring_sf
# 
# p_multipolygon_sf = ggplot() + geom_sf(data = multipolygon_sf) + labs(title = "MULTIPOLYGON")
# p_multipolygon_sf
# 
# p_geometrycollection_sf = ggplot() + geom_sf(data = geometrycollection_sf) + labs(title = "GEOMETRYCOLLECTION")
# p_geometrycollection_sf
