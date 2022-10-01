## ----08-mapping-1, message=FALSE--------------------------------------------------------------------------------------------------------------------------
library(sf)
library(raster)
library(dplyr)
library(spData)
library(spDataLarge)


## ----08-mapping-2, message=FALSE--------------------------------------------------------------------------------------------------------------------------
library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(ggplot2) # tidyverse data visualization package


## ----08-mapping-3, eval=FALSE-----------------------------------------------------------------------------------------------------------------------------
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


## ----tmshape, echo=FALSE, message=FALSE, fig.cap="New Zealand's shape plotted with fill (left), border (middle) and fill and border (right) layers added using tmap functions.", fig.scap="New Zealand's shape plotted using tmap functions."----
source("https://github.com/Robinlovelace/geocompr/raw/main/code/09-tmshape.R", print.eval = TRUE)


## `qtm()` is a handy function to create **q**uick **t**hematic **m**aps (hence the snappy name).

## It is concise and provides a good default visualization in many cases:

## `qtm(nz)`, for example, is equivalent to `tm_shape(nz) + tm_fill() + tm_borders()`.

## Further, layers can be added concisely using multiple `qtm()` calls, such as `qtm(nz) + qtm(nz_height)`.

## The disadvantage is that it makes aesthetics of individual layers harder to control, explaining why we avoid teaching it in this chapter.


## ----08-mapping-4-----------------------------------------------------------------------------------------------------------------------------------------
map_nz = tm_shape(nz) + tm_polygons()
class(map_nz)


## ----08-mapping-5, results='hide'-------------------------------------------------------------------------------------------------------------------------
map_nz1 = map_nz +
  tm_shape(nz_elev) + tm_raster(alpha = 0.7)


## ----08-mapping-6-----------------------------------------------------------------------------------------------------------------------------------------
nz_water = st_union(nz) |> st_buffer(22200) |> 
  st_cast(to = "LINESTRING")
map_nz2 = map_nz1 +
  tm_shape(nz_water) + tm_lines()


## ----08-mapping-7-----------------------------------------------------------------------------------------------------------------------------------------
map_nz3 = map_nz2 +
  tm_shape(nz_height) + tm_dots()


## ----tmlayers, message=FALSE, fig.cap="Maps with additional layers added to the final map of Figure 9.1.", fig.scap="Additional layers added to the output of Figure 9.1."----
tmap_arrange(map_nz1, map_nz2, map_nz3)


## ----tmstatic, message=FALSE, fig.cap="The impact of changing commonly used fill and border aesthetics to fixed values.", fig.scap="The impact of changing commonly used aesthetics."----
ma1 = tm_shape(nz) + tm_fill(col = "red")
ma2 = tm_shape(nz) + tm_fill(col = "red", alpha = 0.3)
ma3 = tm_shape(nz) + tm_borders(col = "blue")
ma4 = tm_shape(nz) + tm_borders(lwd = 3)
ma5 = tm_shape(nz) + tm_borders(lty = 2)
ma6 = tm_shape(nz) + tm_fill(col = "red", alpha = 0.3) +
  tm_borders(col = "blue", lwd = 3, lty = 2)
tmap_arrange(ma1, ma2, ma3, ma4, ma5, ma6)


## ----08-mapping-8, echo=FALSE, eval=FALSE-----------------------------------------------------------------------------------------------------------------
## # aim: show what happpens when names clash
## library(tmap)
## library(spData)
## nz$red = 1:nrow(nz)
## qtm(nz, "red")


## ----08-mapping-9, eval=FALSE-----------------------------------------------------------------------------------------------------------------------------
## plot(st_geometry(nz), col = nz$Land_area)  # works
## tm_shape(nz) + tm_fill(col = nz$Land_area) # fails
## #> Error: Fill argument neither colors nor valid variable name(s)


## ----08-mapping-10, fig.show='hide', message=FALSE--------------------------------------------------------------------------------------------------------
tm_shape(nz) + tm_fill(col = "Land_area")


