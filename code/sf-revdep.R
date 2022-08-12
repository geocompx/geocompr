library(tidyverse)
sf_revdeps = devtools::revdep("sf",
                              dependencies = c("Depends", "Imports"))
sf_revdeps_dls = cranlogs::cran_downloads(packages = sf_revdeps, when = "last-month")
top_dls = sf_revdeps_dls %>% 
  group_by(package) %>% 
  summarise(Downloads = round(mean(count)), date = max(date)) %>% 
  arrange(desc(Downloads))
write_csv(top_dls, "extdata/top_dls.csv")
