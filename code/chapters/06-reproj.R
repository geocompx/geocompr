## ----06-reproj-1, message=FALSE------------------------------------------
library(sf)
library(raster)
library(dplyr)
library(spData)
library(spDataLarge)

## ----06-reproj-2---------------------------------------------------------
london = data.frame(lon = -0.1, lat = 51.5) %>% 
  st_as_sf(coords = c("lon", "lat"))
st_is_longlat(london)

## ----06-reproj-3---------------------------------------------------------
london_geo = st_set_crs(london, 4326)
st_is_longlat(london_geo)

## ----06-reproj-4---------------------------------------------------------
london_buff_no_crs = st_buffer(london, dist = 1)
london_buff = st_buffer(london_geo, dist = 1)

## The distance between two lines of longitude, called meridians, is around 111 km at the equator (execute `geosphere::distGeo(c(0, 0), c(1, 0))` to find the precise distance).

## ----06-reproj-6---------------------------------------------------------
london_proj = data.frame(x = 530000, y = 180000) %>% 
  st_as_sf(coords = 1:2, crs = 27700)

## ----06-reproj-7, eval=FALSE---------------------------------------------
## st_crs(london_proj)
## #> Coordinate Reference System:
## #>   EPSG: 27700
## #>   proj4string: "+proj=tmerc +lat_0=49 +lon_0=-2 ... +units=m +no_defs"

## ----06-reproj-8---------------------------------------------------------
london_proj_buff = st_buffer(london_proj, 111320)

## ----crs-buf, fig.cap="Buffers around London with a geographic (left) and projected (right) CRS. The gray outline represents the UK coastline.", fig.scap="Buffers around London with a geographic and projected CRS.",  fig.asp=1, fig.show='hold', out.width="45%", echo=FALSE----
uk = rnaturalearth::ne_countries(scale = 50) %>% 
  st_as_sf() %>% 
  filter(grepl(pattern = "United Kingdom|Ire", x = name_long))
plot(london_buff, graticule = st_crs(4326), axes = TRUE, reset = FALSE)
plot(london_geo, add = TRUE)
plot(st_geometry(uk), add = TRUE, border = "gray", lwd = 3)
uk_proj = uk %>%
  st_transform(27700)
plot(london_proj_buff, graticule = st_crs(27700), axes = TRUE, reset = FALSE)
plot(london_proj, add = TRUE)
plot(st_geometry(uk_proj), add = TRUE, border = "gray", lwd = 3)

## ----06-reproj-9, eval=FALSE---------------------------------------------
## st_distance(london_geo, london_proj)
## # > Error: st_crs(x) == st_crs(y) is not TRUE

## ----06-reproj-10--------------------------------------------------------
london2 = st_transform(london_geo, 27700)

## ----06-reproj-11--------------------------------------------------------
st_distance(london2, london_proj)

## ----06-reproj-12, eval=FALSE, echo=FALSE--------------------------------
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

## ----06-reproj-13--------------------------------------------------------
lonlat2UTM = function(lonlat) {
  utm = (floor((lonlat[1] + 180) / 6) %% 60) + 1
  if(lonlat[2] > 0) {
    utm + 32600
  } else{
    utm + 32700
  }
}

## ----06-reproj-14, echo=FALSE, eval=FALSE--------------------------------
## stplanr::geo_code("Auckland")

## ----06-reproj-15--------------------------------------------------------
epsg_utm_auk = lonlat2UTM(c(174.7, -36.9))
epsg_utm_lnd = lonlat2UTM(st_coordinates(london))
st_crs(epsg_utm_auk)$proj4string
st_crs(epsg_utm_lnd)$proj4string

## ----06-reproj-16--------------------------------------------------------
crs_lnd = st_crs(cycle_hire_osm)
class(crs_lnd)
crs_lnd$epsg

## ----06-reproj-17, eval=FALSE, echo=FALSE--------------------------------
## crs1 = st_crs("+proj=longlat +datum=WGS84")
## crs2 = st_crs("+datum=WGS84 +proj=longlat")
## crs3 = st_crs(4326)
## crs1 == crs2
## crs1 == crs3

## ----06-reproj-18--------------------------------------------------------
cycle_hire_osm_projected = st_transform(cycle_hire_osm, 27700)

## ----06-reproj-19--------------------------------------------------------
crs_codes = rgdal::make_EPSG()[1:2]
dplyr::filter(crs_codes, code == 27700)

## ----06-reproj-20, eval=FALSE--------------------------------------------
## st_crs(27700)$proj4string
## #> [1] "+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 ...