## ----tmcol, message=FALSE, fig.cap="Comparison of base (left) and tmap (right) handling of a numeric color field.", fig.scap="Comparison of base graphics and tmap", echo=FALSE, out.width="45%", fig.show='hold', warning=FALSE, message=FALSE----
plot(nz["Land_area"])
tm_shape(nz) + tm_fill(col = "Land_area")


## ----08-mapping-11----------------------------------------------------------------------------------------------------------------------------------------
legend_title = expression("Area (km"^2*")")
map_nza = tm_shape(nz) +
  tm_fill(col = "Land_area", title = legend_title) + tm_borders()


## ----08-mapping-12, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## tm_shape(nz) + tm_polygons(col = "Median_income")
## breaks = c(0, 3, 4, 5) * 10000
## tm_shape(nz) + tm_polygons(col = "Median_income", breaks = breaks)
## tm_shape(nz) + tm_polygons(col = "Median_income", n = 10)
## tm_shape(nz) + tm_polygons(col = "Median_income", palette = "BuGn")


## ----tmpal, message=FALSE, fig.cap="Illustration of settings that affect color settings. The results show (from left to right): default settings, manual breaks, n breaks, and the impact of changing the palette.", fig.scap="Illustration of settings that affect color settings.", echo=FALSE, fig.asp=0.56----
source("https://github.com/Robinlovelace/geocompr/raw/main/code/09-tmpal.R", print.eval = TRUE)


## ----break-styles, message=FALSE, fig.cap="Illustration of different binning methods set using the style argument in tmap.", , fig.scap="Illustration of different binning methods using tmap.", echo=FALSE----
source("https://github.com/Robinlovelace/geocompr/raw/main/code/09-break-styles.R", print.eval = TRUE)


## Although `style` is an argument of **tmap** functions, in fact it originates as an argument in `classInt::classIntervals()` --- see the help page of this function for details.


## ----08-mapping-13, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## tm_shape(nz) + tm_polygons("Population", palette = "Blues")
## tm_shape(nz) + tm_polygons("Population", palette = "YlOrBr")


## ----colpal, echo=FALSE, message=FALSE, fig.cap="Examples of categorical, sequential and diverging palettes.", out.width="50%"----------------------------
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
  tm_scale_bar(breaks = c(0, 100, 200), text.size = 1)


## ----08-mapping-14, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## map_nz + tm_layout(title = "New Zealand")
## map_nz + tm_layout(scale = 5)
## map_nz + tm_layout(bg.color = "lightblue")
## map_nz + tm_layout(frame = FALSE)


## ----layout1, message=FALSE, fig.cap="Layout options specified by (from left to right) title, scale, bg.color and frame arguments.", fig.scap="Layout options specified by the tmap arguments.", echo=FALSE, fig.asp=0.56----
source("https://github.com/Robinlovelace/geocompr/raw/main/code/09-layout1.R", print.eval = TRUE)


## ----layout2, message=FALSE, fig.cap="Illustration of selected layout options.", echo=FALSE, fig.asp=0.56-------------------------------------------------
# todo: add more useful settings to this plot
source("https://github.com/Robinlovelace/geocompr/raw/main/code/09-layout2.R", print.eval = TRUE)


## ----layout3, message=FALSE, fig.cap="Illustration of selected color-related layout options.", echo=FALSE, fig.asp=0.56-----------------------------------
source("https://github.com/Robinlovelace/geocompr/raw/main/code/09-layout3.R", print.eval = TRUE)


## ----08-mapping-15, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## map_nza + tm_style("bw")
## map_nza + tm_style("classic")
## map_nza + tm_style("cobalt")
## map_nza + tm_style("col_blind")


## ----tmstyles, message=FALSE, fig.cap="Selected tmap styles.", fig.scap="Selected tmap styles.", echo=FALSE, fig.asp=0.56---------------------------------
source("https://github.com/Robinlovelace/geocompr/raw/main/code/09-tmstyles.R", print.eval = TRUE)


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
  tm_symbols(col = "black", border.col = "white", size = "population_millions") +
  tm_facets(by = "year", nrow = 2, free.coords = FALSE)


