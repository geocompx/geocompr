## ---- message=FALSE------------------------------------------------------
library(sf)
library(raster)
library(tidyverse)
library(spData)
library(spDataLarge)

## ------------------------------------------------------------------------
london = data.frame(lon = -0.1, lat = 51.5) %>% 
  st_as_sf(coords = c("lon", "lat"))
st_is_longlat(london)

## ------------------------------------------------------------------------
london_geo = st_set_crs(london, 4326)
st_is_longlat(london_geo)

## ------------------------------------------------------------------------
london_buff_no_crs = st_buffer(london, dist = 1)
london_buff = st_buffer(london_geo, dist = 1)

## The distance between two lines of longitude, called meridians, is around 111 km at the equator (execute `geosphere::distGeo(c(0, 0), c(1, 0))` to find the precise distance).

## ------------------------------------------------------------------------
london_proj = data.frame(x = 530000, y = 180000) %>% 
  st_as_sf(coords = 1:2, crs = 27700)

## ---- eval=FALSE---------------------------------------------------------
## st_crs(london_proj)
## #> Coordinate Reference System:
## #>   EPSG: 27700
## #>   proj4string: "+proj=tmerc +lat_0=49 +lon_0=-2 ... +units=m +no_defs"

## ------------------------------------------------------------------------
london_proj_buff = st_buffer(london_proj, 111320)

## ----crs-buf, fig.cap="Buffer on vector representations of London with a geographic (left) and projected (right) CRS. The circular point represents London and the grey outline represents the outline of the UK.", fig.asp=1, fig.show='hold', out.width="45%", echo=FALSE----
uk = rnaturalearth::ne_countries(scale = 50) %>% 
  st_as_sf() %>% 
  filter(grepl(pattern = "United Kingdom|Ire", x = name_long))
plot(london_buff, graticule = st_crs(4326), axes = TRUE)
plot(london_geo, add = TRUE)
plot(st_geometry(uk), add = TRUE, border = "grey", lwd = 3)
uk_proj = uk %>%
  st_transform(27700)
plot(london_proj_buff, graticule = st_crs(27700), axes = TRUE)
plot(london_proj, add = TRUE)
plot(st_geometry(uk_proj), add = TRUE, border = "grey", lwd = 3)

## ---- eval=FALSE---------------------------------------------------------
## st_distance(london_geo, london_proj)
## # > Error: st_crs(x) == st_crs(y) is not TRUE

## ------------------------------------------------------------------------
london2 = st_transform(london_geo, 27700)

## ------------------------------------------------------------------------
st_distance(london2, london_proj)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
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

## ------------------------------------------------------------------------
lonlat2UTM = function(lonlat) {
  utm = (floor((lonlat[1] + 180) / 6) %% 60) + 1
  if(lonlat[2] > 0) utm + 32600 else
    utm + 32700
}

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## stplanr::geo_code("Auckland")

## ------------------------------------------------------------------------
epsg_utm_auk = lonlat2UTM(c(174.7, -36.9))
epsg_utm_lnd = lonlat2UTM(st_coordinates(london))
st_crs(epsg_utm_auk)$proj4string
st_crs(epsg_utm_lnd)$proj4string

## ------------------------------------------------------------------------
crs_lnd = st_crs(cycle_hire_osm)
class(crs_lnd)
crs_lnd$epsg

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## crs1 = st_crs("+proj=longlat +datum=WGS84")
## crs2 = st_crs("+datum=WGS84 +proj=longlat")
## crs3 = st_crs(4326)
## crs1 == crs2
## crs1 == crs3

## ------------------------------------------------------------------------
cycle_hire_osm_projected = st_transform(cycle_hire_osm, 27700)

## ------------------------------------------------------------------------
crs_codes = rgdal::make_EPSG()[1:2]
dplyr::filter(crs_codes, code == 27700)

## ---- eval=FALSE---------------------------------------------------------
## st_crs(27700)$proj4string
## #> [1] "+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000 ...

## Printing a spatial object in the console, automatically returns its coordinate reference system.

## ------------------------------------------------------------------------
world_mollweide = st_transform(world, crs = "+proj=moll")

## ----mollproj, echo=FALSE, fig.cap="Mollweide projection of the world.", warning=FALSE----
par_old = par()
par(mar = c(0, 0, 1, 0))
plot(st_geometry(world_mollweide), graticule = TRUE, main = "the Mollweide projection")
par(par_old)

## ------------------------------------------------------------------------
world_wintri = lwgeom::st_transform_proj(world, crs = "+proj=wintri")

## ----wintriproj, echo=FALSE, fig.cap="Winkel tripel projection of the world.", warning=FALSE----
world_wintri_gr = st_graticule(lat = c(-89.9, seq(-80, 80, 20), 89.9)) %>% 
  lwgeom::st_transform_proj(crs = "+proj=wintri")
par_old = par()
par(mar = c(0, 0, 1, 0))
plot(st_geometry(world_wintri_gr), main = "the Winkel tripel projection", col = "grey")
plot(st_geometry(world_wintri), add = TRUE)
par(par_old)

