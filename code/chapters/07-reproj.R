## ----06-reproj-1, message=FALSE, warning=FALSE------------------------------------------------------------------------------------------------------------
library(sf)
library(terra)
library(dplyr)
library(spData)
library(spDataLarge)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
st_crs("EPSG:4326")


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------------------------
## sf::st_crs("ESRI:54030")
## #> Coordinate Reference System:
## #>   User input: ESRI:54030
## #>   wkt:
## #> PROJCRS["World_Robinson",
## #>     BASEGEOGCRS["WGS 84",
## #>         DATUM["World Geodetic System 1984",
## #>             ELLIPSOID["WGS 84",6378137,298.257223563,
## #>                 LENGTHUNIT["metre",1]]],
## #> ...


## ---- eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------------------------------------------
## sf::st_crs("urn:ogc:def:crs:EPSG::4326")


## ----02-spatial-data-52, message=FALSE, results='hide'----------------------------------------------------------------------------------------------------
vector_filepath = system.file("shapes/world.gpkg", package = "spData")
new_vector = read_sf(vector_filepath)


## ----02-spatial-data-53, eval=FALSE-----------------------------------------------------------------------------------------------------------------------
## st_crs(new_vector) # get CRS
## #> Coordinate Reference System:
## #>   User input: WGS 84
## #>   wkt:
## #>   ...


## ---- echo=FALSE, eval=FALSE------------------------------------------------------------------------------------------------------------------------------
## # Aim: capture crs for comparison with updated CRS
## new_vector_crs = st_crs(new_vector)


## ----02-spatial-data-54-----------------------------------------------------------------------------------------------------------------------------------
new_vector = st_set_crs(new_vector, "EPSG:4326") # set CRS


## ---- echo=FALSE, eval=FALSE------------------------------------------------------------------------------------------------------------------------------
## waldo::compare(new_vector_crs, st_crs(new_vector))
## # `old$input`: "WGS 84"
## # `new$input`: "EPSG:4326"


## ----02-spatial-data-55-----------------------------------------------------------------------------------------------------------------------------------
raster_filepath = system.file("raster/srtm.tif", package = "spDataLarge")
my_rast = rast(raster_filepath)
cat(crs(my_rast)) # get CRS


## ----02-spatial-data-56-----------------------------------------------------------------------------------------------------------------------------------
crs(my_rast) = "EPSG:26912" # set CRS


## ----06-reproj-2------------------------------------------------------------------------------------------------------------------------------------------
london = data.frame(lon = -0.1, lat = 51.5) |> 
  st_as_sf(coords = c("lon", "lat"))
st_is_longlat(london)


## ----06-reproj-3------------------------------------------------------------------------------------------------------------------------------------------
london_geo = st_set_crs(london, "EPSG:4326")
st_is_longlat(london_geo)


## ----s2geos, fig.cap="The behavior of the geometry operations in the sf package depending on the input data's CRS.", echo=FALSE---------------------------
'digraph G3 {
   layout=dot
   rankdir=TB
   
   node [shape = rectangle];
   rec1 [label = "Spatial data" shape = oval];
   rec2 [label = "Geographic CRS" shape = diamond];
   rec3 [label = "Projected CRS\nor CRS is missing" shape = diamond]
   rec4 [label = "sf uses s2library for \ngeometry operations" center = true];
   rec5 [label = "sf uses GEOS for \ngeometry operations" center = true];
   rec6 [label = "Result" shape = oval weight=100];

   rec1 -> rec2;
   rec1 -> rec3;
   rec2 -> rec4;
   rec3 -> rec5;
   rec4 -> rec6;
   rec5 -> rec6;
   }' -> s2geos
DiagrammeR::grViz(s2geos)


## ----06-reproj-4-1----------------------------------------------------------------------------------------------------------------------------------------
london_buff_no_crs = st_buffer(london, dist = 1)   # incorrect: no CRS
london_buff_s2 = st_buffer(london_geo, dist = 1e5) # silent use of s2
london_buff_s2_100_cells = st_buffer(london_geo, dist = 1e5, max_cells = 100) 


## ----06-reproj-4-2----------------------------------------------------------------------------------------------------------------------------------------
sf::sf_use_s2(FALSE)
london_buff_lonlat = st_buffer(london_geo, dist = 1) # incorrect result
sf::sf_use_s2(TRUE)


## The distance between two lines of longitude, called meridians, is around 111 km at the equator (execute `geosphere::distGeo(c(0, 0), c(1, 0))` to find the precise distance).