## ----08-mapping-16----------------------------------------------------------------------------------------------------------------------------------------
nz_region = st_bbox(c(xmin = 1340000, xmax = 1450000,
                      ymin = 5130000, ymax = 5210000),
                    crs = st_crs(nz_height)) |> 
  st_as_sfc()


## ----08-mapping-17----------------------------------------------------------------------------------------------------------------------------------------
nz_height_map = tm_shape(nz_elev, bbox = nz_region) +
  tm_raster(style = "cont", palette = "YlGn", legend.show = TRUE) +
  tm_shape(nz_height) + tm_symbols(shape = 2, col = "red", size = 1) +
  tm_scale_bar(position = c("left", "bottom"))


## ----08-mapping-18----------------------------------------------------------------------------------------------------------------------------------------
nz_map = tm_shape(nz) + tm_polygons() +
  tm_shape(nz_height) + tm_symbols(shape = 2, col = "red", size = 0.1) + 
  tm_shape(nz_region) + tm_borders(lwd = 3) 


## ----insetmap1, message=FALSE, fig.cap="Inset map providing a context - location of the central part of the Southern Alps in New Zealand.", fig.scap="Inset map providing a context."----
library(grid)
nz_height_map
print(nz_map, vp = viewport(0.8, 0.27, width = 0.5, height = 0.5))


## ----08-mapping-19----------------------------------------------------------------------------------------------------------------------------------------
us_states_map = tm_shape(us_states, projection = 2163) + tm_polygons() + 
  tm_layout(frame = FALSE)


## ----08-mapping-20----------------------------------------------------------------------------------------------------------------------------------------
hawaii_map = tm_shape(hawaii) + tm_polygons() + 
  tm_layout(title = "Hawaii", frame = FALSE, bg.color = NA, 
            title.position = c("LEFT", "BOTTOM"))
alaska_map = tm_shape(alaska) + tm_polygons() + 
  tm_layout(title = "Alaska", frame = FALSE, bg.color = NA)


## ----insetmap2, message=FALSE, fig.cap="Map of the United States."----------------------------------------------------------------------------------------
us_states_map
print(hawaii_map, vp = grid::viewport(0.35, 0.1, width = 0.2, height = 0.1))
print(alaska_map, vp = grid::viewport(0.15, 0.15, width = 0.3, height = 0.3))


## ----urban-animated, message=FALSE, fig.cap="Animated map showing the top 30 largest urban agglomerations from 1950 to 2030 based on population projects by the United Nations. Animated version available online at: geocompr.robinlovelace.net.", fig.scap="Animated map showing the top 30 largest 'urban agglomerations'.", echo=FALSE----
if (knitr::is_latex_output()){
    knitr::include_graphics("figures/urban-animated.png")
} else if (knitr::is_html_output()){
    knitr::include_graphics("figures/urban-animated.gif")
}


## ----08-mapping-21, echo=FALSE, eval=FALSE----------------------------------------------------------------------------------------------------------------
## source("https://github.com/Robinlovelace/geocompr/raw/main/code/09-urban-animation.R")


## ----08-mapping-22----------------------------------------------------------------------------------------------------------------------------------------
urb_anim = tm_shape(world) + tm_polygons() + 
  tm_shape(urban_agglomerations) + tm_dots(size = "population_millions") +
  tm_facets(along = "year", free.coords = FALSE)


## ----08-mapping-23, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## tmap_animation(urb_anim, filename = "urb_anim.gif", delay = 25)


## ----08-mapping-24, echo=FALSE, eval=FALSE----------------------------------------------------------------------------------------------------------------
## source("https://github.com/Robinlovelace/geocompr/raw/main/code/09-usboundaries.R")


