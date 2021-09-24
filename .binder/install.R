# set default repo
options(repos = c(CRAN = "https://cloud.r-project.org"))

# create local user library path (not present by default)
# see https://stackoverflow.com/a/43283085
dir.create(path = Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)

# update everything and install to local user library path
update.packages(ask = FALSE, instlib = Sys.getenv("R_LIBS_USER"))

# install the usual suspects
install.packages(c("rmd", "tidyverse", "addinslist"), dependencies=TRUE)

# helpers
install.packages("formatR", dependencies=TRUE) # knitr uses this to format code; see https://yihui.org/knitr/

# the rest
install.packages(c("revealjs", "tufte", "distill", "DiagrammeR", "DiagrammeRsvg", "rsvg"), dependencies=TRUE)