## This shrinks to zero at the poles.

## At the latitude of London, for example, meridians are less than 70 km apart (challenge: execute code that verifies this).

## <!-- `geosphere::distGeo(c(0, 51.5), c(1, 51.5))` -->

## Lines of latitude, by contrast, are equidistant from each other irrespective of latitude: they are always around 111 km apart, including at the equator and near the poles (see Figures \@ref(fig:crs-buf) to \@ref(fig:wintriproj)).


## ----06-reproj-6------------------------------------------------------------------------------------------------------------------------------------------
london_proj = data.frame(x = 530000, y = 180000) |> 
  st_as_sf(coords = 1:2, crs = "EPSG:27700")


## ----06-reproj-7, eval=FALSE------------------------------------------------------------------------------------------------------------------------------
## st_crs(london_proj)
## #> Coordinate Reference System:
## #>   User input: EPSG:27700
## #>   wkt:
## #> PROJCRS["OSGB36 / British National Grid",
## #>     BASEGEOGCRS["OSGB36",
## #>         DATUM["Ordnance Survey of Great Britain 1936",
## #>             ELLIPSOID["Airy 1830",6377563.396,299.3249646,
## #>                 LENGTHUNIT["metre",1]]],
## #> ...


## ----06-reproj-8------------------------------------------------------------------------------------------------------------------------------------------
london_buff_projected = st_buffer(london_proj, 1e5)


## ----crs-buf-old, include=FALSE, eval=FALSE---------------------------------------------------------------------------------------------------------------
## uk = rnaturalearth::ne_countries(scale = 50) |>
##   st_as_sf() |>
##   filter(grepl(pattern = "United Kingdom|Ire", x = name_long))
## plot(london_buff_s2, graticule = st_crs(4326), axes = TRUE, reset = FALSE, lwd = 2)
## plot(london_buff_s2_100_cells, lwd = 9, add = TRUE)
## plot(st_geometry(uk), add = TRUE, border = "gray", lwd = 3)
## uk_proj = uk |>
##   st_transform("EPSG:27700")
## plot(london_buff_projected, graticule = st_crs("EPSG:27700"), axes = TRUE, reset = FALSE, lwd = 2)
## plot(london_proj, add = TRUE)
## plot(st_geometry(uk_proj), add = TRUE, border = "gray", lwd = 3)
## plot(london_buff_lonlat, graticule = st_crs("EPSG:27700"), axes = TRUE, reset = FALSE, lwd = 2)
## plot(london_proj, add = TRUE)
## plot(st_geometry(uk), add = TRUE, border = "gray", lwd = 3)


## ----crs-buf, fig.cap="Buffers around London showing results created with the S2 spherical geometry engine on lon/lat data (left), projected data (middle) and lon/lat data without using spherical geometry (right). The left plot illustrates the result of buffering unprojected data with sf, which calls Google's S2 spherical geometry engine by default with `max_cells = 1000` (thin line). The thick 'blocky' line illustrates the result of the same operation with `max_cells = 100`.", fig.scap="Buffers around London with a geographic and projected CRS.", echo=FALSE, fig.asp=0.39, fig.width = 8----
uk = rnaturalearth::ne_countries(scale = 50) |> 
  st_as_sf() |> 
  filter(grepl(pattern = "United Kingdom|Ire", x = name_long))
library(tmap)
tm1 = tm_shape(london_buff_s2, bbox = st_bbox(london_buff_s2_100_cells)) + 
  tm_graticules(lwd = 0.2) +
  tm_borders(col = "black", lwd = 0.5) + 
  tm_shape(london_buff_s2_100_cells) +
  tm_borders(col = "black", lwd = 1.5) +
  tm_shape(uk) +
  tm_polygons(lty = 3, alpha = 0.2, col = "#567D46") +
  tm_shape(london_proj) +
  tm_symbols()

tm2 = tm_shape(london_buff_projected, bbox = st_bbox(london_buff_s2_100_cells)) + 
  tm_grid(lwd = 0.2) +
  tm_borders(col = "black", lwd = 0.5) + 
  tm_shape(uk) +
  tm_polygons(lty = 3, alpha = 0.2, col = "#567D46") +
  tm_shape(london_proj) +
  tm_symbols()

tm3 = tm_shape(london_buff_lonlat, bbox = st_bbox(london_buff_s2_100_cells)) + 
  tm_graticules(lwd = 0.2) +
  tm_borders(col = "black", lwd = 0.5) + 
  tm_shape(uk) +
  tm_polygons(lty = 3, alpha = 0.2, col = "#567D46") +
  tm_shape(london_proj) +
  tm_symbols()

