library(methods)
library(knitr)
opts_chunk$set(
        background = "#FCFCFC", # code chunk color in latex
        comment = "#>",
        collapse = TRUE,
        # Uncomment for faster but potentially less reliable builds:
        # cache = TRUE,
        fig.pos = "t",
        fig.path = "figures/",
        fig.align = "center",
        fig.width = 6,
        fig.asp = 0.618,  # 1 / phi
        fig.show = "hold",
        out.width = "100%",
        dpi = 105 # this creates 2*105 dpi at 6in, which is 300 dpi at 4.2in, see the  EmilHvitfeldt/smltar repo
)
# https://github.com/EmilHvitfeldt/smltar/issues/114
hook_output = knit_hooks$get('output')
knit_hooks$set(output = function(x, options) {
        # this hook is used only when the linewidth option is not NULL
        if (!is.null(n <- options$linewidth)) {
                x = knitr:::split_lines(x)
                # any lines wider than n should be wrapped
                if (any(nchar(x) > n)) x = strwrap(x, width = n)
                x = paste(x, collapse = '\n')
        }
        hook_output(x, options)
},
               crop = knitr::hook_pdfcrop)

set.seed(2017)
options(digits = 3)
options(dplyr.print_min = 4, dplyr.print_max = 4)
options("rgdal_show_exportToProj4_warnings"="none") #hides proj4 warnings