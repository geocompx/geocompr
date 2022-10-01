## ----15-synthesis-1---------------------------------------------------------------------------------------------------------------------------------------
library(spData)
nz_u1 = sf::st_union(nz)
nz_u2 = aggregate(nz["Population"], list(rep(1, nrow(nz))), sum)
nz_u3 = dplyr::summarise(nz, t = sum(Population))
identical(nz_u1, nz_u2$geometry)
identical(nz_u1, nz_u3$geom)


## ----15-synthesis-2, message=FALSE------------------------------------------------------------------------------------------------------------------------
library(dplyr)                          # attach tidyverse package
nz_name1 = nz["Name"]                   # base R approach
nz_name2 = nz |> select(Name)          # tidyverse approach
identical(nz_name1$Name, nz_name2$Name) # check results


## ----15-synthesis-3, eval=FALSE, echo=FALSE---------------------------------------------------------------------------------------------------------------
## # aim: find number of packages in the spatial task view
## # how? see:
## # vignette("selectorgadget")
## stv_pkgs = xml2::read_html("https://cran.r-project.org/web/views/Spatial.html")
## pkgs = rvest::html_nodes(stv_pkgs, "ul:nth-child(5) a")
## pkgs_char = rvest::html_text(pkgs)
## length(pkgs_char)


## ----15-synthesis-4, echo=FALSE, eval=FALSE---------------------------------------------------------------------------------------------------------------
## revdeps_sp = devtools::revdep(pkg = "sp", dependencies = c("Depends", "Imports"))
## revdeps_sf = devtools::revdep(pkg = "sf", dependencies = c("Depends", "Imports"))
## revdeps_spatstat = devtools::revdep(pkg = "spatstat", dependencies = c("Depends", "Imports"))

