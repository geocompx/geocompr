## ---- message = FALSE----------------------------------------------------
library(sf)
library(spData)
library(spDataLarge)
library(tidyverse)

## ------------------------------------------------------------------------
library(leaflet) # for interactive maps
# library(mapview) # for interactive maps
library(shiny)   # for web applications
library(tmap)    # for static and interactive maps

## ---- eval=FALSE---------------------------------------------------------
## # Add fill layer to nz shape
## tm_shape(nz) + tm_fill()
## # Add border layer to nz shape
## tm_shape(nz) + tm_borders()
## # Add fill and border layers to nz shape
## tm_shape(nz) + tm_fill() + tm_borders()

## ----tmshape, echo=FALSE, fig.cap="New Zealand's shape plotted with fill (left), border (middle) and fill *and* border (right) layers added using **tmap** functions."----
source("code/09-tmshape.R")

## `qtm()` is a handy function for **q**uickly creating **t**map **m**aps (hence the snappy name).

## ------------------------------------------------------------------------
map_nz = tm_shape(nz) + tm_polygons()
class(map_nz)

## ---- results='hide'-----------------------------------------------------
map_nz1 = map_nz +
  tm_shape(nz_height) + tm_bubbles()

## ------------------------------------------------------------------------
nz_water = st_union(nz) %>% st_buffer(22200) %>%
  st_cast(to = "LINESTRING")
map_nz2 = map_nz1 +
  tm_shape(nz_water) + tm_lines()

## ------------------------------------------------------------------------
map_nz3 = map_nz2 +
  tm_shape(nz_height) + tm_dots()

## ----tmlayers, fig.cap="Maps with additional layers added to the final map of Figure 9.1."----
tmap_arrange(map_nz1, map_nz2, map_nz3)

## ----tmstatic, fig.cap="The impact of changing commonly used fill and border aesthetics to fixed values."----
ma1 = tm_shape(nz) + tm_fill(col = "red")
ma2 = tm_shape(nz) + tm_fill(col = "red", alpha = 0.3)
ma3 = tm_shape(nz) + tm_borders(col = "blue")
ma4 = tm_shape(nz) + tm_borders(lwd = 3)
ma5 = tm_shape(nz) + tm_borders(lty = 2)
ma6 = tm_shape(nz) + tm_fill(col = "red", alpha = 0.3) +
  tm_borders(col = "blue", lwd = 3, lty = 2)
tmap_arrange(ma1, ma2, ma3, ma4, ma5, ma6)

## ---- eval=FALSE---------------------------------------------------------
## plot(nz$geometry, col = 1:nrow(nz))      # works
## tm_shape(nz) + tm_fill(col = 1:nrow(nz)) # fails:
## #> Error: Fill argument neither colors nor valid variable name(s)

## ---- fig.show='hide'----------------------------------------------------
nz$col = 1:nrow(nz)
tm_shape(nz) + tm_fill(col = "col")

## ----tmcol, fig.cap="Comparison of base (left) and tmap (right) handling of a numeric color field.", echo=FALSE, out.width="50%", fig.show='hold'----
plot(nz["col"])    
tm_shape(nz) + tm_fill(col = "col")

## ------------------------------------------------------------------------
nz$REGC2017_NAME = as.character(nz$REGC2017_NAME)
nz_a = nz[1:9, ]

## ------------------------------------------------------------------------
tm_shape(nz_a) + tm_polygons(col = "AREA_SQ_KM")

## ------------------------------------------------------------------------
tm_shape(nz_a) + tm_polygons(col = "REGC2017_NAME")

## ---- eval=FALSE---------------------------------------------------------
## breaks = c(0, 3, 4, 5) * 10000
## tm_shape(nz) + tm_fill(col = "AREA_SQ_KM")
## tm_shape(nz) + tm_fill(col = "AREA_SQ_KM", breaks = breaks)
## tm_shape(nz) + tm_fill(col = "AREA_SQ_KM", n = 10)
## tm_shape(nz) + tm_fill(col = "AREA_SQ_KM", palette = "RdBu")

