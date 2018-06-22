## ---- message=FALSE------------------------------------------------------
library(sf)
library(raster)
library(tidyverse)
library(spData)
library(spDataLarge)

## ---- message=FALSE------------------------------------------------------
library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(mapview) # for interactive maps
library(shiny)   # for web applications

## ---- eval=FALSE---------------------------------------------------------
## # Add fill layer to nz shape
## tm_shape(nz) +
##   tm_fill()
## # Add border layer to nz shape
## tm_shape(nz) +
##   tm_borders()
## # Add fill and border layers to nz shape
## tm_shape(nz) +
##   tm_fill() +
##   tm_borders()

## ----tmshape, echo=FALSE, fig.cap="New Zealand's shape plotted with fill (left), border (middle) and fill *and* border (right) layers added using **tmap** functions."----
source("code/08-tmshape.R", print.eval = TRUE)

## `qtm()` is a handy function for **q**uickly creating **t**map **m**aps (hence the snappy name).

## ------------------------------------------------------------------------
map_nz = tm_shape(nz) + tm_polygons()
class(map_nz)

## ---- results='hide'-----------------------------------------------------
map_nz1 = map_nz +
  tm_shape(nz_elev) + tm_raster(alpha = 0.7)

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

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## # aim: show what happpens when names clash
## library(tmap)
## library(spData)
## nz$red = 1:nrow(nz)
## qtm(nz, "red")

## ---- eval=FALSE---------------------------------------------------------
## plot(st_geometry(nz), col = nz$Land_area)  # works
## tm_shape(nz) + tm_fill(col = nz$Land_area) # fails
## #> Error: Fill argument neither colors nor valid variable name(s)

## ---- fig.show='hide'----------------------------------------------------
tm_shape(nz) + tm_fill(col = "Land_area")

## ----tmcol, fig.cap="Comparison of base (left) and tmap (right) handling of a numeric color field.", echo=FALSE, out.width="50%", fig.show='hold'----
plot(nz["Land_area"])    
tm_shape(nz) + tm_fill(col = "Land_area")

## ------------------------------------------------------------------------
legend_title = expression("Area (km"^2*")")
map_nza = tm_shape(nz) +
  tm_fill(col = "Land_area", title = legend_title) + tm_borders()

## ---- eval=FALSE---------------------------------------------------------
## breaks = c(0, 3, 4, 5) * 10000
## tm_shape(nz) + tm_polygons(col = "Median_income")
## tm_shape(nz) + tm_polygons(col = "Median_income", breaks = breaks)
## tm_shape(nz) + tm_polygons(col = "Median_income", n = 10)
## tm_shape(nz) + tm_polygons(col = "Median_income", palette = "RdBu")

## ----tmpal, fig.cap="Illustration of settings that affect color settings. The results show (from left to right): default settings, manual breaks, n breaks, and the impact of changing the palette.", echo=FALSE----
source("code/08-tmpal.R", print.eval = TRUE)

## ----break-styles, fig.cap="Illustration of different binning methods set using the style argument in tmap.", echo=FALSE----
source("code/08-break-styles.R", print.eval = TRUE)

## Although `style` is an argument of **tmap** functions it in fact originates as an argument in `classInt::classIntervals()` --- see the help page of this function for details.

## ---- eval=FALSE---------------------------------------------------------
## tm_shape(nz) + tm_polygons("Population", palette = "Blues")
## tm_shape(nz) + tm_polygons("Population", palette = "YlOrBr")

## ----colpal, echo=FALSE, fig.cap="Examples of categorical, sequential and diverging palettes."----
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
         col = one_color, border = "light grey")
    }
  text(rep(-0.1, n_colors), (1: n_colors) - 0.6, labels = titles, xpd = TRUE, adj = 1)
}

many_palette_plotter(c("PRGn", "YlGn", "Set2"), 7, 
                     titles = c("Diverging", "Sequential", "Categorical"))

