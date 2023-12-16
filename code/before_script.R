library(methods)
library(knitr)
opts_chunk$set(
        background = "#FCFCFC", # code chunk color in latex
        comment = "#>",
        collapse = TRUE,
        # The following line speeds-up the build.
        # Uncomment it to avoid cached data (which can cause issues):
        cache = TRUE,
        fig.pos = "t",
        fig.path = "figures/",
        fig.align = "center",
        fig.width = 6,
        fig.asp = 0.618,  # 1 / phi
        fig.show = "hold",
        out.width = "100%",
        dpi = 105 # this creates 2*105 dpi at 6in, which is 300 dpi at 4.2in, see the  EmilHvitfeldt/smltar repo
)

set.seed(2017)
options(digits = 3)
options(dplyr.print_min = 4, dplyr.print_max = 4)

# https://github.com/rstudio/rmarkdown-cookbook/commit/876bca3facedd30b8cc48cd9c1c86020d1e2adf9
# save the build-in output hook
hook_output = knitr::knit_hooks$get("output")
# set a new output hook to truncate text output
knitr::knit_hooks$set(output = function(x, options) {
        if (!is.null(n <- options$out.lines)) {
                x = knitr:::split_lines(x)
                if (length(x) > n) {
                        # truncate the output
                        x = c(head(x, n), '....\n')
                }              
                        x = paste(x, collapse = '\n')
        }
        # https://github.com/EmilHvitfeldt/smltar/issues/114
        # this hook is used only when the linewidth option is not NULL
        if (!is.null(n <- options$linewidth)) {
                x = knitr:::split_lines(x)
                # any lines wider than n should be wrapped
                if (any(nchar(x) > n)) x = strwrap(x, width = n)
                x = paste(x, collapse = '\n')
        }
  hook_output(x, options)
}, crop = knitr::hook_pdfcrop)

