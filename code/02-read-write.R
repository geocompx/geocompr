## ---- echo=FALSE, include=FALSE------------------------------------------
if(!exists("world"))
        source("code/01-introduction.R")

## ---- results='hide'-----------------------------------------------------
library(microbenchmark)
bench_read = microbenchmark(times = 5,
        st_read(f),
        rgdal::readOGR(f)
)

## ------------------------------------------------------------------------
bench_read$time[1] / bench_read$time[2]

## ---- echo=FALSE, results='hide'-----------------------------------------
world_files = list.files(pattern = "world\\.")
file.remove(world_files)

## ---- warning=FALSE, results='hide'--------------------------------------
bench_write = microbenchmark(times = 1,
        st_write(world, "world.geojson"),
        st_write(world, "world.shp"),
        st_write(world, "world.gpkg")
)

## ---- echo=FALSE, results='hide'-----------------------------------------
world_files = list.files(pattern = "world\\.")
file.remove(world_files)

## ------------------------------------------------------------------------
bench_write

## ------------------------------------------------------------------------
sf_drivers = st_drivers()
head(sf_drivers, n = 2)