## ----animus, echo=FALSE, message=FALSE, fig.cap="Animated map showing population growth, state formation and boundary changes in the United States, 1790-2010. Animated version available online at geocompr.robinlovelace.net.", fig.scap="Animated map showing boundary changes in the United States."----
u_animus_html = "https://user-images.githubusercontent.com/1825120/38543030-5794b6f0-3c9b-11e8-9da9-10ec1f3ea726.gif"
u_animus_pdf = "figures/animus.png"
if (knitr::is_latex_output()){
    knitr::include_graphics(u_animus_pdf)  
} else if (knitr::is_html_output()){
    knitr::include_graphics(u_animus_html)  
}


## ----08-mapping-25, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## tmap_mode("view")
## map_nz


## ----tmview, message=FALSE, fig.cap="Interactive map of New Zealand created with tmap in view mode. Interactive version available online at: geocompr.robinlovelace.net.", fig.scap="Interactive map of New Zealand.", echo=FALSE----
if (knitr::is_latex_output()){
    knitr::include_graphics("figures/tmview-1.png")
} else if (knitr::is_html_output()){
    # tmap_mode("view")
    # m_tmview = map_nz
    # tmap_save(m_tmview, "tmview-1.html")
    # file.copy("tmview-1.html", "~/geocompr/geocompr.github.io/static/img/tmview-1.html")
    knitr::include_url("https://geocompr.github.io/img/tmview-1.html")
}



## ----08-mapping-26, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## map_nz + tm_basemap(server = "OpenTopoMap")


## ----08-mapping-27, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## world_coffee = left_join(world, coffee_data, by = "name_long")
## facets = c("coffee_production_2016", "coffee_production_2017")
## tm_shape(world_coffee) + tm_polygons(facets) +
##   tm_facets(nrow = 1, sync = TRUE)


## ----sync, message=FALSE, fig.cap="Faceted interactive maps of global coffee production in 2016 and 2017 in sync, demonstrating tmap's view mode in action.", fig.scap="Faceted interactive maps of global coffee production.", echo=FALSE----
knitr::include_graphics("figures/interactive-facets.png")


## ----08-mapping-28----------------------------------------------------------------------------------------------------------------------------------------
tmap_mode("plot")


## ----08-mapping-29, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## mapview::mapview(nz)


## ----mapview, message=FALSE, fig.cap="Illustration of mapview in action.", echo=FALSE---------------------------------------------------------------------
knitr::include_graphics("figures/mapview.png")
# knitr::include_graphics("https://user-images.githubusercontent.com/1825120/39979522-e8277398-573e-11e8-8c55-d72c6bcc58a4.png")
# mv = mapview::mapview(nz)
# mv@map


## ----08-mapping-30, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## trails |>
##   st_transform(st_crs(franconia)) |>
##   st_intersection(franconia[franconia$district == "Oberfranken", ]) |>
##   st_collection_extract("LINE") |>
##   mapview(color = "red", lwd = 3, layer.name = "trails") +
##   mapview(franconia, zcol = "district", burst = TRUE) +
##   breweries


## ----mapview2, message=FALSE, fig.cap="Using mapview at the end of a sf-based pipe expression.", echo=FALSE, warning=FALSE--------------------------------
knitr::include_graphics("figures/mapview-example.png")
# knitr::include_graphics("https://user-images.githubusercontent.com/1825120/39979271-5f515256-573d-11e8-9ede-e472ca007d73.png")
# commented out because interactive version not working
# mv2 = trails |>
#   st_transform(st_crs(franconia)) |>
#   st_intersection(franconia[franconia$district == "Oberfranken", ]) |>
#   st_collection_extract("LINE") |>
#   mapview(color = "red", lwd = 3, layer.name = "trails") +
#   mapview(franconia, zcol = "district", burst = TRUE) +
#   breweries
# mv2@map


## Note that the following block assumes the access token is stored in your R environment as `MAPBOX=your_unique_key`.

## This can be added with `edit_r_environ()` from the **usethis** package.


