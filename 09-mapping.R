## ----08-mapping-1, message=FALSE----------------------------------------------------------------------
library(sf)
library(terra)
library(dplyr)
library(spData)
library(spDataLarge)


## ----08-mapping-2, message=FALSE----------------------------------------------------------------------
# remotes::install_github("r-tmap/tmap@v4")
library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(ggplot2) # tidyverse data visualization package


## ----04-spatial-operations-1-1------------------------------------------------------------------------
nz_elev = rast(system.file("raster/nz_elev.tif", package = "spDataLarge"))


## ----08-mapping-3, eval=FALSE-------------------------------------------------------------------------
## # Add fill layer to nz shape
tm_shape(nz) +
  tm_fill()
## # Add border layer to nz shape
tm_shape(nz) +
  tm_borders()
## # Add fill and border layers to nz shape
tm_shape(nz) +
  tm_fill() +
  tm_borders()


## ----tmshape, echo=FALSE, message=FALSE, fig.cap="New Zealand's shape plotted with fill (left), border (middle) and fill and border (right) layers added using tmap functions.", fig.scap="New Zealand's shape plotted using tmap functions."----
source("https://github.com/geocompx/geocompr/raw/main/code/09-tmshape.R", print.eval = TRUE)


## `qtm()` is a handy function to create **q**uick **t**hematic **m**aps (hence the snappy name).

## It is concise and provides a good default visualization in many cases:

## `qtm(nz)`, for example, is equivalent to `tm_shape(nz) + tm_fill() + tm_borders()`.

## Further, layers can be added concisely using multiple `qtm()` calls, such as `qtm(nz) + qtm(nz_height)`.

## The disadvantage is that it makes aesthetics of individual layers harder to control, explaining why we avoid teaching it in this chapter.


## ----08-mapping-4-------------------------------------------------------------------------------------
map_nz = tm_shape(nz) + tm_polygons()
class(map_nz)


## ----08-mapping-5, results='hide'---------------------------------------------------------------------
map_nz1 = map_nz +
  tm_shape(nz_elev) + tm_raster(col_alpha = 0.7)


## ----08-mapping-6-------------------------------------------------------------------------------------
nz_water = st_union(nz) |> 
  st_buffer(22200) |> 
  st_cast(to = "LINESTRING")

map_nz2 = map_nz1 +
  tm_shape(nz_water) + tm_lines()


## ----08-mapping-7-------------------------------------------------------------------------------------

# toDo
# could not find function "tm_dots"
map_nz3 = map_nz2 +
  tm_shape(nz_height) + tm_dots()

map_nz3 = map_nz2 +
  tm_shape(nz_height) + tm_symbols()

## ----tmlayers, message=FALSE, fig.cap="Maps with additional layers added to the final map of Figure 9.1.", fig.scap="Additional layers added to the output of Figure 9.1."----
tmap_arrange(map_nz1, map_nz2, map_nz3)


## ----tmstatic, message=FALSE, fig.cap="The impact of changing commonly used fill and border aesthetics to fixed values.", fig.scap="The impact of changing commonly used aesthetics."----
ma1 = tm_shape(nz) + tm_polygons(fill = "red")
ma2 = tm_shape(nz) + tm_polygons(fill = "red", fill_alpha = 0.3)
ma3 = tm_shape(nz) + tm_polygons(col = "blue")
ma4 = tm_shape(nz) + tm_polygons(lwd = 3)
ma5 = tm_shape(nz) + tm_polygons(lty = 2)
ma6 = tm_shape(nz) + tm_polygons(fill = "red", fill_alpha = 0.3,
                                 col = "blue", lwd = 3, lty = 2)

tmap_arrange(ma1, ma2, ma3, ma4, ma5, ma6)


## ----08-mapping-8, echo=FALSE, eval=FALSE-------------------------------------------------------------
## # aim: show what happpens when names clash
# toDo
library(tmap)
library(spData)
nz$red = 1:nrow(nz)

