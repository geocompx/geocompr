## ------------------------------------------------------------------------
source("code/10-hello.R")

## ----codecheck, echo=FALSE, fig.cap="Illustration of 'code checking' in RStudio, which identifies the incorrect dublicate pipe operator at the outset of a script."----
knitr::include_graphics("https://user-images.githubusercontent.com/1825120/39698841-6e600584-51ee-11e8-9dd0-2c17b2836f79.png")

## A useful tool for reproducibility is the **reprex** package.

## ----centroid-setup, echo=FALSE, eval=FALSE------------------------------
## # show where the data came from:
## source("code/10-centroid-setup.R")

## ------------------------------------------------------------------------
x_coords = c(10, 0, 0, 2, 20, 10)
y_coords = c(0, 0, 10, 12, 15, 0)
poly_mat = cbind(x_coords, y_coords)

## ------------------------------------------------------------------------
O = poly_mat[1, ] # create a point representing the origin
T1 = rbind(O, poly_mat[2:3, ], O) # create 'triangle matrix'
C1 = (T1[1, ] + T1[2, ] + T1[3, ]) / 3 # find centroid

## ---- echo=FALSE, fig.cap="Illustration of polygon centroid calculation problem."----
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
t_centroid = function(x) {
  (x[1, ] + x[2, ] + x[3, ]) / 3
}
t_centroid(T1)

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## ind = decido::earcut(poly_mat)
## decido::plot_ears(poly_mat, idx = ind)
## i = seq(1, length(ind), by = 3)
## i_list = purrr::map(i, ~c(.:(.+2), .))
## T_all = purrr::map(i_list, ~poly_mat[ind[.], ])

## ------------------------------------------------------------------------
T2 = rbind(O, poly_mat[3:4, ], O)
A2 = t_area(T2)
C2 = t_centroid(T2)

## ------------------------------------------------------------------------
# Aim: create all triangles representing a polygon
i = 2:(nrow(poly_mat) - 2)
Ti = purrr::map(i, ~rbind(O, poly_mat[.:(. + 1), ], O))
A = purrr::map_dbl(Ti, ~t_area(.))
C = t(sapply(Ti, t_centroid))

## ------------------------------------------------------------------------
sum(A)
c(weighted.mean(C[, 1], A), weighted.mean(C[, 2], A))

## ------------------------------------------------------------------------
poly_sfc = sf::st_polygon(list(poly_mat))
sf::st_area(poly_sfc)
sf::st_centroid(poly_sfc)

## ----polycent, fig.cap="Illustration of centroid calculation.", echo=FALSE----
source("code/10-polycent.R")

## ------------------------------------------------------------------------
t_new = matrix(c(0, 3, 3, 0, 0, 0, 1, 0), ncol = 2)
t_area(t_new)

## ------------------------------------------------------------------------
poly_centroid = function(x, output = "matrix") {
  i = 2:(nrow(x) - 2)
  Ti = purrr::map(i, ~rbind(O, x[.:(. + 1), ], O))
  A = purrr::map_dbl(Ti, ~t_area(.))
  C = t(sapply(Ti, t_centroid))
  centroid_coords = c(weighted.mean(C[, 1], A), weighted.mean(C[, 2], A))
  if(output == "matrix") {
    return(centroid_coords)
  } else if(output == "area")
    return(sum(A))
}

## ------------------------------------------------------------------------
poly_centroid(poly_mat)
poly_centroid(poly_mat, output = "area")

## ------------------------------------------------------------------------
poly_centroid_sfg = function(x) {
  centroid_coords = poly_centroid(x)
  centroid_sfg = sf::st_point(centroid_coords)
  centroid_sfg
}

## ------------------------------------------------------------------------
identical(poly_centroid_sfg(poly_mat), sf::st_centroid(poly_sfc))

## ------------------------------------------------------------------------
poly_centroid_type_stable = function(x) {
  stopifnot(is.matrix(x) & ncol(x) == 2)
  centroid_coords = poly_centroid(x)
  return(matrix(centroid_coords, ncol = 2))
}

## ---- warning=FALSE------------------------------------------------------
poly_mat3 = cbind(1:nrow(poly_mat), poly_mat)
poly_centroid(poly_mat3)

## ---- eval=FALSE---------------------------------------------------------
## poly_centroid_type_stable(poly_mat3)
## #> Error in poly_centroid_type_stable(poly_mat3) :
## #>   is.matrix(x) & ncol(x) == 2 is not TRUE

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