## The two main functions for transformation of simple features coordinates are `sf::st_transform()` and `sf::sf_project()`.

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # demo of sf_project
## mat_lonlat = as.matrix(data.frame(x = 0:20, y = 50:70))
## plot(mat_lonlat)
## mat_projected = sf_project(from = st_crs(4326)$proj4string, to = st_crs(27700)$proj4string, pts = mat_lonlat)
## plot(mat_projected)

## ------------------------------------------------------------------------
world_laea1 = st_transform(world, crs = "+proj=laea +x_0=0 +y_0=0 +lon_0=0 +lat_0=0")

## ----laeaproj1, echo=FALSE, fig.cap="Lambert azimuthal equal-area projection of the world centered on longitude and latitude of 0.", warning=FALSE----
par_old = par()
par(mar = c(0, 0, 1, 0))
plot(st_geometry(world_laea1), graticule = TRUE, main = "the Lambert azimuthal equal-area projection")
par(par_old)

## ------------------------------------------------------------------------
world_laea2 = st_transform(world, crs = "+proj=laea +x_0=0 +y_0=0 +lon_0=-74 +lat_0=40")

## ----laeaproj2, echo=FALSE, fig.cap="Lambert azimuthal equal-area projection of the world centered on New York City.", warning=FALSE----
world_laea2_g = st_graticule(ndiscr = 10000) %>%
  st_transform("+proj=laea +x_0=0 +y_0=0 +lon_0=-74 +lat_0=40.1 +ellps=WGS84 +no_defs") %>% 
  st_geometry()
par_old = par()
par(mar = c(0, 0, 1, 0))
plot(world_laea2_g, main = "the Lambert azimuthal equal-area projection", col = "grey")
plot(st_geometry(world_laea2), add = TRUE)
par(par_old)

## It is possible to use a EPSG code in a `proj4string` definition with `"+init=epsg:MY_NUMBER"`.

## ------------------------------------------------------------------------
cat_raster = raster(system.file("raster/nlcd2011.tif", package = "spDataLarge"))
crs(cat_raster)

## ------------------------------------------------------------------------
unique(cat_raster)

## ------------------------------------------------------------------------
wgs84 = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
cat_raster_wgs84 = projectRaster(cat_raster, crs = wgs84, method = "ngb")

## ----catraster, echo=FALSE-----------------------------------------------
data_frame(
  CRS = c("NAD83", "WGS84"),
  nrow = c(nrow(cat_raster), nrow(cat_raster_wgs84)),
  ncol = c(ncol(cat_raster), ncol(cat_raster_wgs84)),
  ncell = c(ncell(cat_raster), ncell(cat_raster_wgs84)),
  resolution = c(mean(res(cat_raster)), mean(res(cat_raster_wgs84), na.rm = TRUE)),
  unique_categories = c(length(unique(values(cat_raster))), length(unique(values(cat_raster_wgs84))))
) %>% knitr::kable(caption = "Key attributes in the original ('cat_raster') and projected ('cat_raster_wgs84') categorical raster datasets.", digits = 4)

## ------------------------------------------------------------------------
con_raster = raster(system.file("raster/srtm.tif", package = "spDataLarge"))
crs(con_raster)

## ------------------------------------------------------------------------
equalarea = "+proj=laea +lat_0=37.32 +lon_0=-113.04"
con_raster_ea = projectRaster(con_raster, crs = equalarea, method = "bilinear")
crs(con_raster_ea)

## ----rastercrs, echo=FALSE-----------------------------------------------
data_frame(
  CRS = c("WGS84", "Equal-area"),
  nrow = c(nrow(con_raster), nrow(con_raster_ea)),
  ncol = c(ncol(con_raster), ncol(con_raster_ea)),
  ncell = c(ncell(con_raster), ncell(con_raster_ea)),
  resolution = c(mean(res(cat_raster)), mean(res(cat_raster_wgs84), na.rm = TRUE)),
  mean = c(mean(values(con_raster)), mean(values(con_raster_ea), na.rm = TRUE))
) %>% knitr::kable(caption = "Key attributes original ('con_raster') and projected ('con_raster') continuous raster datasets.", digits = 4)

## Of course, the limitations of 2D Earth projections apply as much to vector as to raster data.

## ---- eval=FALSE, echo=FALSE---------------------------------------------
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

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## # see https://github.com/r-spatial/sf/issues/509
## world_tmerc = st_transform(world, "+proj=tmerc")
## plot(st_geometry(world_tmerc))
## world_4326 = st_transform(world_tmerc, 4326)
## plot(st_geometry(world_4326))

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## con_raster = raster(system.file("raster/srtm.tif", package="spDataLarge"))
## con_raster_wgs84 = projectRaster(con_raster, crs = wgs84, method = "ngb")
## con_raster_wgs84

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## wgs84 = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
## cat_raster_wgs84 = projectRaster(cat_raster, crs = wgs84, method = "bilinear")
## cat_raster_wgs84

