## ----gdsl, echo=FALSE, message=FALSE-------------------------------------
d = readr::read_csv("extdata/gis-vs-gds-table.csv")
knitr::kable(x = d, 
             caption = paste("Differences in emphasis between software", 
                             "packages (Graphical User Interface (GUI) of", 
                             "Geographic Information Systems (GIS) and R)."),
             caption.short = "Differences between GUI and CLI",
             booktabs = TRUE)

## Reproducibility is a major advantage of command-line interfaces, but what does it mean in practice?

## ----01-introduction-2, eval=FALSE, echo=FALSE---------------------------
#> a = osmdata::getbb("Hereford")
#> b = osmdata::getbb("Bialystok")
#> rowMeans(a)
#> rowMeans(b)

## ----interactive, fig.cap="The blue markers indicate where the authors are from. The basemap is a tiled image of the Earth at night provided by NASA. Interact with the online version at geocompr.robinlovelace.net, for example by zooming in and clicking on the popups.", out.width="100%", fig.scap="Where the authors are from."----
library(leaflet)
popup = c("Robin", "Jakub", "Jannes")
leaflet() %>%
  addProviderTiles("NASAGIBS.ViirsEarthAtNight2012") %>%
  addMarkers(lng = c(-3, 23, 11),
             lat = c(52, 53, 49), 
             popup = popup)

## ----cranlogs, fig.cap="The popularity of spatial packages in R. The y-axis shows average number of downloads per day, within a 30-day rolling window, of prominent spatial packages.", echo=FALSE, fig.scap="The popularity of spatial packages in R."----
knitr::include_graphics("figures/spatial-package-growth.png")

## ----revdep, echo=FALSE, message=FALSE-----------------------------------
top_dls = readr::read_csv("extdata/top_dls.csv")
knitr::kable(top_dls[1:5, 1:2], digits = 0, 
             caption = paste("The top 5 most downloaded packages that depend", 
                             "on sf, in terms of average number of downloads", 
                             "per day over the previous month. As of",
                             min(top_dls$date), ", there are ", nrow(top_dls), 
                             " packages which import sf."), 
             caption.short = "Top 5 most downloaded packages depending on sf.",
             booktabs = TRUE)
# cranlogs::cran_top_downloads(when = "last-month") # most downloaded pkgs

