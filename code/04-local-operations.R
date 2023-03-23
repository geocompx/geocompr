library(tmap)
library(terra)
elev = rast(system.file("raster/elev.tif", package = "spData"))

elev_poly = st_as_sf(as.polygons(elev))
elev2 = elev + elev; elev_poly2 = st_as_sf(as.polygons(elev2, dissolve = FALSE))
elev3 = elev^2; elev_poly3 = st_as_sf(as.polygons(elev3, dissolve = FALSE))
elev4 = log(elev); elev_poly4 = st_as_sf(as.polygons(elev4, dissolve = FALSE))
elev5 = elev > 5; elev_poly5 = st_as_sf(as.polygons(elev5, dissolve = FALSE))

tm1 = tm_shape(elev_poly) +
  tm_polygons(col = "elev", lwd = 0.5, style = "cont", title = "", legend.is.portrait = FALSE) +
  tm_layout(frame = FALSE, legend.width = 0.8, legend.outside = TRUE, legend.outside.position = "bottom",
            main.title = "elev")
tm2 = tm_shape(elev_poly2) +
  tm_polygons(col = "elev", lwd = 0.5, style = "cont", title = "", legend.is.portrait = FALSE) +
  tm_layout(frame = FALSE, legend.width = 0.8, legend.outside = TRUE, legend.outside.position = "bottom",
            main.title = "elev + elev")
tm3 = tm_shape(elev_poly3) +
  tm_polygons(col = "elev", lwd = 0.5, style = "cont", title = "", legend.is.portrait = FALSE) +
  tm_layout(frame = FALSE, legend.width = 0.8, legend.outside = TRUE, legend.outside.position = "bottom",
            main.title = "elev^2")
tm4 = tm_shape(elev_poly4) +
  tm_polygons(col = "elev", lwd = 0.5, style = "cont", title = "", legend.is.portrait = FALSE) +
  tm_layout(frame = FALSE, legend.width = 1, legend.outside = TRUE, legend.outside.position = "bottom",
            main.title = "log(elev)")
tm5 = tm_shape(elev_poly5) +
  tm_polygons(col = "elev", lwd = 0.5, style = "cat", title = "", legend.is.portrait = FALSE) +
  tm_layout(frame = FALSE, legend.width = 1, legend.outside = TRUE, legend.outside.position = "bottom",
            main.title = "elev > 5")
tma = tmap_arrange(tm2, tm3, tm4, tm5, nrow = 1)
tmap_save(tma, "figures/04-local-operations.png", height = 700, width = 2000)

if (packageVersion("tmap") >= "4.0"){
  tm1 = tm_shape(elev_poly) +
    tm_polygons(fill = "elev", lwd = 0.5, fill.scale = tm_scale_continuous(),
                fill.legend = tm_legend(title = "", orientation = "landscape",
                                        position = tm_pos_out(cell.h = "center",
                                                              cell.v = "bottom"))) +
    tm_title("elev") +
    tm_layout(frame = FALSE)
  tm2 = tm_shape(elev_poly2) +
    tm_polygons(fill = "elev", lwd = 0.5, fill.scale = tm_scale_continuous(),
                fill.legend = tm_legend(title = "", orientation = "landscape",
                                        position = tm_pos_out(cell.h = "center",
                                                              cell.v = "bottom"))) +
    tm_title("elev + elev") +
    tm_layout(frame = FALSE)
  tm3 = tm_shape(elev_poly3) +
    tm_polygons(fill = "elev", lwd = 0.5, fill.scale = tm_scale_continuous(),
                fill.legend = tm_legend(title = "", orientation = "landscape",
                                        position = tm_pos_out(cell.h = "center",
                                                              cell.v = "bottom"))) +
    tm_title("elev^2") +
    tm_layout(frame = FALSE)
  tm4 = tm_shape(elev_poly4) +
    tm_polygons(fill = "elev", lwd = 0.5, fill.scale = tm_scale_continuous(),
                fill.legend = tm_legend(title = "", orientation = "landscape",
                                        position = tm_pos_out(cell.h = "center",
                                                              cell.v = "bottom"))) +
    tm_title("log(elev)") +
    tm_layout(frame = FALSE)
  tm5 = tm_shape(elev_poly5) +
    tm_polygons(fill = "elev", lwd = 0.5, fill.scale = tm_scale_categorical(),
                fill.legend = tm_legend(title = "", orientation = "landscape",
                                        position = tm_pos_out(cell.h = "center",
                                                              cell.v = "bottom"))) +
    tm_title("elev > 5") +
    tm_layout(frame = FALSE)
  tma = tmap_arrange(tm2, tm3, tm4, tm5, nrow = 1)
  tmap_save(tma, "figures/04-local-operations.png", height = 700, width = 2000)
}