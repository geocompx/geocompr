library(methods)

knitr::opts_chunk$set(
        background = "#FCFCFC", # code chunk color in latex
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
options("rgdal_show_exportToProj4_warnings"="none") #hides proj4 warnings
