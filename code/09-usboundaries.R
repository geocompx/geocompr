# Aim: create animation showing shifting US boundaries
# depends on 17 MB USAboundariesData package
# link to script file that shows chaning state boundaries
# install.packages("USAboundaries")
library(USAboundaries)
dates = lubridate::as_date(unique(historydata::us_state_populations$year))
# USAboundaries::us_boundaries(map_date = dates[1])
# ...