## ----na-sb, fig.cap="Map with additional elements - a north arrow and scale bar."----
map_nz + 
  tm_compass(type = "8star", position = c("left", "top")) +
  tm_scale_bar(breaks = c(0, 100, 200), size = 1)

## ---- eval=FALSE---------------------------------------------------------
## map_nz + tm_layout(title = "New Zealand")
## map_nz + tm_layout(scale = 5)
## map_nz + tm_layout(bg.color = "lightblue")
## map_nz + tm_layout(frame = FALSE)

## ----layout1, fig.cap="Layout options specified by (from left to right) title, scale, bg.color and frame arguments.", echo=FALSE----
source("code/08-layout1.R", print.eval = TRUE)

## ----layout2, fig.cap="Illustration of selected layout options.", echo=FALSE----
# todo: add more useful settings to this plot
source("code/08-layout2.R", print.eval = TRUE)

## ----layout3, fig.cap="Illustration of selected color-related layout options.", echo=FALSE----
source("code/08-layout3.R", print.eval = TRUE)

## ---- eval=FALSE---------------------------------------------------------
## map_nza + tm_style("bw")
## map_nza + tm_style("classic")
## map_nza + tm_style("cobalt")
## map_nza + tm_style("col_blind")

## ----tmstyles, fig.cap="Selected tmap styles: bw, classic, cobalt and col_blind (from left to right).", echo=FALSE----
source("code/08-tmstyles.R", print.eval = TRUE)

## A preview of predefined styles can be generated by executing `tmap_style_catalogue()`.

## ----urban-facet, fig.cap="Faceted map showing the top 30 largest 'urban agglomerations' from 1970 to 2030 based on population projects by the United Nations.", fig.asp=0.4----
urb_1970_2030 = urban_agglomerations %>% 
  filter(year %in% c(1970, 1990, 2010, 2030))
tm_shape(world) + tm_polygons() + 
  tm_shape(urb_1970_2030) + tm_symbols(col = "black", border.col = "white",
                                       size = "population_millions") +
  tm_facets(by = "year", nrow = 2, free.coords = FALSE)

## ------------------------------------------------------------------------
nz_region = st_bbox(c(xmin = 1340000, xmax = 1450000,
                      ymin = 5130000, ymax = 5210000)) %>% 
  st_as_sfc() %>% 
  st_set_crs(st_crs(nz_height))

## ------------------------------------------------------------------------
nz_height_map = tm_shape(nz_elev, bbox = tmaptools::bb(nz_region)) +
  tm_raster(style = "cont", palette = "YlGn", legend.show = TRUE) +
  tm_shape(nz_height) + tm_symbols(shape = 2, col = "red", size = 1) +
  tm_scale_bar(position = c("left", "bottom"))

## ------------------------------------------------------------------------
nz_map = tm_shape(nz) + tm_polygons() +
  tm_shape(nz_height) + tm_symbols(shape = 2, col = "red", size = 0.1) + 
  tm_shape(nz_region) + tm_borders(lwd = 3) 

## ----insetmap1, fig.cap="Inset map providing a context - location of the central part of the Southern Alps in New Zealand."----
library(grid)
nz_height_map
print(nz_map, vp = viewport(0.8, 0.27, width = 0.5, height = 0.5))

## ------------------------------------------------------------------------
us_states_map = tm_shape(us_states, projection = 2163) + tm_polygons() + 
  tm_layout(frame = FALSE)

## ------------------------------------------------------------------------
hawaii_map = tm_shape(hawaii) + tm_polygons() + 
  tm_layout(title = "Hawaii", frame = FALSE, bg.color = NA, 
            title.position = c("left", "bottom"))
alaska_map = tm_shape(alaska) + tm_polygons() + 
  tm_layout(title = "Alaska", frame = FALSE, bg.color = NA)

## ----insetmap2, fig.cap="Map of the United States."----------------------
us_states_map
print(hawaii_map, vp = viewport(x = 0.4, y = 0.1, width = 0.2, height = 0.1))
print(alaska_map, vp = viewport(x = 0.15, y = 0.15, width = 0.3, height = 0.3))

