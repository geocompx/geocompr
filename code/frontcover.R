# load packages ----
library(raster)
library(sf)
library(spData)
library(ggplot2)
library(hexSticker)
library(raster)
library(rcartocolor)
library(ggimage)
library(tidyverse)
library(gridExtra)
library(spex)
library(spDataLarge)
library(stplanr)
library(cartogram)
library(rasterVis)

# NZ map plot -------------------------------------------------------------
data("world", "nz", package = "spData")
dem = getData("alt",
              country = "NZL",
              mask = FALSE,
              path = tempdir())
dem = dem[[1]]
dem_2 = aggregate(dem, 50)
nz = st_transform(nz, proj4string(dem))
south_nz = crop(dem_2, as(nz[10:16,], "Spatial"))
south_nz = as.data.frame(south_nz, xy = TRUE)

p1 = ggplot(nz) +
  geom_sf(data = st_geometry(nz[1:9,])) +
  coord_sf(crs = st_crs(st_geometry(nz[1:9,])), datum = NA) +
  geom_tile(data = south_nz, aes(x, y, fill = NZL1_alt)) +
  scale_fill_carto_c(type = "diverging",
                     palette = "Fall",
                     na.value = NA) +
  theme_void() +
  guides(fill = FALSE)
p1

s_x = 1.05
s_y = 1.05
s_width = 1.5
s_height = 1.5
h1 = hexagon(fill = NA, color = "#000000") + geom_subview(
  subview = p1,
  x = s_x,
  y = s_y,
  width = s_width,
  height = s_height
)
h1

# console logo plot -------------------------------------------------------
p2 = grid::textGrob("> geo::",
                    gp = grid::gpar(
                      col = "blue",
                      cex = 3
                    ))

s_x = 1.0
s_y = 1.0
s_width = 3.5
s_height = 3.5
h2 = hexagon(fill = NA, color = "#000000") + geom_subview(
  subview = p2,
  x = s_x,
  y = s_y,
  width = s_width,
  height = s_height
)
h2

#  geomcompr logo plot ----------------------------------------------------
r = raster("images/r_logo.tif")
r = raster::aggregate(r, 4)

r = setExtent(r, extent(c(-49, 49,-50, 50)))
crs(r) = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"

v = spex::polygonize(r) %>%
  mutate(id = ifelse(r_logo == 255, 0, 1)) %>%
  group_by(id) %>%
  summarise() %>%
  filter(id == 1)
gr = st_graticule(ndiscr = 1000) %>%
  st_transform("+proj=laea +y_0=0 +lon_0=0 +lat_0=0 +ellps=WGS84 +no_defs")

p3 = ggplot(fill = "transparent") +
  geom_sf(data = gr, size = 0.0001) +
  geom_sf(data = v, fill = "#2066b9") +
  coord_sf(crs = st_crs(gr)) +
  theme(
    panel.background = element_rect(fill = "transparent") # bg of the panel
    ,
    plot.background = element_rect(fill = "transparent", color = NA) # bg of the plot
    ,
    panel.grid.major = element_blank() # get rid of major grid
    ,
    panel.grid.minor = element_blank() # get rid of minor grid
    ,
    legend.background = element_rect(fill = "transparent") # get rid of legend bg
    ,
    legend.box.background = element_rect(fill = "transparent") # get rid of legend panel bg
  )

s_x = 1
s_y = 1
s_width = 1.4
s_height = 1.4

h3 = hexagon(fill = NA, color = "#000000") + geom_subview(
  subview = p3,
  x = s_x,
  y = s_y,
  width = s_width,
  height = s_height
)
h3

# network plot ------------------------------------------------------------
zones_attr = bristol_od %>%
  group_by(o) %>%
  summarize_if(is.numeric, sum) %>%
  dplyr::rename(geo_code = o)

zones_joined = left_join(bristol_zones, zones_attr, by = "geo_code")

zones_od = bristol_od %>%
  group_by(d) %>%
  summarize_if(is.numeric, sum) %>%
  dplyr::select(geo_code = d, all_dest = all) %>%
  inner_join(zones_joined, ., by = "geo_code")

od_top5 = bristol_od %>%
  arrange(desc(all)) %>%
  top_n(5, wt = all)

bristol_od$Active = (bristol_od$bicycle + bristol_od$foot) /
  bristol_od$all * 100

