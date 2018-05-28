# tmap figure
# u_od = "https://user-images.githubusercontent.com/1825120/34081176-74fd39c8-e341-11e7-9f3e-b98807cb113b.png"
# knitr::include_graphics(u_od)
library(tmap)
tmap_mode("plot")
desire_lines_top5 = od2line(od_top5, zones_od)
tm_shape(desire_lines) +
  tm_lines(lwd = "all", scale = 7, title.lwd = "Number of trips", alpha = 0.6) +
  tm_shape(desire_lines_top5) +
  tm_lines(lwd = 5, col = "black", alpha = 0.7) +
  tm_scale_bar()