## ----urban-animated, fig.cap="Animated map showing the top 30 largest 'urban agglomerations' from 1950 to 2030 based on population projects by the United Nations.", echo=FALSE----
knitr::include_graphics("figures/urban-animated.gif")

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## source("code/08-urban-animation.R")

## ------------------------------------------------------------------------
urb_anim = tm_shape(world) + tm_polygons() + 
  tm_shape(urban_agglomerations) + tm_dots(size = "population_millions") +
  tm_facets(by = "year", free.coords = FALSE, nrow = 1, ncol = 1)

## ---- eval=FALSE---------------------------------------------------------
## tmap_animation(urb_anim, filename = "urb_anim.gif", delay = 25)

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## source("code/08-usboundaries.R")
## source("code/08-uscolonize.R")

## ----animus, echo=FALSE, fig.cap="Animated map showing population growth and state formation and boundary changes in the United States, 1790-2010."----
u_animus = "https://user-images.githubusercontent.com/1825120/38543030-5794b6f0-3c9b-11e8-9da9-10ec1f3ea726.gif"
knitr::include_graphics(u_animus)

## ---- eval=FALSE---------------------------------------------------------
## tmap_mode("view")
## map_nz

## ----tmview, fig.cap="Interactive map of New Zealand created with tmap in view mode.", echo=FALSE----
tmap_mode("view")
m_tmview = map_nz
tmap_leaflet(m_tmview)

## ---- eval=FALSE---------------------------------------------------------
## basemap = leaflet::providers$OpenTopoMap
## map_nz +
##   tm_view(basemaps = basemap)

## ---- eval=FALSE---------------------------------------------------------
## world_coffee = left_join(world, coffee_data, by = "name_long")
## facets = c("coffee_production_2016", "coffee_production_2017")
## tm_shape(world_coffee) + tm_polygons(facets) +
##   tm_facets(nrow = 1, sync = TRUE)

## ----sync, fig.cap="Faceted interactive maps of global coffee producing in 2016 and 2017 in 'sync', demonstrating tmap's view mode in action.", echo=FALSE----
knitr::include_graphics("https://user-images.githubusercontent.com/1825120/39561412-4dbba7ba-4e9d-11e8-885c-7973b351006b.png")

## ------------------------------------------------------------------------
tmap_mode("plot")

## ---- eval=FALSE---------------------------------------------------------
## mapview::mapview(nz)

## ----mapview, fig.cap="Illustration of mapview in action.", echo=FALSE----
knitr::include_graphics("https://user-images.githubusercontent.com/1825120/39979522-e8277398-573e-11e8-8c55-d72c6bcc58a4.png")
# mv = mapview::mapview(nz)
# mv@map

## ---- eval=FALSE---------------------------------------------------------
## trails %>%
##   st_transform(st_crs(franconia)) %>%
##   st_intersection(franconia[franconia$district == "Oberfranken", ]) %>%
##   st_collection_extract("LINE") %>%
##   mapview(color = "red", lwd = 3, layer.name = "trails") +
##   mapview(franconia, zcol = "district", burst = TRUE) +
##   breweries

## ---- mapview2, fig.cap="Using mapview at the end of a sf based pipe expression.", echo=FALSE, warning=FALSE----
knitr::include_graphics("https://user-images.githubusercontent.com/1825120/39979271-5f515256-573d-11e8-9ede-e472ca007d73.png")
# commented out because interactive version not working
# mv2 = trails %>%
#   st_transform(st_crs(franconia)) %>%
#   st_intersection(franconia[franconia$district == "Oberfranken", ]) %>%
#   st_collection_extract("LINE") %>%
#   mapview(color = "red", lwd = 3, layer.name = "trails") +
#   mapview(franconia, zcol = "district", burst = TRUE) +
#   breweries
# mv2@map