## https://raw.githubusercontent.com/uber-common/deck.gl-data/master/examples/3d-heatmap/heatmap-data.csv

## curl -i https://git.io -F "url=https://raw.githubusercontent.com/uber-common/deck.gl-data/master/examples/3d-heatmap/heatmap-data.csv" \

##     -F "code=geocompr-mapdeck"


## ----08-mapping-33, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## library(mapdeck)
## set_token(Sys.getenv("MAPBOX"))
## crash_data = read.csv("https://git.io/geocompr-mapdeck")
## crash_data = na.omit(crash_data)
## ms = mapdeck_style("dark")
## mapdeck(style = ms, pitch = 45, location = c(0, 52), zoom = 4) |>
##   add_grid(data = crash_data, lat = "lat", lon = "lng", cell_size = 1000,
##          elevation_scale = 50, layer_id = "grid_layer",
##          colour_range = viridisLite::plasma(6))


## ----mapdeck, echo=FALSE, fig.cap="Map generated by mapdeck, representing road traffic casualties across the UK. Height of 1 km cells represents number of crashes.", fig.scap="Map generated by mapdeck."----
knitr::include_graphics("figures/mapdeck-mini.png")


## ----08-mapping-35, eval=FALSE, echo=FALSE----------------------------------------------------------------------------------------------------------------
## library(mapdeck)
## set_token(Sys.getenv("MAPBOX"))
## df = read.csv("https://git.io/geocompr-mapdeck")
## ms = mapdeck_style('dark')
## mapdeck(style = ms, pitch = 45, location = c(0, 52), zoom = 4) |>
## # add_grid(data = df, lat = "lat", lon = "lng", cell_size = 1000,
## #          elevation_scale = 50, layer_id = "grid_layer",
## #          colour_range = viridisLite::plasma(5)) |>
##   add_polygon(data = lnd, layer_id = "polygon_layer")


## ----08-mapping-36, eval=FALSE, echo=FALSE----------------------------------------------------------------------------------------------------------------
## library(sf)
## str(roads)
## mapdeck(
##   , style = mapdeck_style('dark')
##   , location = c(145, -37.8)
##   , zoom = 10
##   ) |>
##   add_path(
##     data = roads
##     , stroke_colour = "RIGHT_LOC"
##     , layer_id = "path_layer"
##     , tooltip = "ROAD_NAME"
##     , auto_highlight = TRUE
##   )


## ----leaflet-code, echo=TRUE, eval=FALSE------------------------------------------------------------------------------------------------------------------
## pal = colorNumeric("RdYlBu", domain = cycle_hire$nbikes)
## leaflet(data = cycle_hire) |>
##   addProviderTiles(providers$CartoDB.Positron) |>
##   addCircles(col = ~pal(nbikes), opacity = 0.9) |>
##   addPolygons(data = lnd, fill = FALSE) |>
##   addLegend(pal = pal, values = ~nbikes) |>
##   setView(lng = -0.1, 51.5, zoom = 12) |>
##   addMiniMap()


## ----leaflet, message=FALSE, fig.cap="The leaflet package in action, showing cycle hire points in London. See interactive version [online](https://geocompr.github.io/img/leaflet.html).", fig.scap="The leaflet package in action.", echo=FALSE----
if (knitr::is_latex_output() | knitr::is_html_output()){
  knitr::include_graphics("figures/leaflet-1.png")
} else {
  # pre-generated for https://github.com/ropensci/stplanr/issues/385
  # pal = colorNumeric("RdYlBu", domain = cycle_hire$nbikes)
  # m = leaflet(data = cycle_hire) |>
  #   addProviderTiles(providers$CartoDB.Positron) |>
  #   addCircles(col = ~pal(nbikes), opacity = 0.9) |>
  #   addPolygons(data = lnd, fill = FALSE) |>
  #   addLegend(pal = pal, values = ~nbikes) |>
  #   setView(lng = -0.1, 51.5, zoom = 12) |>
  #   addMiniMap()
  # htmlwidgets::saveWidget(m, "leaflet.html")
  # browseURL("leaflet.html")
  # file.rename("leaflet.html", "~/geocompr/geocompr.github.io/static/img/leaflet.html")
  # abort old way of including - mixed content issues
  knitr::include_url("https://geocompr.github.io/img/leaflet.html")
}