# toDO
# could not find function "qtm"
qtm(nz, "red")


## ----08-mapping-9, eval=FALSE-------------------------------------------------------------------------
plot(st_geometry(nz), col = nz$Land_area)  # works
tm_shape(nz) + tm_fill(col = nz$Land_area) # fails
## #> Error: palette should be a character value
## #> Error: Fill argument neither colors nor valid variable name(s)


## ----08-mapping-10, fig.show='hide', message=FALSE----------------------------------------------------
tm_shape(nz) + tm_polygons(fill = "Land_area")

## ----tmcol, message=FALSE, fig.cap="Comparison of base (left) and tmap (right) handling of a numeric color field.", fig.scap="Comparison of base graphics and tmap", echo=FALSE, out.width="45%", fig.show='hold', warning=FALSE, message=FALSE----
plot(nz["Land_area"])
tm_shape(nz) + tm_polygons(fill = "Land_area")


## ----08-mapping-11------------------------------------------------------------------------------------
# toDo
# ?expressions
legend_title = expression("Area (km"^2*")")
legend_title = "Area (km^2^)"
map_nza = tm_shape(nz) +
  tm_polygons(fill = "Land_area", fill.legend = tm_legend(title = legend_title))

## ----08-mapping-12, eval=FALSE------------------------------------------------------------------------
# toDo
tm_shape(nz) + tm_polygons(fill = "Median_income")
breaks = c(0, 3, 4, 5) * 10000
tm_shape(nz) + tm_polygons(fill = "Median_income",
                           fill.scale = tm_scale(breaks = breaks))
tm_shape(nz) + tm_polygons(fill = "Median_income",
                           fill.scale = tm_scale(n = 10))
tm_shape(nz) + tm_polygons(fill = "Median_income",
                           fill.scale = tm_scale(values = "BuGn")) ## arg name?


## ----tmpal, message=FALSE, fig.cap="Illustration of settings that affect color settings. The results show (from left to right): default settings, manual breaks, n breaks, and the impact of changing the palette.", fig.scap="Illustration of settings that affect color settings.", echo=FALSE, fig.asp=0.56----
source("https://github.com/geocompx/geocompr/raw/main/code/09-tmpal.R", print.eval = TRUE)


## ----break-styles, message=FALSE, fig.cap="Illustration of different binning methods set using the style argument in tmap.", , fig.scap="Illustration of different binning methods using tmap.", echo=FALSE----
source("https://github.com/geocompx/geocompr/raw/main/code/09-break-styles.R", print.eval = TRUE)


## Although `style` is an argument of **tmap** functions, in fact it originates as an argument in `classInt::classIntervals()` --- see the help page of this function for details.


## ----08-mapping-13, eval=FALSE------------------------------------------------------------------------
tm_shape(nz) + tm_polygons("Population", fill.scale = tm_scale(values = "Blues"))
tm_shape(nz) + tm_polygons("Population", fill.scale = tm_scale(values = "YlOrBr"))
# 

## ----colpal, echo=FALSE, message=FALSE, fig.cap="Examples of categorical, sequential and diverging palettes.", out.width="50%"----
# toDo
library(RColorBrewer)
many_palette_plotter = function(color_names, n, titles){
  n_colors = length(color_names)
  ylim = c(0, n_colors)
  par(mar = c(0, 5, 0, 0))
  plot(1, 1, xlim = c(0, max(n)), ylim = ylim,
       type = "n", axes = FALSE, bty = "n", xlab = "", ylab = "")
  
  for(i in seq_len(n_colors)){
    one_color = brewer.pal(n = n, name = color_names[i])
    rect(xleft = 0:(n - 1), ybottom = i - 1, xright = 1:n, ytop = i - 0.2,
         col = one_color, border = "light gray")
    }
  text(rep(-0.1, n_colors), (1: n_colors) - 0.6, labels = titles, xpd = TRUE, adj = 1)
}

