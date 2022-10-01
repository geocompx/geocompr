## ----10-algorithms-1--------------------------------------------------------------------------------------------------------------------------------------
source("code/11-hello.R")


## ----codecheck, echo=FALSE, fig.cap="Code checking in RStudio. This example, from the script 11-centroid-alg.R, highlights an unclosed curly bracket on line 19.", fig.scap="Illustration of 'code checking' in RStudio."----
knitr::include_graphics("figures/codecheck.png")


## A useful tool for reproducibility is the **reprex** package.

## Its main function `reprex()` tests lines of R code to check if they are reproducible, and provides markdown output to facilitate communication on sites such as GitHub.

## See the web page reprex.tidyverse.org for details.


## ----10-algorithms-2, eval=FALSE--------------------------------------------------------------------------------------------------------------------------
## poly_mat = cbind(
##   x = c(0, 0, 9, 9, 0),
##   y = c(0, 9, 9, 0, 0)
## )
## source("https://raw.githubusercontent.com/Robinlovelace/geocompr/master/code/11-centroid-alg.R")


## ----10-algorithms-3, echo=FALSE--------------------------------------------------------------------------------------------------------------------------
poly_mat = cbind(
  x = c(0, 0, 9, 9, 0),
  y = c(0, 9, 9, 0, 0)
)
if(curl::has_internet()) {
  source("https://raw.githubusercontent.com/Robinlovelace/geocompr/master/code/11-centroid-alg.R")
  } else {
  source("code/11-centroid-setup.R")
  }


## ----centroid-setup, echo=FALSE, eval=FALSE---------------------------------------------------------------------------------------------------------------
## # show where the data came from:
## source("code/11-centroid-setup.R")


## ----10-algorithms-4--------------------------------------------------------------------------------------------------------------------------------------
# generate a simple matrix representation of a polygon:
x_coords = c(10, 0, 0, 12, 20, 10)
y_coords = c(0, 0, 10, 20, 15, 0)
poly_mat = cbind(x_coords, y_coords)


## ----10-algorithms-5--------------------------------------------------------------------------------------------------------------------------------------
# create a point representing the origin:
Origin = poly_mat[1, ]
# create 'triangle matrix':
T1 = rbind(Origin, poly_mat[2:3, ], Origin) 
# find centroid (drop = FALSE preserves classes, resulting in a matrix):
C1 = (T1[1, , drop = FALSE] + T1[2, , drop = FALSE] + T1[3, , drop = FALSE]) / 3


## ----polymat, echo=FALSE, fig.cap="Illustration of polygon centroid calculation problem.", fig.height="100", warning=FALSE--------------------------------
# initial plot: can probably delete this:
old_par = par(pty = "s") 
plot(poly_mat)
lines(poly_mat)
lines(T1, col = "blue", lwd = 5)
text(x = C1[ ,1], y = C1[, 2], "C1")
par(old_par)


## ----10-algorithms-6--------------------------------------------------------------------------------------------------------------------------------------
# calculate the area of the triangle represented by matrix T1:
abs(T1[1, 1] * (T1[2, 2] - T1[3, 2]) +
  T1[2, 1] * (T1[3, 2] - T1[1, 2]) +
  T1[3, 1] * (T1[1, 2] - T1[2, 2]) ) / 2


## ----10-algorithms-7--------------------------------------------------------------------------------------------------------------------------------------
i = 2:(nrow(poly_mat) - 2)
T_all = lapply(i, function(x) {
  rbind(Origin, poly_mat[x:(x + 1), ], Origin)
})

C_list = lapply(T_all,  function(x) (x[1, ] + x[2, ] + x[3, ]) / 3)
C = do.call(rbind, C_list)

A = vapply(T_all, function(x) {
  abs(x[1, 1] * (x[2, 2] - x[3, 2]) +
        x[2, 1] * (x[3, 2] - x[1, 2]) +
        x[3, 1] * (x[1, 2] - x[2, 2]) ) / 2
  }, FUN.VALUE = double(1))


## ----polycent, fig.cap="Illustration of iterative centroid algorithm with triangles. The X represents the area-weighted centroid in iterations 2 and 3.", fig.scap="Illustration of iterative centroid algorithm with triangles.", echo=FALSE, fig.asp=0.3----
# idea: show animated version on web version
source("code/11-polycent.R")


## ----10-algorithms-8--------------------------------------------------------------------------------------------------------------------------------------
source("code/11-centroid-alg.R")


## ----10-algorithms-9--------------------------------------------------------------------------------------------------------------------------------------
t_centroid = function(x) {
  (x[1, ] + x[2, ] + x[3, ]) / 3
}


## ----10-algorithms-10, eval=FALSE, echo=FALSE-------------------------------------------------------------------------------------------------------------
## body(t_centroid)
## formals(t_centroid)
## environment(t_centroid)


## ----10-algorithms-11-------------------------------------------------------------------------------------------------------------------------------------
t_centroid(T1)


## ----10-algorithms-12-------------------------------------------------------------------------------------------------------------------------------------
t_area = function(x) {
  abs(
    x[1, 1] * (x[2, 2] - x[3, 2]) +
    x[2, 1] * (x[3, 2] - x[1, 2]) +
    x[3, 1] * (x[1, 2] - x[2, 2])
  ) / 2
}


## ----10-algorithms-13-------------------------------------------------------------------------------------------------------------------------------------
t_area(T1)


## ----10-algorithms-14-------------------------------------------------------------------------------------------------------------------------------------
t_new = cbind(x = c(0, 3, 3, 0),
              y = c(0, 0, 1, 0))
t_area(t_new)


## ----10-algorithms-15-------------------------------------------------------------------------------------------------------------------------------------
poly_centroid = function(poly_mat) {
  Origin = poly_mat[1, ] # create a point representing the origin
  i = 2:(nrow(poly_mat) - 2)
  T_all = lapply(i, function(x) {
    rbind(Origin, poly_mat[x:(x + 1), ], Origin)
  })
  C_list = lapply(T_all, t_centroid)
  C = do.call(rbind, C_list)
  A = vapply(T_all, t_area, FUN.VALUE = double(1))
  c(weighted.mean(C[, 1], A), weighted.mean(C[, 2], A))
}


## ----10-algorithms-16, echo=FALSE, eval=FALSE-------------------------------------------------------------------------------------------------------------
## # a slightly more complex version of the function with output set
## poly_centroid = function(poly_mat, output = "matrix") {
##   Origin = poly_mat[1, ] # create a point representing the origin
##   i = 2:(nrow(poly_mat) - 2)
##   T_all = T_all = lapply(i, function(x) {
##     rbind(Origin, poly_mat[x:(x + 1), ], Origin)
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


## ----10-algorithms-17-------------------------------------------------------------------------------------------------------------------------------------
poly_centroid(poly_mat)


## ----10-algorithms-18-------------------------------------------------------------------------------------------------------------------------------------
poly_centroid_sfg = function(x) {
  centroid_coords = poly_centroid(x)
  sf::st_point(centroid_coords)
}


## ----10-algorithms-19-------------------------------------------------------------------------------------------------------------------------------------
poly_sfc = sf::st_polygon(list(poly_mat))
identical(poly_centroid_sfg(poly_mat), sf::st_centroid(poly_sfc))


## ----10-algorithms-20, eval=FALSE, echo=FALSE-------------------------------------------------------------------------------------------------------------
## poly_sfc = sf::st_polygon(list(poly_mat))
## sf::st_area(poly_sfc)
## sf::st_centroid(poly_sfc)


## ----10-algorithms-21, eval=FALSE, echo=FALSE-------------------------------------------------------------------------------------------------------------
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

