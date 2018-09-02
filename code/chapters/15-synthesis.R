## ----include=FALSE, cache=FALSE------------------------------------------
library(methods)

knitr::opts_chunk$set(
        comment = "#>",
        collapse = TRUE,
        cache = TRUE,
        fig.pos = "t",
        fig.path = "figures/",
        fig.align = 'center',
        fig.width = 6,
        fig.asp = 0.618,  # 1 / phi
        fig.show = "hold",
        out.width = "100%"
)

set.seed(2017)
options(digits = 3)
options(dplyr.print_min = 4, dplyr.print_max = 4)

## ------------------------------------------------------------------------
library(spData)
nz_u1 = sf::st_union(nz)
nz_u2 = aggregate(nz["Population"], list(rep(1, nrow(nz))), sum)
nz_u3 = dplyr::summarise(nz, t = sum(Population))
identical(nz_u1, nz_u2$geometry)
identical(nz_u1, nz_u3$geom)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # aim: find number of packages in the spatial task view
## # how? see:
## # vignette("selectorgadget")
## stv_pkgs = xml2::read_html("https://cran.r-project.org/web/views/Spatial.html")
## pkgs = rvest::html_nodes(stv_pkgs, "ul:nth-child(5) a")
## pkgs_char = rvest::html_text(pkgs)
## length(pkgs_char)