## In **shiny** apps these are often split into `ui.R` (short for user interface) and `server.R` files, naming conventions used by `shiny-server`, a server-side Linux application for serving shiny apps on public-facing websites.

## `shiny-server` also serves apps defined by a single `app.R` file in an 'app folder'.

## Learn more at: https://github.com/rstudio/shiny-server.


## ----08-mapping-37, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## library(shiny)    # for shiny apps
## library(leaflet)  # renderLeaflet function
## library(spData)   # loads the world dataset
## ui = fluidPage(
##   sliderInput(inputId = "life", "Life expectancy", 49, 84, value = 80),
##       leafletOutput(outputId = "map")
##   )
## server = function(input, output) {
##   output$map = renderLeaflet({
##     leaflet() |>
##       # addProviderTiles("OpenStreetMap.BlackAndWhite") |>
##       addPolygons(data = world[world$lifeExp < input$life, ])})
## }
## shinyApp(ui, server)


## ----lifeApp, echo=FALSE, message=FALSE, fig.cap="Screenshot showing minimal example of a web mapping application created with shiny.", fig.scap="Minimal example of a web mapping application."----
# knitr::include_graphics("https://user-images.githubusercontent.com/1825120/39690606-8f9400c8-51d2-11e8-84d7-f4a66a477d2a.png")
knitr::include_graphics("figures/shiny-app.png")


## There are a number of ways to run a **shiny** app.

## For RStudio users, the simplest way is probably to click on the 'Run App' button located in the top right of the source pane when an `app.R`, `ui.R` or `server.R` script is open.

## **shiny** apps can also be initiated by using `runApp()` with the first argument being the folder containing the app code and data: `runApp("CycleHireApp")` in this case (which assumes a folder named `CycleHireApp` containing the `app.R` script is in your working directory).

## You can also launch apps from a Unix command line with the command `Rscript -e 'shiny::runApp("CycleHireApp")'`.


## ----CycleHireApp-html, echo=FALSE, message=FALSE, fig.cap="Hire a cycle App, a simple web mapping application for finding the closest cycle hiring station based on your location and requirement of cycles. Interactive version available online at geocompr.robinlovelace.net.",fig.scap="Cycle Hire App, a simple web mapping application.", eval=knitr::is_html_output(), out.width="600"----
## 
## knitr::include_app("https://shiny.robinlovelace.net/CycleHireApp/")


## ----CycleHireApp-latex, echo=FALSE, message=FALSE, fig.cap="Hire a cycle App, a simple web mapping application for finding the closest cycle hiring station based on your location and requirement of cycles. Interactive version available online at geocompr.robinlovelace.net.", fig.scap="coffeeApp, a simple web mapping application.", eval=knitr::is_latex_output()----
## knitr::include_graphics("figures/CycleHireApp-2.png")


## ----nz-plot, message=FALSE, fig.cap="Map of New Zealand created with plot(). The legend to the right refers to elevation (1000 m above sea level).", fig.scap="Map of New Zealand created with plot()."----
g = st_graticule(nz, lon = c(170, 175), lat = c(-45, -40, -35))
plot(nz_water, graticule = g, axes = TRUE, col = "blue")
raster::plot(nz_elev / 1000, add = TRUE)
plot(st_geometry(nz), add = TRUE)


## ----nz-gg, out.width="50%", message=FALSE, fig.cap="Map of New Zealand created with ggplot2."------------------------------------------------------------
library(ggplot2)
g1 = ggplot() + geom_sf(data = nz, aes(fill = Median_income)) +
  geom_sf(data = nz_height) +
  scale_x_continuous(breaks = c(170, 175))
g1