tmap_arrange(tm1, tm2, tm3, nrow = 1)


## ----06-reproj-9, eval=FALSE------------------------------------------------------------------------------------------------------------------------------
## st_distance(london_geo, london_proj)
## # > Error: st_crs(x) == st_crs(y) is not TRUE


## ----06-reproj-12, eval=FALSE, echo=FALSE-----------------------------------------------------------------------------------------------------------------
## utm_nums_n = 32601:32660
## utm_nums_s = 32701:32760
## crs_data = rgdal::make_EPSG()
## crs_data[grep(utm_nums_n[1], crs_data$code), ] # zone 1N
## crs_data[grep(utm_nums_n[60], crs_data$code), ] # zone 60N
## crs_data[grep(utm_nums_s[1], crs_data$code), ]
## crs_data[grep(utm_nums_s[60], crs_data$code), ]
## crs_data[grep("UTM zone 60N", crs_data$note), ] # many
## crs_data[grep("UTM zone 60S", crs_data$note), ] # many
## crs_data[grep("UTM zone 60S", crs_data$note), ] # many
## crs_utm = crs_data[grepl("utm", crs_data$prj4), ] # 1066
## crs_utm_zone = crs_utm[grepl("zone=", crs_utm$prj4), ]
## crs_utm_south = crs_utm[grepl("south", crs_utm$prj4), ]


## ----06-reproj-13-----------------------------------------------------------------------------------------------------------------------------------------
lonlat2UTM = function(lonlat) {
  utm = (floor((lonlat[1] + 180) / 6) %% 60) + 1
  if(lonlat[2] > 0) {
    utm + 32600
  } else{
    utm + 32700
  }
}


## ----06-reproj-14, echo=FALSE, eval=FALSE-----------------------------------------------------------------------------------------------------------------
## stplanr::geo_code("Auckland")


## ----06-reproj-15-----------------------------------------------------------------------------------------------------------------------------------------
lonlat2UTM(c(174.7, -36.9))
lonlat2UTM(st_coordinates(london))


## ----06-reproj-10-----------------------------------------------------------------------------------------------------------------------------------------
london2 = st_transform(london_geo, "EPSG:27700")


## ----06-reproj-11-----------------------------------------------------------------------------------------------------------------------------------------
st_distance(london2, london_proj)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
st_crs(cycle_hire_osm)


## ----06-reproj-16-----------------------------------------------------------------------------------------------------------------------------------------
crs_lnd = st_crs(london_geo)
class(crs_lnd)
names(crs_lnd)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
crs_lnd$Name
crs_lnd$proj4string
crs_lnd$epsg


## ----06-reproj-18, eval=FALSE-----------------------------------------------------------------------------------------------------------------------------
## cycle_hire_osm_projected = st_transform(cycle_hire_osm, "EPSG:27700")
## st_crs(cycle_hire_osm_projected)
## #> Coordinate Reference System:
## #>   User input: EPSG:27700
## #>   wkt:
## #> PROJCRS["OSGB36 / British National Grid",
## #> ...


## ----06-reproj-19-----------------------------------------------------------------------------------------------------------------------------------------
crs_lnd_new = st_crs("EPSG:27700")
crs_lnd_new$Name
crs_lnd_new$proj4string
crs_lnd_new$epsg


## Printing a spatial object in the console automatically returns its coordinate reference system.

## To access and modify it explicitly, use the `st_crs` function, for example, `st_crs(cycle_hire_osm)`.


## Reprojection of the regular rasters is also known as warping.

## Additionally, there is a second similar operation called "transformation".

## Instead of resampling all of the values, it leaves all values intact but recomputes new coordinates for every raster cell, changing the grid geometry.

## For example, it could convert the input raster (a regular grid) into a curvilinear grid.

## The transformation operation can be performed in R using [the **stars** package](https://r-spatial.github.io/stars/articles/stars5.html).


## ---- include=FALSE---------------------------------------------------------------------------------------------------------------------------------------
#test the above idea
library(terra)
library(sf)
con_raster = rast(system.file("raster/srtm.tif", package = "spDataLarge"))
con_raster_ea = project(con_raster, "EPSG:32612", method = "bilinear")

con_poly = st_as_sf(as.polygons(con_raster>0))
con_poly_ea = st_transform(con_poly, "EPSG:32612")

plot(con_raster)
plot(con_poly, col = NA, add = TRUE, lwd = 4)

