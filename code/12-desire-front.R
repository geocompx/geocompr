# Aim: generate tmap figure representing desire lines

# load data if not already loaded:
if(!exists("desire_lines")) {
  library(sf)
  library(tidyverse)
  library(spDataLarge)
  library(stplanr)
  library(tmap)     
  zones_attr = bristol_od %>% 
    group_by(o) %>% 
    summarize_if(is.numeric, sum) %>% 
    dplyr::rename(geo_code = o)
  
  zones_joined = left_join(bristol_zones, zones_attr, by = "geo_code")
  
  zones_od = bristol_od %>% 
    group_by(d) %>% 
    summarize_if(is.numeric, sum) %>% 
    dplyr::select(geo_code = d, all_dest = all) %>% 
    inner_join(zones_joined, ., by = "geo_code")
  
  od_top5 = bristol_od %>% 
    arrange(desc(all)) %>% 
    top_n(5, wt = all)
  
  bristol_od$Active = (bristol_od$bicycle + bristol_od$foot) /
    bristol_od$all * 100
  
  od_intra = filter(bristol_od, o == d)
  od_inter = filter(bristol_od, o != d)
  desire_lines = od2line(od_inter, zones_od)
}

tmap_mode("plot")
desire_lines_top5 = od2line(od_top5, zones_od)
# tmaptools::palette_explorer()
tm_shape(desire_lines) +
  tm_lines(palette = "plasma", breaks = c(0, 5, 10, 20, 40, 100),
           lwd = "all",
           scale = 9,
           title.lwd = "Number of trips",
           alpha = 0.6,
           col = "Active",
           title = "Active travel (%)"
  ) +
  tm_legend(show = FALSE) +
  tm_layout(frame = FALSE)