## ----tmpal, fig.cap="Illustration of settings that affect variable aesthetics. The result shows a continuous variable (the area in square kilometers of regions in New Zealand) converted to color with (from left to right): default settings, manual breaks, n breaks, and an alternative palette.", echo=FALSE----
source("code/09-tmpal.R", print.eval = TRUE)

## ------------------------------------------------------------------------
legend_title = expression("Area (km"^2*")")
map_nza = tm_shape(nz) +
  tm_fill(col = "AREA_SQ_KM", title = legend_title) + tm_borders()

## ---- eval=FALSE---------------------------------------------------------
## map_nz + tm_layout(title = "New Zealand")
## map_nz + tm_layout(scale = 5)
## map_nz + tm_layout(bg.color = "lightblue")
## map_nz + tm_layout(frame = FALSE)

## ----layout1, fig.cap="Layout options specified by (from left to right) title, scale, bg.color and frame arguments.", echo=FALSE----
source("code/09-layout1.R")

## ----layout2, fig.cap="Illustration of selected layout options.", echo=FALSE----
# todo: add more useful settings to this plot
source("code/09-layout2.R")

## ----layout3, fig.cap="Illustration of selected color-related layout options.", echo=FALSE----
source("code/09-layout3.R")

## ----break-styles, fig.cap="Illustration of different binning methods set using the syle argument in tmap.", echo=FALSE----
source("code/09-break-styles.R")

## ---- eval=FALSE---------------------------------------------------------
## map_nza + tm_style_bw()
## map_nza + tm_style_classic()
## map_nza + tm_style_cobalt()
## map_nza + tm_style_col_blind()

## ----tmstyles, fig.cap="Selected tmap styles: bw, classic, cobalt and color blind (from left to right).", echo=FALSE----
source("code/09-tmstyles.R")

## A preview of predefined styles can be generated by executing `tmap_style_catalogue()`.

## ----urban-facet, fig.cap="Faceted map showing the top 30 largest 'urban agglomerations' from 1970 to 2030 based on population projects by the United Nations.", fig.asp=0.4----
urb_1970_2030 = urban_agglomerations %>% 
  filter(year %in% c(1970, 1990, 2010, 2030))
tm_shape(world) + tm_polygons() + 
  tm_shape(urb_1970_2030) +
  tm_dots(size = "population_millions") +
  tm_facets(by = "year", nrow = 2, free.coords = FALSE)

## ------------------------------------------------------------------------
nz_region = st_bbox(c(xmin = 1340000, xmax = 1450000, ymin = 5130000, ymax = 5210000),
                    crs = st_crs(nz_height)) %>% 
  st_as_sfc() 

## ------------------------------------------------------------------------
nz_map = tm_shape(nz) +
  tm_polygons() +
  tm_shape(nz_height) +
  tm_symbols(shape = 2, col = "red", size = 0.1) + 
  tm_shape(nz_region) +
  tm_borders(lwd = 3) + 
  tm_layout(frame = FALSE)

## ------------------------------------------------------------------------
nz_height_map = tm_shape(nz_elev, bbox = tmaptools::bb(nz_region)) +
  tm_raster(style = "cont", palette = "-Spectral",
            auto.palette.mapping = FALSE, legend.show = FALSE) +
  tm_shape(nz_height) +
  tm_symbols(shape = 2, col = "red", size = 0.1)

## ----insetmap1, fig.cap="Inset map showing the central part of the Southern Alps in New Zealand."----
library(grid)
nz_map
print(nz_height_map, vp = grid::viewport(0.3, 0.7, width = 0.4, height = 0.4))

## ------------------------------------------------------------------------
us_states_map = tm_shape(us_states, projection = 2163) +
  tm_polygons() + 
  tm_layout(frame = FALSE)

## ------------------------------------------------------------------------
hawaii_map = tm_shape(hawaii) +
  tm_polygons() + 
  tm_layout(title = "Hawaii", frame = FALSE, bg.color = NA, 
            title.position = c("left", "bottom"))
alaska_map = tm_shape(alaska) +
  tm_polygons() + 
  tm_layout(title = "Alaska", frame = FALSE, bg.color = NA)

## ----insetmap2, fig.cap="Map of the United States."----------------------
us_states_map
print(hawaii_map, vp = viewport(x = 0.4, y = 0.1, width = 0.2, height = 0.1))
print(alaska_map, vp = viewport(x = 0.15, y = 0.15, width = 0.3, height = 0.3))

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## library(globe)

