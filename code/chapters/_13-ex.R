## ----13-ex-e0, message=FALSE------------------------------------------------------------------------
library(sf)
library(spDataLarge)


## ----13-e1, eval=FALSE, echo=FALSE------------------------------------------------------------------
## sum(desire_lines$car_driver) / sum(desire_lines$all)
## # 57%
## desire_lines_5km_plus = desire_lines |>
##   filter(distance_km > 5)
## # Just over are half ar 5km+, 54%:
## nrow(desire_lines_5km_plus) / nrow(desire_lines)
## # 71 of 5km+ trips are made by car
## sum(desire_lines_5km_plus$car_driver) / sum(desire_lines_5km_plus$all)
## 
## desire_lines_driving = desire_lines |>
##   mutate(`Proportion driving` = car_driver / all) |>
##   filter(`Proportion driving` > 0.5)
## nrow(desire_lines_5km_plus_driving) / nrow(desire_lines)
## 
## desire_lines_5km_less_50_pct_driving = desire_lines |>
##   filter(distance_km <= 5) |>
##   mutate(`Proportion driving` = car_driver / all) |>
##   filter(`Proportion driving` > 0.5)
## desire_lines_5km_less_50_pct_driving |>
##   tm_shape() +
##   tm_lines("Proportion driving")


## ----13-transport-29, eval=FALSE, echo=FALSE--------------------------------------------------------
## sum(st_length(route_network_no_infra))
## # 104193.6 [m]
## # Just over 100 km


## ----13-transport-30, echo=FALSE, eval=FALSE--------------------------------------------------------
## sum(routes_short_scenario$all) / sum(desire_lines$all) # 13%
## d_intersect = desire_lines[routes_short_scenario, , op = st_crosses]
## sum(d_intersect$all) / sum(desire_lines$all) # 88%