plot(con_raster_ea)
plot(con_poly_ea, col = NA, add = TRUE, lwd = 4)


## ----06-reproj-29, results='hide'-------------------------------------------------------------------------------------------------------------------------
cat_raster = rast(system.file("raster/nlcd.tif", package = "spDataLarge"))
crs(cat_raster)
#> PROJCRS["NAD83 / UTM zone 12N",
#> ...


## ----06-reproj-30-----------------------------------------------------------------------------------------------------------------------------------------
unique(cat_raster)


## ----06-reproj-31-----------------------------------------------------------------------------------------------------------------------------------------
cat_raster_wgs84 = project(cat_raster, "EPSG:4326", method = "near")


## ----catraster, echo=FALSE--------------------------------------------------------------------------------------------------------------------------------
tibble(
  CRS = c("NAD83", "WGS84"),
  nrow = c(nrow(cat_raster), nrow(cat_raster_wgs84)),
  ncol = c(ncol(cat_raster), ncol(cat_raster_wgs84)),
  ncell = c(ncell(cat_raster), ncell(cat_raster_wgs84)),
  resolution = c(mean(res(cat_raster)), mean(res(cat_raster_wgs84),
                                             na.rm = TRUE)),
  unique_categories = c(length(unique(values(cat_raster))),
                        length(unique(values(cat_raster_wgs84))))) |>
  knitr::kable(caption = paste("Key attributes in the original ('cat\\_raster')", 
                               "and projected ('cat\\_raster\\_wgs84')", 
                               "categorical raster datasets."),
               caption.short = paste("Key attributes in the original and", 
                                     "projected raster datasets"),
               digits = 4, booktabs = TRUE)


## ----06-reproj-32-----------------------------------------------------------------------------------------------------------------------------------------
con_raster = rast(system.file("raster/srtm.tif", package = "spDataLarge"))
crs(con_raster)


## ----06-reproj-34-----------------------------------------------------------------------------------------------------------------------------------------
con_raster_ea = project(con_raster, "EPSG:32612", method = "bilinear")
crs(con_raster_ea)


## ----rastercrs, echo=FALSE--------------------------------------------------------------------------------------------------------------------------------
tibble(
  CRS = c("WGS84", "UTM zone 12N"),
  nrow = c(nrow(con_raster), nrow(con_raster_ea)),
  ncol = c(ncol(con_raster), ncol(con_raster_ea)),
  ncell = c(ncell(con_raster), ncell(con_raster_ea)),
  resolution = c(mean(res(con_raster)), mean(res(con_raster_ea), 
                                             na.rm = TRUE)),
  mean = c(mean(values(con_raster)), mean(values(con_raster_ea), 
                                          na.rm = TRUE))) |>
  knitr::kable(caption = paste("Key attributes in the original ('con\\_raster')", 
                               "and projected ('con\\_raster\\_ea') continuous raster", 
                               "datasets."),
               caption.short = paste("Key attributes in the original and", 
                                     "projected raster datasets"),
               digits = 4, booktabs = TRUE)


## Of course, the limitations of 2D Earth projections apply as much to vector as to raster data.

## At best we can comply with two out of three spatial properties (distance, area, direction).

## Therefore, the task at hand determines which projection to choose.

## For instance, if we are interested in a density (points per grid cell or inhabitants per grid cell) we should use an equal-area projection (see also Chapter \@ref(location)).


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
zion = read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))


## ---- warning=FALSE---------------------------------------------------------------------------------------------------------------------------------------
zion_centr = st_centroid(zion)
zion_centr_wgs84 = st_transform(zion_centr, "EPSG:4326")
st_as_text(st_geometry(zion_centr_wgs84))


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
my_wkt = 'PROJCS["Custom_AEQD",
 GEOGCS["GCS_WGS_1984",
  DATUM["WGS_1984",
   SPHEROID["WGS_1984",6378137.0,298.257223563]],
  PRIMEM["Greenwich",0.0],
  UNIT["Degree",0.0174532925199433]],
 PROJECTION["Azimuthal_Equidistant"],
 PARAMETER["Central_Meridian",-113.0263],
 PARAMETER["Latitude_Of_Origin",37.29818],
 UNIT["Meter",1.0]]'


## ---------------------------------------------------------------------------------------------------------------------------------------------------------
zion_aeqd = st_transform(zion, my_wkt)


## ----06-reproj-22-----------------------------------------------------------------------------------------------------------------------------------------
world_mollweide = st_transform(world, crs = "+proj=moll")