od_intra = filter(bristol_od, o == d)
od_inter = filter(bristol_od, o != d)
desire_lines = od2line(od_inter, zones_od)

desire_lines$Active_breaks = cut(
  desire_lines$Active,
  breaks = c(0, 5, 10, 20, 40, 100),
  include.lowest = TRUE
)

p4 = ggplot(desire_lines) +
  geom_sf(aes(colour = Active_breaks), lwd = 0.1, alpha = 0.01) +
  theme_void() +
  scale_colour_viridis_d(breaks = c(0, 5, 10, 20, 40, 100), option = "C") +
  theme(panel.grid.major = element_line(colour = 'transparent')) +
  guides(colour = FALSE)

s_x = 0.95
s_y = 0.9
s_width = 1.55
s_height = 1.55

h4 = hexagon(fill = NA, color = "#000000") + geom_subview(
  subview = p4,
  x = s_x,
  y = s_y,
  width = s_width,
  height = s_height
)
h4

# geocompr map 1 plot -----------------------------------------------------
us_states2163 = st_transform(us_states, 2163)
us_states2163_ncont = cartogram_ncont(us_states2163, "total_pop_15")

p5 = ggplot(us_states2163_ncont) +
  geom_sf(aes(fill = total_pop_15), lwd = 0.25) +
  coord_sf(crs = st_crs(us_states2163_ncont), datum = NA) +
  scale_fill_viridis_c(option = "D") +
  theme(panel.grid.major = element_line(colour = 'transparent')) +
  guides(fill = FALSE) +
  theme_void()

s_x = 1
s_y = 0.95
s_width = 1.5
s_height = 1.5

h5 = hexagon(fill = NA, color = "#000000") + geom_subview(
  subview = p5,
  x = s_x,
  y = s_y,
  width = s_width,
  height = s_height
)
h5

# geocompr map 2 plot -----------------------------------------------------
srtm = raster(system.file("raster/srtm.tif", package = "spDataLarge"))
zion = read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))
zion = st_transform(zion, projection(srtm))
srtm_masked = mask(srtm, as(zion, "Spatial"))

p6 = gplot(srtm_masked) +
  geom_raster(aes(fill = value)) +
  scale_fill_carto_c(palette = 'TealRose', na.value = NA) +
  geom_sf(data = st_cast(zion, "LINESTRING"), inherit.aes = FALSE) +
  theme_void() +
  guides(fill = FALSE) +
  theme(panel.grid.major = element_line(colour = 'transparent'))

s_x = 1
s_y = 1
s_width = 1.4
s_height = 1.4

h6 = hexagon(fill = NA, color = "#000000") + geom_subview(
  subview = p6,
  x = s_x,
  y = s_y,
  width = s_width,
  height = s_height
)
h6


# final plot arrangement  -------------------------------------------------
final_plot = function(hex1, hex2, hex3, hex4, hex5, hex6){
  p = ggplot() +
    coord_equal(xlim = c(0, 30),
                ylim = c(0, 30),
                expand = c(0, 0)) +
    
    annotation_custom(
      ggplotGrob(hex1),
      xmin = 0.5,
      xmax = 8.5,
      ymin = 21,
      ymax = 29
    ) +
    
    annotation_custom(
      ggplotGrob(hex3),
      xmin = 3.8,
      xmax = 11.8,
      ymin = 15.2,
      ymax = 23.2
    ) +
    
    annotation_custom(
      ggplotGrob(hex2),
      xmin = 7.2,
      xmax = 15.2,
      ymin = 21,
      ymax = 29
    ) +
    
    annotation_custom(
      ggplotGrob(hex4),
      xmin = 10.5,
      xmax = 18.5,
      ymin = 15.2,
      ymax = 23.2
    ) +
    
    
    annotation_custom(
      ggplotGrob(hex5),
      xmin = 0.5,
      xmax = 8.5,
      ymin = 9.4,
      ymax = 17.4
    ) +
    
    
    annotation_custom(
      ggplotGrob(hex6),
      xmin = 7.2,
      xmax = 15.2,
      ymin = 9.4,
      ymax = 17.4
    ) +
    
    labs(x = NULL, y = NULL) +
    theme_void()
  print(p)
}

final_plot(h6, h4, h2, h3, h5, h1)
ggsave("geocompr_cover.pdf", width = 12, height = 18)
browseURL("geocompr_cover.pdf")

