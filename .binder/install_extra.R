# set default repo
options(repos = c(CRAN = "https://cloud.r-project.org"))

# create local user library path (not present by default)
# see https://stackoverflow.com/a/43283085
dir.create(path = Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)

# update everything and install to local user library path
update.packages(ask = FALSE, instlib = Sys.getenv("R_LIBS_USER"))

# install the usual suspects
install.packages(c("remotes"))

remotes::install_github("geocompr/geocompkg")