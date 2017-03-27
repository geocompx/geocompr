## ---- results='hide'-----------------------------------------------------
library(microbenchmark)
bench_read = microbenchmark(times = 5,
        st_read(f),
        rgdal::readOGR(f)
)

## ------------------------------------------------------------------------
bench_read$time[1] / bench_read$time[2]

## ---- echo=FALSE, results='hide'-----------------------------------------
w_files = list.files(pattern = "w\\.")
file.remove(w_files)

## ---- warning=FALSE, results='hide'--------------------------------------
bench_write = microbenchmark(times = 1,
        st_write(w, "w.geojson"),
        st_write(w, "w.shp"),
        st_write(w, "w.gpkg")
)

## ---- echo=FALSE, results='hide'-----------------------------------------
w_files = list.files(pattern = "w\\.")
file.remove(w_files)

## ------------------------------------------------------------------------
bench_write

## ------------------------------------------------------------------------
st_drivers()[1:2,]