## ----leaflet, fig.cap="The leaflet package in action, showing cycle hire points in London."----
pal = colorNumeric("RdYlBu", domain = cycle_hire$nbikes)
leaflet(data = cycle_hire) %>% 
  addProviderTiles(providers$Stamen.TonerLite) %>% 
  addCircles(col = ~pal(nbikes), opacity = 0.9) %>% 
  addPolygons(data = lnd, fill = FALSE) %>% 
  addLegend(pal = pal, values = ~nbikes) %>% 
  setView(lng = -0.1, 51.5, zoom = 12) %>% 
  addMiniMap()

## In **shiny** apps these are often split into `ui.R` (short for user interface) and `server.R` files, naming conventions used by [`shiny-server`](https://github.com/rstudio/shiny-server), a server-side Linux application for serving shiny apps on public-facing websites.

## ---- eval=FALSE---------------------------------------------------------
## library(shiny)    # for shiny apps
## library(leaflet)  # renderLeaflet function
## library(spData)   # loads the world dataset
## ui = fluidPage(
##   sliderInput(inputId = "life", "Life expectancy", 49, 84, value = 80),
##       leafletOutput(outputId = "map")
##   )
## server = function(input, output) {
##   output$map = renderLeaflet({
##     leaflet() %>% addProviderTiles("OpenStreetMap.BlackAndWhite") %>%
##       addPolygons(data = world[world$lifeExp < input$life, ])})
## }
## shinyApp(ui, server)

## ----lifeApp, echo=FALSE, fig.cap="Screenshot showing minimal example of a web mapping application created with **shiny**."----
# knitr::include_app("http://35.233.37.196/shiny/")
knitr::include_graphics("https://user-images.githubusercontent.com/1825120/39690606-8f9400c8-51d2-11e8-84d7-f4a66a477d2a.png")

## There are a number of ways to run a **shiny** app.

## ----coffeeApp, echo=FALSE, fig.cap="coffeeApp, a simple web mapping application for exploring global coffee production in 2016 and 2017."----
knitr::include_app("https://bookdown.org/robinlovelace/coffeeapp/")

## ----nz-plot, fig.cap="Map of New Zealand created with plot(). The legend to the right refers to elevation (1000 m above sea level)."----
g = st_graticule(nz, lon = c(170, 175), lat = c(-45, -40, -35))
plot(nz_water, graticule = g, axes = TRUE, col = "blue")
raster::plot(nz_elev / 1000, add = TRUE)
plot(st_geometry(nz), add = TRUE)

## ----nz-gg, fig.cap="Map of New Zealand created with ggplot2."-----------
library(ggplot2)
g1 = ggplot() + geom_sf(data = nz, aes(fill = Median_income)) +
  geom_sf(data = nz_height) +
  scale_x_continuous(breaks = c(170, 175))
g1

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## plotly::ggplotly(g1)

## ----map-gpkg, echo=FALSE, message=FALSE---------------------------------
gpkg_df = read_csv("extdata/generic_map_pkgs.csv")
map_gpkg_df = dplyr::select(gpkg_df, package, title)
map_gpkg_df$title[map_gpkg_df$package == "leaflet"] =
  "Create Interactive Web Maps with Leaflet"
knitr::kable(map_gpkg_df, caption = "Selected general-purpose mapping packages, with associated metrics.")

## ----map-spkg, echo=FALSE, message=FALSE---------------------------------
spkg_df = read_csv("extdata/specific_map_pkgs.csv")
map_spkg_df = dplyr::select(spkg_df, package, title)
knitr::kable(map_spkg_df, caption = "Selected specific-purpose mapping packages, with associated metrics.")

## ---- fig.show='hide', message=FALSE-------------------------------------
library(cartogram)
nz_carto = cartogram_cont(nz, "Median_income", itermax = 5)
tm_shape(nz_carto) + tm_polygons("Median_income")

## ----cartomap1, echo=FALSE, fig.cap="Comparison of standard map (left) and continuous area cartogram (right)."----
carto_map1 = tm_shape(nz) + 
  tm_polygons("Median_income", title = "Median income (NZD)", palette = "Greens") +
  tm_layout(title = "Standard map")