many_palette_plotter(c("PRGn", "YlGn", "Set2"), 7, 
                     titles = c("Diverging", "Sequential", "Categorical"))


## ----na-sb, message=FALSE, fig.cap="Map with additional elements - a north arrow and scale bar.", out.width="50%", fig.asp=1, fig.scap="Map with a north arrow and scale bar."----
map_nz + 
  tm_compass(type = "8star", position = c("left", "top")) +
  tm_scale_bar(breaks = c(0, 100, 200), text.size = 1, position = c("left", "top"))


## ----08-mapping-14, eval=FALSE------------------------------------------------------------------------
map_nz + tm_title("New Zealand")
map_nz + tm_layout(scale = 5)
map_nz + tm_layout(bg.color = "lightblue")
map_nz + tm_layout(frame = FALSE)


## ----layout1, message=FALSE, fig.cap="Layout options specified by (from left to right) title, scale, bg.color and frame arguments.", fig.scap="Layout options specified by the tmap arguments.", echo=FALSE, fig.asp=0.56----
source("https://github.com/geocompx/geocompr/raw/main/code/09-layout1.R", print.eval = TRUE)


## ----layout2, message=FALSE, fig.cap="Illustration of selected layout options.", echo=FALSE, fig.asp=0.56----
# todo: add more useful settings to this plot
source("https://github.com/geocompx/geocompr/raw/main/code/09-layout2.R", print.eval = TRUE)


## ----layout3, message=FALSE, fig.cap="Illustration of selected color-related layout options.", echo=FALSE, fig.asp=0.56----
source("https://github.com/geocompx/geocompr/raw/main/code/09-layout3.R", print.eval = TRUE)


## ----08-mapping-15, eval=FALSE------------------------------------------------------------------------
# toDo
map_nza + tm_style("gray")
map_nza + tm_style("classic")
# ??
map_nza + tm_style("cobalt")
map_nza + tm_style("col_blind")


## ----tmstyles, message=FALSE, fig.cap="Selected tmap styles.", fig.scap="Selected tmap styles.", echo=FALSE, fig.asp=0.56----
source("https://github.com/geocompx/geocompr/raw/main/code/09-tmstyles.R", print.eval = TRUE)


## A preview of predefined styles can be generated by executing `tmap_style_catalogue()`.

## This creates a folder called `tmap_style_previews` containing nine images.

## Each image, from `tm_style_albatross.png` to `tm_style_white.png`, shows a faceted map of the world in the corresponding style.

## Note: `tmap_style_catalogue()` takes some time to run.


## ----urban-facet, message=FALSE, fig.cap="Faceted map showing the top 30 largest urban agglomerations from 1970 to 2030 based on population projections by the United Nations.", fig.scap="Faceted map showing urban agglomerations.", fig.asp=0.5----
urb_1970_2030 = urban_agglomerations |> 
  filter(year %in% c(1970, 1990, 2010, 2030))

tm_shape(world) +
  tm_polygons() +
  tm_shape(urb_1970_2030) +
  tm_symbols(fill = "black", col = "white", size = "population_millions") +
  tm_facets(by = "year", nrow = 2, free.coords = FALSE)


## ----08-mapping-16------------------------------------------------------------------------------------
nz_region = st_bbox(c(xmin = 1340000, xmax = 1450000,
                      ymin = 5130000, ymax = 5210000),
                    crs = st_crs(nz_height)) |> 
  st_as_sfc()


## ----08-mapping-17------------------------------------------------------------------------------------
nz_height_map = tm_shape(nz_elev, bbox = nz_region) +
  tm_raster()

nz_height_map = tm_shape(nz_elev, bbox = nz_region) +
  tm_raster(col.scale = tm_scale_continuous(values = "YlGn")) +
  tm_shape(nz_height) + tm_symbols(shape = 2, col = "red", size = 1) +
  tm_scale_bar(position = c("left", "bottom"))