## ----nz-plot, fig.cap="Map of New Zealand created with plot(). The legend to the left refers to elevation (1000 m above sea level)."----
g = st_graticule(nz, lon = c(170, 175), lat = c(-45, -40, -35))
plot(nz_water, graticule = g, axes = TRUE, col = "blue")
raster::plot(nz_elev / 1000, add = TRUE)
plot(nz$geometry, add = TRUE)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # RgoogleMaps example: not working
## nz_cent = st_union(nz) %>% st_centroid()
## bg_map = RgoogleMaps::GetMap(center = c(40, -176), zoom = 9)
## nz_wgs = st_transform(nz, 3857)
## plot(nz_wgs$geometry, bgMap = bg_map)

## ----nz-gg, fig.cap="Map of New Zealand created with ggplot2."-----------
library(ggplot2)
g1 = ggplot(nz) + geom_sf(aes(fill = col)) +
  geom_sf(data = nz_height) +
  scale_x_continuous(breaks = c(170, 175))
g1

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## plotly::ggplotly(g1)

## ---- echo=FALSE, fig.cap="Selected mapping packages, with associated metrics."----
# readRDS("extdata/pkg_table.Rds")

## ----urban-animated, fig.cap="Animated map showing the top 30 largest 'urban agglomerations' from 1950 to 2030 based on population projects by the United Nations.", echo=FALSE----
knitr::include_graphics("figures/urban-animated.gif")

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## source("code/09-urban-animation.R")

## ------------------------------------------------------------------------
us_anim = tm_shape(world) +
  tm_polygons() + 
  tm_shape(urban_agglomerations) +
  tm_dots(size = "population_millions") +
  tm_facets(by = "year", free.coords = FALSE, nrow = 1, ncol = 1)

## ---- eval = FALSE-------------------------------------------------------
## tmap_animation(us_anim, filename = "us_anim.gif", delay = 25)

## ---- eval=FALSE---------------------------------------------------------
## library(tmap)
## statepop = historydata::us_state_populations %>%
##   dplyr::select(-GISJOIN) %>% rename(NAME = state)
## statepop_wide = spread(statepop, year, population, sep = "_")
## statepop_sf = left_join(spData::us_states, statepop_wide) %>%
##   st_transform(2163)
## # map_dbl(statepop_sf, ~sum(is.na(.)))  # looks about right
## year_vars = names(statepop_sf)[grepl("year", names(statepop_sf))]
## facet_anim = tm_shape(statepop_sf) + tm_fill(year_vars) + tm_facets(free.scales.fill = FALSE,
##   ncol = 1, nrow = 1)
## animation_tmap(tm = facet_anim, filename = "figures/09-us_pop.gif")

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## source("code/09-usboundaries.R")

## ---- echo=FALSE---------------------------------------------------------
knitr::include_graphics("figures/09-us_pop.gif")

## In **shiny** apps these are often split into `ui.R` (short for user interface) and `server.R` files, naming conventions used by [`shiny-server`](https://github.com/rstudio/shiny-server), a server-side Linux application for serving shiny apps on public-facing websites

## ---- eval=FALSE---------------------------------------------------------
## ui = fluidPage(
##   sliderInput(inputId = "life", "Life expectancy", 0, 80, value = 80),
##       leafletOutput(outputId = "map")
##   )
## server = function(input, output) {
##   output$map = renderLeaflet({
##     leaflet() %>% addProviderTiles("OpenStreetMap.BlackAndWhite") %>%
##       addPolygons(data = world[world$lifeExp > input$life, ])})
## }
## shinyApp(ui, server)

## ----lifeApp, echo=FALSE, fig.cap="Minimal example of a web mapping application created with **shiny**."----
knitr::include_app("https://bookdown.org/robinlovelace/lifeapp/")

## There are a number of ways to run a **shiny** app.

## ----coffeeApp, echo=FALSE, fig.cap="coffeeApp, a simple web mapping application for exploring global coffee production in 2016 and 2017."----
knitr::include_app("https://bookdown.org/robinlovelace/coffeeapp/")