carto_map2 = tm_shape(nz_carto) + 
  tm_polygons("Median_income", title = "Median income (NZD)", palette = "Greens") +
  tm_layout(title = "Continuous area cartogram")
tmap_arrange(carto_map1, carto_map2)

## ---- fig.show='hide', message=FALSE-------------------------------------
us_states2163 = st_transform(us_states, 2163)
us_states2163_ncont = cartogram_ncont(us_states2163, "total_pop_15")
us_states2163_dorling = cartogram_dorling(us_states2163, "total_pop_15")

## ----cartomap2, echo=FALSE, fig.cap="Comparison of non-continuous area cartogram (top) and Dorling cartogram (bottom)."----
carto_map3 = tm_shape(us_states2163_ncont) + 
  tm_polygons("total_pop_15", title = "Total population", palette = "BuPu") +
  tm_layout(title = "Non-continuous area cartogram", inner.margins = c(0.02, 0.02, 0.1, 0.02))
carto_map4 = tm_shape(us_states2163_dorling) + 
  tm_polygons("total_pop_15", title = "Total population", palette = "BuPu") +
  tm_layout(title = "Dorling cartogram", inner.margins = c(0.02, 0.02, 0.1, 0.02))
tmap_arrange(carto_map3, carto_map4, ncol = 1)

## ------------------------------------------------------------------------
africa = world %>% 
  filter(continent == "Africa", !is.na(iso_a2)) %>% 
  left_join(worldbank_df, by = "iso_a2") %>% 
  dplyr::select(name, subregion, gdpPercap, HDI, pop_growth) %>% 
  st_transform("+proj=aea +lat_1=20 +lat_2=-23 +lat_0=0 +lon_0=25")