## Printing a spatial object in the console, automatically returns its coordinate reference system.

## ----06-reproj-22--------------------------------------------------------
world_mollweide = st_transform(world, crs = "+proj=moll")

## ----mollproj, echo=FALSE, fig.cap="Mollweide projection of the world.", warning=FALSE----
library(tmap)
world_mollweide_gr = st_graticule(lat = c(-89.9, seq(-80, 80, 20), 89.9)) %>%
  lwgeom::st_transform_proj(crs = "+proj=moll")
tm_shape(world_mollweide_gr) + tm_lines(col = "gray") +
  tm_shape(world_mollweide) + tm_borders(col = "black") 

## ----06-reproj-23--------------------------------------------------------
world_wintri = lwgeom::st_transform_proj(world, crs = "+proj=wintri")

## ----wintriproj, echo=FALSE, fig.cap="Winkel tripel projection of the world.", error=TRUE----
# world_wintri_gr = st_graticule(lat = c(-89.9, seq(-80, 80, 20), 89.9)) %>%
#   lwgeom::st_transform_proj(crs = "+proj=wintri")
# m = tm_shape(world_wintri_gr) + tm_lines(col = "gray") +
#   tm_shape(world_wintri) + tm_borders(col = "black")
# tmap_save(m, "images/wintriproj-1.png", width = 1152, height = 711, dpi = 150)
knitr::include_graphics("images/wintriproj-1.png")

## The three main functions for transformation of simple features coordinates are `sf::st_transform()`, `sf::sf_project()`, and `lwgeom::st_transform_proj()`.

## ----06-reproj-25, eval=FALSE, echo=FALSE--------------------------------
## # demo of sf_project
## mat_lonlat = as.matrix(data.frame(x = 0:20, y = 50:70))
## plot(mat_lonlat)
## mat_projected = sf_project(from = st_crs(4326)$proj4string, to = st_crs(27700)$proj4string, pts = mat_lonlat)
## plot(mat_projected)

## ----06-reproj-26--------------------------------------------------------
world_laea1 = st_transform(world, 
                           crs = "+proj=laea +x_0=0 +y_0=0 +lon_0=0 +lat_0=0")

## ----laeaproj1, echo=FALSE, fig.cap="Lambert azimuthal equal-area projection of the world centered on longitude and latitude of 0.", fig.scap="Lambert azimuthal equal-area projection of the world", warning=FALSE----
world_laea1_g = st_graticule(ndiscr = 10000) %>%
  st_transform("+proj=laea +x_0=0 +y_0=0 +lon_0=0 +lat_0=0") %>% 
  st_geometry()
tm_shape(world_laea1_g) + tm_lines(col = "gray") +
  tm_shape(world_laea1) + tm_borders(col = "black")

## ----06-reproj-27--------------------------------------------------------
world_laea2 = st_transform(world,
                           crs = "+proj=laea +x_0=0 +y_0=0 +lon_0=-74 +lat_0=40")

## ----laeaproj2, echo=FALSE, fig.cap="Lambert azimuthal equal-area projection of the world centered on New York City.", fig.scap="Lambert azimuthal equal-area projection centered on New York City.", warning=FALSE----
world_laea2_g = st_graticule(ndiscr = 10000) %>%
  st_transform("+proj=laea +x_0=0 +y_0=0 +lon_0=-74 +lat_0=40.1 +ellps=WGS84 +no_defs") %>% 
  st_geometry()
tm_shape(world_laea2_g) + tm_lines(col = "gray") +
  tm_shape(world_laea2) + tm_borders(col = "black")

## It is possible to use a EPSG code in a `proj4string` definition with `"+init=epsg:MY_NUMBER"`.

## ----06-reproj-29--------------------------------------------------------
cat_raster = raster(system.file("raster/nlcd2011.tif", package = "spDataLarge"))
crs(cat_raster)

## ----06-reproj-30--------------------------------------------------------
unique(cat_raster)

## ----06-reproj-31--------------------------------------------------------
wgs84 = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
cat_raster_wgs84 = projectRaster(cat_raster, crs = wgs84, method = "ngb")

