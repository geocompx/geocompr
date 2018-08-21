## ------------------------------------------------------------------------
source("code/10-hello.R")

## ----codecheck, echo=FALSE, fig.cap="Illustration of 'code checking' in RStudio. This example, from the script 10-centroid-alg.R, highlights an unclosed curly bracket on line 11."----
knitr::include_graphics("figures/codecheck.png")

## A useful tool for reproducibility is the **reprex** package.

## ---- eval=FALSE---------------------------------------------------------
## poly_mat = cbind(
##   x = c(0, 0, 9, 9, 0),
##   y = c(0, 9, 9, 0, 0)
## )
## source("https://git.io/10-centroid-alg.R") # short url

## ---- echo=FALSE---------------------------------------------------------
poly_mat = cbind(
  x = c(0, 0, 9, 9, 0),
  y = c(0, 9, 9, 0, 0)
)
if(curl::has_internet()) {
  source("https://git.io/10-centroid-alg.R")
  } else {
  source("code/10-centroid-setup.R")
  }

## ----centroid-setup, echo=FALSE, eval=FALSE------------------------------
## # show where the data came from:
## source("code/10-centroid-setup.R")

## ------------------------------------------------------------------------
x_coords = c(10, 0, 0, 12, 20, 10)
y_coords = c(0, 0, 10, 20, 15, 0)
poly_mat = cbind(x_coords, y_coords)

## ------------------------------------------------------------------------
O = poly_mat[1, ] # create a point representing the origin
T1 = rbind(O, poly_mat[2:3, ], O) # create 'triangle matrix'
C1 = (T1[1, ] + T1[2, ] + T1[3, ]) / 3 # find centroid

## ----polymat, echo=FALSE, fig.cap="Illustration of polygon centroid calculation problem.", fig.height="100"----
# initial plot: can probably delete this:
plot(poly_mat)
lines(poly_mat)
lines(T1, col = "blue", lwd = 5)
text(x = C1[1], y = C1[2], "C1")

## ------------------------------------------------------------------------
abs(T1[1, 1] * (T1[2, 2] - T1[3, 2]) +
  T1[2, 1] * (T1[3, 2] - T1[1, 2]) +
  T1[3, 1] * (T1[1, 2] - T1[2, 2]) ) / 2

## ------------------------------------------------------------------------
i = 2:(nrow(poly_mat) - 2)
T_all = lapply(i, function(x) {
  rbind(O, poly_mat[x:(x + 1), ], O)
})

C_list = lapply(T_all,  function(x) (x[1, ] + x[2, ] + x[3, ]) / 3)
C = do.call(rbind, C_list)

A = vapply(T_all, function(x) {
  abs(x[1, 1] * (x[2, 2] - x[3, 2]) +
        x[2, 1] * (x[3, 2] - x[1, 2]) +
        x[3, 1] * (x[1, 2] - x[2, 2]) ) / 2
  }, FUN.VALUE = double(1))

## ----polycent, fig.cap="Illustration of iterative centroid algorithm with triangles. The 'x' represents the area-weighted centroid in iterations 2 and 3.", echo=FALSE, fig.asp=0.3----
# idea: show animated version on web version
source("code/10-polycent.R")

## ------------------------------------------------------------------------
source("code/10-centroid-alg.R")

## ------------------------------------------------------------------------
t_centroid = function(x) {
  (x[1, ] + x[2, ] + x[3, ]) / 3
}

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## body(t_centroid)
## formals(t_centroid)
## environment(t_centroid)

## ------------------------------------------------------------------------
t_centroid(T1)

## ------------------------------------------------------------------------
t_area = function(x) {
  abs(
    x[1, 1] * (x[2, 2] - x[3, 2]) +
    x[2, 1] * (x[3, 2] - x[1, 2]) +
    x[3, 1] * (x[1, 2] - x[2, 2])
  ) / 2
}

## ------------------------------------------------------------------------
t_area(T1)

## ------------------------------------------------------------------------
t_new = cbind(x = c(0, 3, 3, 0),
              y = c(0, 0, 1, 0))
t_area(t_new)

## ------------------------------------------------------------------------
poly_centroid = function(x) {
  i = 2:(nrow(x) - 2)
  T_all = T_all = lapply(i, function(x) {
    rbind(O, poly_mat[x:(x + 1), ], O)
  })
  C_list = lapply(T_all, t_centroid)
  C = do.call(rbind, C_list)
  A = vapply(T_all, t_area, FUN.VALUE = double(1))
  c(weighted.mean(C[, 1], A), weighted.mean(C[, 2], A))
}

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## # a slightly more complex version of the function with output set
## poly_centroid = function(x, output = "matrix") {
##   i = 2:(nrow(x) - 2)
##   T_all = T_all = lapply(i, function(x) {
##     rbind(O, poly_mat[x:(x + 1), ], O)
##   })
##   C_list = lapply(T_all, t_centroid)
##   C = do.call(rbind, C_list)
##   A = vapply(T_all, t_area, FUN.VALUE = double(1))
##   centroid_coords = c(weighted.mean(C[, 1], A), weighted.mean(C[, 2], A))
##   if(output == "matrix") {
##     return(centroid_coords)
##   } else if(output == "area")
##     return(sum(A))
## }

## ------------------------------------------------------------------------
poly_centroid(poly_mat)

## ------------------------------------------------------------------------
poly_centroid_sfg = function(x) {
  centroid_coords = poly_centroid(x)
  sf::st_point(centroid_coords)
}

## ------------------------------------------------------------------------
poly_sfc = sf::st_polygon(list(poly_mat))
identical(poly_centroid_sfg(poly_mat), sf::st_centroid(poly_sfc))

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## poly_sfc = sf::st_polygon(list(poly_mat))
## sf::st_area(poly_sfc)
## sf::st_centroid(poly_sfc)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## poly_centroid_sf = function(x) {
##   stopifnot(is(x, "sf"))
##   xcoords = sf::st_coordinates(x)
##   centroid_coords = poly_centroid(xcoords)
##   centroid_sf = sf::st_sf(geometry = sf::st_sfc(sf::st_point(centroid_coords)))
##   centroid_sf
## }
## poly_centroid_sf(sf::st_sf(sf::st_sfc(poly_sfc)))
## poly_centroid_sf(poly_sfc)
## poly_centroid_sf(poly_mat)

