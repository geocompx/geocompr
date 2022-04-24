# Aim: compare sf vs sfheaders in terms of speed

library(spData)
library(sf)

# proof of concept
world_df = sf::st_coordinates(world)
head(world_df)
summary(world_df) # what does each mean?
# world_df_split = split(world_df, world_df[, "L1"]) # how to reassemble?

world_df_sfh = sfheaders::sf_to_df(world)
head(world_df_sfh)
world_sfh = sfheaders::sf_multipolygon(world_df_sfh)
world_sfh = sfheaders::sf_multipolygon(world_df_sfh, x = "x", y = "y", polygon_id = "", multipolygon_id = "multipolygon_id")
length(world$geom)
length(world_sfh$geometry)
waldo::compare(world$geom[1], world_sfh$geometry[1]) # how to get the same object back?
world$geom[1][[1]][[2]]
world_sfh$geom[1][[1]][[2]]
plot(world$geom[1])
plot(world_sfh$geometry[1])

bench::mark(
  check = FALSE,
  sf = sf::st_coordinates(world),
  sfheaders = sfheaders::sf_to_df(world)
  )
# # A tibble: 2 × 13
# expression      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result memory     time             gc      
# <bch:expr> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list> <list>     <list>           <list>  
#   1 sf           4.74ms   4.91ms      198.    1.86MB     11.6    85     5      430ms <NULL> <Rprofmem> <bench_tm [90]>  <tibble>
#   2 sfheaders    1.01ms   1.08ms      894.     2.1MB     56.6   142     9      159ms <NULL> <Rprofmem> <bench_tm [151]> <tibble>



library(sf)
nc = sf::st_read(system.file("./shape/nc.shp", package = "sf"))

# sf::st_cast(nc, "LINESTRING")
## Error

sfheaders::sf_cast(nc, "LINESTRING")

# And where it is comparible between sf and sfheaders, the latter is faster

bench::mark(check = FALSE,
  sf = {
    sf::st_cast(nc, "POINT")
  },
  sfheaders = {
    sfheaders::sf_cast(nc, "POINT")
  }
)