## ----catraster, echo=FALSE-----------------------------------------------
data_frame(
  CRS = c("NAD83", "WGS84"),
  nrow = c(nrow(cat_raster), nrow(cat_raster_wgs84)),
  ncol = c(ncol(cat_raster), ncol(cat_raster_wgs84)),
  ncell = c(ncell(cat_raster), ncell(cat_raster_wgs84)),
  resolution = c(mean(res(cat_raster)), mean(res(cat_raster_wgs84),
                                             na.rm = TRUE)),
  unique_categories = c(length(unique(values(cat_raster))),
                        length(unique(values(cat_raster_wgs84))))) %>%
  knitr::kable(caption = paste("Key attributes in the original ('cat_raster')", 
                               "and projected ('cat_raster_wgs84')", 
                               "categorical raster datasets."),
               caption.short = paste("Key attributes in the original and", 
                                     "projected raster datasets"),
               digits = 4, booktabs = TRUE)

## ----06-reproj-32--------------------------------------------------------
con_raster = raster(system.file("raster/srtm.tif", package = "spDataLarge"))
crs(con_raster)

## ----06-reproj-33, echo=FALSE, eval=FALSE--------------------------------
## # aim: check class
## class(con_raster)
## class(values(con_raster))
## values(con_raster) = sqrt(values(con_raster))
## class(values(con_raster))

## ----06-reproj-34--------------------------------------------------------
equalarea = "+proj=laea +lat_0=37.32 +lon_0=-113.04"
con_raster_ea = projectRaster(con_raster, crs = equalarea, method = "bilinear")
crs(con_raster_ea)

## ----rastercrs, echo=FALSE-----------------------------------------------
data_frame(
  CRS = c("WGS84", "Equal-area"),
  nrow = c(nrow(con_raster), nrow(con_raster_ea)),
  ncol = c(ncol(con_raster), ncol(con_raster_ea)),
  ncell = c(ncell(con_raster), ncell(con_raster_ea)),
  resolution = c(mean(res(cat_raster)), mean(res(cat_raster_wgs84), 
                                             na.rm = TRUE)),
  mean = c(mean(values(con_raster)), mean(values(con_raster_ea), 
                                          na.rm = TRUE))) %>%
  knitr::kable(caption = paste("Key attributes in the original ('con_raster')", 
                               "and projected ('con_raster') continuous raster", 
                               "datasets."),
               caption.short = paste("Key attributes in the original and", 
                                     "projected raster datasets"),
               digits = 4, booktabs = TRUE)

## Of course, the limitations of 2D Earth projections apply as much to vector as to raster data.

## ----06-reproj-36, eval=FALSE, echo=FALSE--------------------------------
## st_crs(nz)
## nz_wgs = st_transform(nz, 4326)
## nz_crs = st_crs(nz)
## nz_wgs_crs = st_crs(nz_wgs)
## nz_crs$epsg
## nz_wgs_crs$epsg
## st_bbox(nz)
## st_bbox(nz_wgs)
## nz_wgs_NULL_crs = st_set_crs(nz_wgs, NA)
## nz_27700 = st_transform(nz_wgs, 27700)
## par(mfrow = c(1, 3))
## plot(st_geometry(nz))
## plot(st_geometry(nz_wgs))
## plot(st_geometry(nz_wgs_NULL_crs))
## # answer: it is fatter in the East-West direction
## # because New Zealand is close to the South Pole and meridians converge there
## plot(st_geometry(nz_27700))
## par(mfrow = c(1, 1))

## ----06-reproj-37, echo=FALSE, eval=FALSE--------------------------------
## # see https://github.com/r-spatial/sf/issues/509
## world_tmerc = st_transform(world, "+proj=tmerc")
## plot(st_geometry(world_tmerc))
## world_4326 = st_transform(world_tmerc, 4326)
## plot(st_geometry(world_4326))

## ----06-reproj-38, echo=FALSE, eval=FALSE--------------------------------
## con_raster = raster(system.file("raster/srtm.tif", package = "spDataLarge"))
## con_raster_utm12n = projectRaster(con_raster, crs = utm12n, method = "ngb")
## con_raster_utm12n

## ----06-reproj-39, echo=FALSE, eval=FALSE--------------------------------
## wgs84 = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
## cat_raster_wgs84 = projectRaster(cat_raster, crs = wgs84, method = "bilinear")
## cat_raster_wgs84

## ----06-reproj-40, echo=FALSE, eval=FALSE--------------------------------
## new_p4s = "+proj=laea +ellps=WGS84 +lon_0=-95 +lat_0=60 +units=m"
## canada = dplyr::filter(world, name_long == "Canada")
## new_canada = st_transform(canada, new_p4s)
## par(mfrow = c(1, 2))
## plot(st_geometry(canada), graticule = TRUE, axes = TRUE)
## plot(st_geometry(new_canada), graticule = TRUE, axes = TRUE)