## ---- results='hide'-----------------------------------------------------
zion = st_read((system.file("vector/zion.gpkg", package = "spDataLarge")))

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # >0.8 - Very high human development
## # >0.7 - High human development
## # >0.55 - Medium human development
## # <0.55 - Low human development
## sm1 = tm_shape(africa) +
##   tm_polygons(
##   col = "HDI",
##   title = "Human Development Index",
##   breaks = c(0, 0.55, 0.7, 0.8),
##   labels = c("Low", "Medium", "High"),
##   palette = "YlGn"
##   )

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## sm2 = tm_shape(africa) +
##   tm_polygons(col = "subregion",
##               title = "Subregion",
##               palette = "Set2")
## tmap_arrange(sm2, sm1)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## lc_colors = c("#476ba0", "#aa0000", "#b2ada3", "#68aa63", "#a58c30",
##               "#c9c977", "#dbd83d", "#bad8ea")
## sm3 = tm_shape(nlcd) + tm_raster(palette = lc_colors, title = "Land cover") +
##   tm_shape(zion) + tm_borders(lwd = 3) +
##   tm_scale_bar(size = 1, position = "left") +
##   tm_compass(type = "8star", position = c("RIGHT", "top")) +
##   tm_layout(legend.frame = TRUE, legend.position = c(0.6, "top"))
## sm3
## utah = filter(us_states, NAME == "Utah")
## zion_bbox = st_as_sfc(st_bbox(nlcd))
## sm3_plus = sm3 +
##   tm_layout(frame.lwd = 4)
## 
## im = tm_shape(utah) +
##   tm_polygons(lwd = 3, border.col = "black") +
##   tm_shape(zion_bbox) +
##   tm_polygons(col = "green", lwd = 1) +
##   tm_layout(title = "UTAH", title.size = 2, title.position = c("center", "center")) +
##   tm_layout(frame = FALSE, bg.color = NA)
## 
## library(grid)
## print(sm3_plus, vp = grid::viewport(0.5, 0.5, width = 0.95, height = 0.95))
## print(im, vp = grid::viewport(0.2, 0.4, width = 0.35, height = 0.35))

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## eastern_africa = filter(africa, subregion == "Eastern Africa")
## tm_shape(eastern_africa) +
##   tm_polygons(col = c("HDI", "pop_growth")) +
##   qtm(africa, fill = NULL)
## # https://github.com/mtennekes/tmap/issues/190#issuecomment-384184801
## tm_shape(eastern_africa) +
##   tm_polygons("pop_growth", style = "jenks", palette = "BuPu") +
##   tm_facets(by = "name", showNA = FALSE)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## m = tm_shape(eastern_africa) +
##   tm_polygons(col = c("HDI", "pop_growth")) +
##   qtm(africa, fill = NULL) +
##   tm_facets(ncol = 1, nrow = 1)
## tmap_animation(m, filename = "m.gif")
## browseURL("m.gif")
## m = tm_shape(eastern_africa) +
##   tm_polygons("pop_growth", style = "jenks", palette = "BuPu") +
##   tm_facets(by = "name", showNA = FALSE, ncol = 1, nrow = 1)
## tmap_animation(m, filename = "m.gif")
## browseURL("m.gif")

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # fig 9.1 (\@ref(fig:tmshape))
## ggplot() +
##   geom_sf(data = nz, color = NA) +
##   coord_sf(crs = st_crs(nz), datum = NA) +
##   theme_void()
## ggplot() +
##   geom_sf(data = nz, fill = NA) +
##   coord_sf(crs = st_crs(nz), datum = NA) +
##   theme_void()
## ggplot() +
##   geom_sf(data = nz) +
##   coord_sf(crs = st_crs(nz), datum = NA) +
##   theme_void()
## # fig 9.7 ( \@ref(fig:break-styles))
## ggplot() +
##   geom_sf(data = nz, aes(fill = Median_income)) +
##   coord_sf(crs = st_crs(nz), datum = NA) +
##   scale_fill_distiller(palette = "Oranges", direction = 1) +
##   theme_void()
## ggplot() +
##   geom_sf(data = nz, aes(fill = Island)) +
##   coord_sf(crs = st_crs(nz), datum = NA) +
##   scale_fill_brewer(palette = "Set3") +
##   theme_void()
## # fig 9.13 (\@ref(fig:urban-facet))
## # ggplot() + geom_sf(data = world) + geom_sf(data = urb_1970_2030, aes(size = population_millions)) + coord_sf(crs = st_crs(urb_1970_2030), datum = NA) + facet_wrap(~year, nrow = 2) + theme(panel.background = element_rect(fill = "white"))

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## library(cartogram)
## # prepare the data
## us = st_transform(us_states, 2163)
## us = us %>%
##   left_join(us_states_df, by = c("NAME" = "state"))
## # calculate a poverty rate
## us$poverty_rate = us$poverty_level_15 / us$total_pop_15
## # create a regular map
## ecm1 = tm_shape(us) + tm_polygons("poverty_rate", title = "Poverty rate")
## # create a cartogram
## us_carto = cartogram(us, "total_pop_15")
## ecm2 = tm_shape(us_carto) + tm_polygons("poverty_rate", title = "Poverty rate")
## # combine two maps
## tmap_arrange(ecm1, ecm2)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # devtools::install_github("jbaileyh/geogrid")
## library(geogrid)
## 
## hex_cells = calculate_grid(africa, grid_type = "hexagonal", seed = 25, learning_rate = 0.03)
## africa_hex = st_as_sf(assign_polygons(africa, hex_cells))
## 
## reg_cells = calculate_grid(africa, grid_type = "regular", seed = 25, learning_rate = 0.03)
## africa_reg = st_as_sf(assign_polygons(africa, reg_cells))
## 
## tgg1 = tm_shape(africa) + tm_polygons("pop_growth", title = "Population's growth (annual %)")
## tgg2 = tm_shape(africa_hex) + tm_polygons("pop_growth", title = "Population's growth (annual %)")
## tgg3 = tm_shape(africa_reg) + tm_polygons("pop_growth", title = "Population's growth (annual %)")
## 
## tmap_arrange(tgg1, tgg2, tgg3)