## ----08-mapping-18------------------------------------------------------------------------------------
nz_map = tm_shape(nz) + tm_polygons() +
  tm_shape(nz_height) + tm_symbols(shape = 2, col = "red", size = 0.1) + 
  tm_shape(nz_region) + tm_borders(lwd = 3) 


## ----insetmap1, message=FALSE, fig.cap="Inset map providing a context - location of the central part of the Southern Alps in New Zealand.", fig.scap="Inset map providing a context."----
library(grid)
nz_height_map
print(nz_map, vp = viewport(0.8, 0.27, width = 0.5, height = 0.5))


## ----08-mapping-19------------------------------------------------------------------------------------
us_states_map = tm_shape(us_states, projection = "EPSG:2163") + 
  tm_polygons() + 
  tm_layout(frame = FALSE)


## ----08-mapping-20------------------------------------------------------------------------------------
hawaii_map = tm_shape(hawaii) +
  tm_polygons() + 
  tm_title("Hawaii") +
  tm_layout(frame = FALSE, bg.color = NA, 
            title.position = c("LEFT", "BOTTOM"))
alaska_map = tm_shape(alaska) +
  tm_polygons() + 
  tm_title("Alaska") +
  tm_layout(frame = FALSE, bg.color = NA)


## ----insetmap2, message=FALSE, fig.cap="Map of the United States."------------------------------------
us_states_map
print(hawaii_map, vp = grid::viewport(0.35, 0.1, width = 0.2, height = 0.1))
print(alaska_map, vp = grid::viewport(0.15, 0.15, width = 0.3, height = 0.3))


## ----urban-animated, message=FALSE, fig.cap="Animated map showing the top 30 largest urban agglomerations from 1950 to 2030 based on population projects by the United Nations. Animated version available online at: r.geocompx.org.", fig.scap="Animated map showing the top 30 largest 'urban agglomerations'.", echo=FALSE----
if (knitr::is_latex_output()){
    knitr::include_graphics("figures/urban-animated.png")
} else if (knitr::is_html_output()){
    knitr::include_graphics("figures/urban-animated.gif")
}


## ----08-mapping-21, echo=FALSE, eval=FALSE------------------------------------------------------------
## source("https://github.com/geocompx/geocompr/raw/main/code/09-urban-animation.R")


## ----08-mapping-22------------------------------------------------------------------------------------
# toDo
# could not find function "tm_dots"
# something is wrong...
urb_anim = tm_shape(world) + tm_polygons() + 
  tm_shape(urban_agglomerations) + tm_symbols(size = "population_millions") +
  tm_facets(pages = "year", free.coords = FALSE)


## ----08-mapping-23, eval=FALSE------------------------------------------------------------------------
## tmap_animation(urb_anim, filename = "urb_anim.gif", delay = 25)


## ----08-mapping-24, echo=FALSE, eval=FALSE------------------------------------------------------------
## source("https://github.com/geocompx/geocompr/raw/main/code/09-usboundaries.R")


## ----animus, echo=FALSE, message=FALSE, fig.cap="Animated map showing population growth, state formation and boundary changes in the United States, 1790-2010. Animated version available online at r.geocompx.org.", fig.scap="Animated map showing boundary changes in the United States."----
u_animus_html = "https://user-images.githubusercontent.com/1825120/38543030-5794b6f0-3c9b-11e8-9da9-10ec1f3ea726.gif"
u_animus_pdf = "figures/animus.png"
if (knitr::is_latex_output()){
    knitr::include_graphics(u_animus_pdf)  
} else if (knitr::is_html_output()){
    knitr::include_graphics(u_animus_html)  
}


## ----08-mapping-25, eval=FALSE------------------------------------------------------------------------
## tmap_mode("view")
## map_nz


