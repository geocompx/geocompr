pkgs = c("cranlogs", # automated cran-logs
         "globe", # for plots of the globe
         "tidytext" # for work count
         )

to_install = !pkgs %in% installed.packages()
if(any(to_install)) {
  install.packages(pkgs[to_install])
}
