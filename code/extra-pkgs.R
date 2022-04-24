pkgs = c(
  "cranlogs", # automated cran-logs
  "USAboundaries", # for plots of the globe
  "tidytext" # for word count
  )

to_install = !pkgs %in% installed.packages()
if(any(to_install)) {
  install.packages(pkgs[to_install])
}

gh_pkgs = c(
  "ropenscilabs/packagemetrics",
  "ropensci/USAboundariesData"
  )
remotes::install_github(gh_pkgs)