## ----mollproj, fig.cap="Mollweide projection of the world.", warning=FALSE, message=FALSE, echo=FALSE-----------------------------------------------------
library(tmap)
world_mollweide_gr = st_graticule(lat = c(-89.9, seq(-80, 80, 20), 89.9)) |>
  st_transform(crs = "+proj=moll")
tm_shape(world_mollweide_gr) +
  tm_lines(col = "gray") +
  tm_shape(world_mollweide) +
  tm_borders(col = "black") 


## ----06-reproj-23-----------------------------------------------------------------------------------------------------------------------------------------
world_wintri = st_transform(world, crs = "+proj=wintri")


## ----06-reproj-23-tests, eval=FALSE, echo=FALSE-----------------------------------------------------------------------------------------------------------
## world_wintri = lwgeom::st_transform_proj(world, crs = "+proj=wintri")
## world_wintri2 = st_transform(world, crs = "+proj=wintri")
## world_tissot = st_transform(world, crs = "+proj=tissot +lat_1=60 +lat_2=65")
## waldo::compare(world_wintri$geom[1], world_wintri2$geom[1])
## world_tpers = st_transform(world, crs = "+proj=tpers +h=5500000 +lat_0=40")
## plot(st_cast(world_tpers, "MULTILINESTRING")) # fails
## plot(st_coordinates(world_tpers)) # fails
## world_tpers_complete = world_tpers[st_is_valid(world_tpers), ]
## world_tpers_complete = world_tpers_complete[!st_is_empty(world_tpers_complete), ]
## plot(world_tpers_complete["pop"])


## ----wintriproj, fig.cap="Winkel tripel projection of the world.", echo=FALSE-----------------------------------------------------------------------------
world_wintri_gr = st_graticule(lat = c(-89.9, seq(-80, 80, 20), 89.9)) |>
  st_transform(crs = "+proj=wintri")
library(tmap)
tm_shape(world_wintri_gr) + tm_lines(col = "gray") +
  tm_shape(world_wintri) + tm_borders(col = "black")


## The three main functions for transformation of simple features coordinates are `sf::st_transform()`, `sf::sf_project()`, and `lwgeom::st_transform_proj()`.

## `st_transform()` uses the GDAL interface to PROJ, while `sf_project()` (which works with two-column numeric matrices, representing points) and `lwgeom::st_transform_proj()` use PROJ directly.

## `st_tranform()` is appropriate for most situations, and provides a set of the most often used parameters and well-defined transformations.

## `sf_project()` may be suited for point transformations when speed is important.

## `st_transform_proj()` allows for greater customization of a projection, which includes cases when some of the PROJ parameters (e.g., `+over`) or projection (`+proj=wintri`) is not available in `st_transform()`.


## ----06-reproj-25, eval=FALSE, echo=FALSE-----------------------------------------------------------------------------------------------------------------
## # demo of sf_project
## mat_lonlat = as.matrix(data.frame(x = 0:20, y = 50:70))
## plot(mat_lonlat)
## mat_projected = sf_project(from = st_crs(4326)$proj4string, to = st_crs(27700)$proj4string, pts = mat_lonlat)
## plot(mat_projected)


## ----06-reproj-27-----------------------------------------------------------------------------------------------------------------------------------------
world_laea2 = st_transform(world,
                           crs = "+proj=laea +x_0=0 +y_0=0 +lon_0=-74 +lat_0=40")


## ----laeaproj2, fig.cap="Lambert azimuthal equal-area projection of the world centered on New York City.", fig.scap="Lambert azimuthal equal-area projection centered on New York City.", warning=FALSE, echo=FALSE----
# Currently fails, see https://github.com/Robinlovelace/geocompr/issues/460
world_laea2_g = st_graticule(ndiscr = 10000) |>
  st_transform("+proj=laea +x_0=0 +y_0=0 +lon_0=-74 +lat_0=40.1 +ellps=WGS84 +no_defs") |>
  st_geometry()
tm_shape(world_laea2_g) + tm_lines(col = "gray") +
  tm_shape(world_laea2) + tm_borders(col = "black")
# knitr::include_graphics("https://user-images.githubusercontent.com/1825120/72223267-c79a4780-3564-11ea-9d7e-9644523e349b.png")


## ---- echo=FALSE, results='asis'--------------------------------------------------------------------------------------------------------------------------
res = knitr::knit_child('_07-ex.Rmd', quiet = TRUE, options = list(include = FALSE, eval = FALSE))
cat(res, sep = '\n')