## ----08-mapping-38, eval=FALSE, echo=FALSE----------------------------------------------------------------------------------------------------------------
## plotly::ggplotly(g1)


## ----map-gpkg, echo=FALSE, message=FALSE, warning=FALSE---------------------------------------------------------------------------------------------------
gpkg_df = readr::read_csv("extdata/generic_map_pkgs.csv")
map_gpkg_df = dplyr::select(gpkg_df, Package = package, Title = title)
map_gpkg_df$Title[map_gpkg_df$Package == "leaflet"] =
  "Create Interactive Web Maps with Leaflet"
knitr::kable(map_gpkg_df, 
             caption = "Selected general-purpose mapping packages.", 
             caption.short = "Selected general-purpose mapping packages.", 
             booktabs = TRUE) |>
  kableExtra::column_spec(2, width = "9cm")


## ----map-spkg, echo=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------
spkg_df = readr::read_csv("extdata/specific_map_pkgs.csv")
map_spkg_df = dplyr::select(spkg_df, Package = package, Title = title)
knitr::kable(map_spkg_df, 
             caption = paste("Selected specific-purpose mapping packages,", 
                             "with associated metrics."),
             caption.short = "Selected specific-purpose mapping packages.",
             booktabs = TRUE)


## ----08-mapping-39, fig.show='hide', message=FALSE--------------------------------------------------------------------------------------------------------
library(cartogram)
nz_carto = cartogram_cont(nz, "Median_income", itermax = 5)
tm_shape(nz_carto) + tm_polygons("Median_income")


## ----cartomap1, echo=FALSE, message=FALSE, fig.cap="Comparison of standard map (left) and continuous area cartogram (right).", fig.scap="Comparison of standard map and continuous area cartogram."----
carto_map1 = tm_shape(nz) + 
  tm_polygons("Median_income", title = "Median income (NZD)", palette = "Greens")
carto_map2 = tm_shape(nz_carto) + 
  tm_polygons("Median_income", title = "Median income (NZD)", palette = "Greens")
tmap_arrange(carto_map1, carto_map2)


## ----08-mapping-40, fig.show='hide', message=FALSE--------------------------------------------------------------------------------------------------------
us_states2163 = st_transform(us_states, 2163)
us_states2163_ncont = cartogram_ncont(us_states2163, "total_pop_15")
us_states2163_dorling = cartogram_dorling(us_states2163, "total_pop_15")


## ----cartomap2, echo=FALSE, message=FALSE, fig.cap="Comparison of non-continuous area cartogram (left) and Dorling cartogram (right).", fig.scap="Comparison of cartograms.", fig.asp=0.32----
carto_map3 = tm_shape(us_states2163_ncont) + 
  tm_polygons("total_pop_15", title = "Total population", palette = "BuPu") +
  tm_layout(legend.show = FALSE)
carto_map4 = tm_shape(us_states2163_dorling) + 
  tm_polygons("total_pop_15", title = "Total population", palette = "BuPu") +
  tm_layout(legend.show = FALSE)
carto_map_34legend = tm_shape(us_states2163_dorling) + 
  tm_polygons("total_pop_15", title = "Total population", palette = "BuPu") +
  tm_layout(legend.only = TRUE)
tmap_arrange(carto_map3, carto_map4, carto_map_34legend, ncol = 3)


## ----08-mapping-41, warning=FALSE-------------------------------------------------------------------------------------------------------------------------
africa = world |> 
  filter(continent == "Africa", !is.na(iso_a2)) |> 
  left_join(worldbank_df, by = "iso_a2") |> 
  dplyr::select(name, subregion, gdpPercap, HDI, pop_growth) |> 
  st_transform("+proj=aea +lat_1=20 +lat_2=-23 +lat_0=0 +lon_0=25")


## ----08-mapping-42, results='hide'------------------------------------------------------------------------------------------------------------------------
zion = st_read((system.file("vector/zion.gpkg", package = "spDataLarge")))
data(nlcd, package = "spDataLarge")

