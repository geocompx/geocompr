## ----c404, echo=FALSE, message=FALSE, fig.asp=1-----------------------------------------------------------------------------------------------------------
library(tmap)
library(sf)
null_island = st_point(c(0, 0))
null_island = st_sfc(null_island, crs = 4326)
null_island = st_sf(name = "Null Island", geom = null_island)
tm_shape(null_island) +
  tm_graticules(labels.col = "grey40") +
  tm_text("name", size = 5, fontface = "italic") +
  tm_layout(bg.color = "lightblue",
            main.title = "You are here:",
            main.title.color = "grey40")

