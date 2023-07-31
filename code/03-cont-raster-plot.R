library(tmap)
library(terra)

elev = rast(system.file("raster/elev.tif", package = "spData"))
grain = rast(system.file("raster/grain.tif", package = "spData"))
colfunc2 = c("clay" = "brown", "silt" = "sandybrown", "sand" = "rosybrown") 

p1 = tm_shape(elev) + 
  tm_raster(col.scale = tm_scale_continuous(),
            col.legend = tm_legend(title = "",
                                   position = tm_pos_auto_in(),
                                   bg.color = "white")) 

p2 = tm_shape(grain) + 
  tm_raster(col.scale = tm_scale_categorical(values = colfunc2),
            col.legend = tm_legend(title = "",
                                   position = tm_pos_auto_in(),
                                   bg.color = "white")) 
tmap_arrange(p1, p2, nrow = 1)
