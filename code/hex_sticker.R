library(sf)
library(raster)
library(dplyr)
library(ggplot2)
library(hexSticker)
library(showtext)

# read the logo file and change its extent --------------------------------
r = raster("images/r_logo.tif")
r = setExtent(r, extent(c(-49, 49, -50, 50)))
crs(r) = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"

# polygonize the logo (time-consuming)-------------------------------------
v = spex::polygonize(r) %>% 
  mutate(id = ifelse(r_logo==255, 0, 1)) %>% 
  group_by(id) %>% 
  summarise() %>% 
  filter(id == 1)

# saveRDS(v, "v.rds")
# v = readRDS("v.rds")

# create a graticule ------------------------------------------------------
gr = st_graticule(ndiscr = 1000) %>% 
  st_transform("+proj=laea +y_0=0 +lon_0=0 +lat_0=0 +ellps=WGS84 +no_defs")

# create a map ------------------------------------------------------------
p = ggplot(fill = "transparent") + 
  geom_sf(data = gr, size = 0.0001) +
  geom_sf(data = v, fill = "#2066b9") +
  coord_sf(crs = st_crs(gr)) + 
  theme(
    panel.background = element_rect(fill = "transparent") # bg of the panel
    , plot.background = element_rect(fill = "transparent", color = NA) # bg of the plot
    , panel.grid.major = element_blank() # get rid of major grid
    , panel.grid.minor = element_blank() # get rid of minor grid
    , legend.background = element_rect(fill = "transparent") # get rid of legend bg
    , legend.box.background = element_rect(fill = "transparent") # get rid of legend panel bg
  )

# add a new font ----------------------------------------------------------
font_add_google("Fjalla One", "fs")

# create a sticker --------------------------------------------------------
sticker(
  subplot = p,
  s_x = 1,
  s_y = 1.1,
  s_width = 1.7, 
  s_height = 1.7, 
  h_size = 2,
  package = "geocompr",
  p_family = "fs",
  p_size = 12,
  p_color = "#2066b9",
  p_x = 1,
  p_y = 0.33,
  h_fill = "white",
  h_color = "#2066b9",
  filename = "images/geocompr_hex.png"
)

# create an animation ------------------------------------------------------
# library(magick)
# plotter2 = function(lon_0, y){
#   x = st_graticule(ndiscr = 10000) %>% 
#     st_transform(paste0("+proj=laea +y_0=0 +lon_0=", lon_0, " +lat_0=0 +ellps=WGS84 +no_defs"))
#   y = st_geometry(y) %>% 
#     st_transform(st_crs("+proj=laea +y_0=0 +lon_0=0 +lat_0=0 +ellps=WGS84 +no_defs"))
#   y = y + c(lon_0, 0)
#   plot(st_geometry(x), col = "grey")
#   plot(st_geometry(y), add = TRUE, col = "blue")
# }
# 
# img = image_graph(600, 600, res = 96)
# seq(21, 1, by = -3) %>% map(plotter2, v)
# dev.off()
# animation = image_animate(img, fps = 10)
# print(animation)
# 