## ----tmview, message=FALSE, fig.cap="Interactive map of New Zealand created with tmap in view mode. Interactive version available online at: r.geocompx.org.", fig.scap="Interactive map of New Zealand.", echo=FALSE----
if (knitr::is_latex_output()){
    knitr::include_graphics("figures/tmview-1.png")
} else if (knitr::is_html_output()){
    # tmap_mode("view")
    # m_tmview = map_nz
    # tmap_save(m_tmview, "tmview-1.html")
    # file.copy("tmview-1.html", "~/geocompr/geocompr.github.io/static/img/tmview-1.html")
    knitr::include_url("https://geocompx.org/static/img/tmview-1.html")
}



## ----08-mapping-26, eval=FALSE------------------------------------------------------------------------
## map_nz + tm_basemap(server = "OpenTopoMap")


## ----08-mapping-27, eval=FALSE------------------------------------------------------------------------
world_coffee = left_join(world, coffee_data, by = "name_long")
facets = c("coffee_production_2016", "coffee_production_2017")
tm_shape(world_coffee) + tm_polygons(facets) +
  tm_facets(nrow = 1, sync = TRUE)


## ----sync, message=FALSE, fig.cap="Faceted interactive maps of global coffee production in 2016 and 2017 in sync, demonstrating tmap's view mode in action.", fig.scap="Faceted interactive maps of global coffee production.", echo=FALSE----
knitr::include_graphics("figures/interactive-facets.png")


## ----08-mapping-28------------------------------------------------------------------------------------
tmap_mode("plot")


## ----08-mapping-39, fig.show='hide', message=FALSE----------------------------------------------------
library(cartogram)
nz_carto = cartogram_cont(nz, "Median_income", itermax = 5)
tm_shape(nz_carto) + tm_polygons("Median_income")


## ----cartomap1, echo=FALSE, message=FALSE, fig.cap="Comparison of standard map (left) and continuous area cartogram (right).", fig.scap="Comparison of standard map and continuous area cartogram."----
carto_map1 = tm_shape(nz) + 
  tm_polygons("Median_income",
              fill.scale = tm_scale(values = "Greens"),
              fill.legend = tm_legend(title = "Median income (NZD)"))
carto_map2 = tm_shape(nz_carto) + 
  tm_polygons("Median_income",
              fill.scale = tm_scale(values = "Greens"),
              fill.legend = tm_legend(title = "Median income (NZD)"))
tmap_arrange(carto_map1, carto_map2)


## ----08-mapping-40, fig.show='hide', message=FALSE----------------------------------------------------
us_states2163 = st_transform(us_states, "EPSG:2163")
us_states2163_ncont = cartogram_ncont(us_states2163, "total_pop_15")
us_states2163_dorling = cartogram_dorling(us_states2163, "total_pop_15")


## ----cartomap2, echo=FALSE, message=FALSE, fig.cap="Comparison of non-continuous area cartogram (left) and Dorling cartogram (right).", fig.scap="Comparison of cartograms.", fig.asp=0.32----
carto_map3 = tm_shape(us_states2163_ncont) + 
  tm_polygons("total_pop_15",
              fill.scale = tm_scale(values = "BuPu"),
              fill.legend = tm_legend(title = "Total population")) +
  tm_layout(legend.show = FALSE)
carto_map4 = tm_shape(us_states2163_dorling) + 
  tm_polygons("total_pop_15",
              fill.scale = tm_scale(values = "BuPu"),
              fill.legend = tm_legend(title = "Total population")) +
  tm_layout(legend.show = FALSE)

# toDo
# legend.only = TRUE??
carto_map_34legend = tm_shape(us_states2163_dorling) + 
  tm_polygons("total_pop_15",
              fill.scale = tm_scale(values = "BuPu"),
              fill.legend = tm_legend(title = "Total population")) +
  tm_layout(legend.only = TRUE)
tmap_arrange(carto_map3, carto_map4, carto_map_34legend, ncol = 3)
