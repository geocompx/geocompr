## ----sf-ogc, fig.cap="The Simple Features class hierarchy, used with permission (on condition of linking to the source) from the Open Geospatial Consortium's document 06-103r4 (see http://www.opengeospatial.org/standards/sfa)", out.width="100%", echo=FALSE----
knitr::include_graphics("figures/simple-feature-class-hierarchy.png")

## ---- eval=FALSE---------------------------------------------------------
## vignette("sf1") # for an introduction to the package
## vignette("sf2") # for reading, writing and converting Simple Features
## vignette("sf3") # for manipulating simple features

## ---- results='hide'-----------------------------------------------------
library(sf)
# devtools::install_github("nowosad/spData")
f = system.file("shapes/ne_110m_admin_0_countries.shp", package = "spData")
w = st_read(f)

## ------------------------------------------------------------------------
class(w)

## ------------------------------------------------------------------------
w[1:2, 1:3]

## ------------------------------------------------------------------------
w_sp = as(object = w, Class = "Spatial")

