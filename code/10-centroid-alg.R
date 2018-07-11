# Aim take a matrix representing a convex polygon, return its centroid,
# demonstrate how algorithms work
# pre-requisite: an input object named poly_mat with 2 columns representing
# vertices of a polygon, with 1st and last rows identical
O = poly_mat[1, ] # create a point representing the origin
i = 2:(nrow(poly_mat) - 2)
T_all = lapply(i, function(x) {
  rbind(O, poly_mat[x:(x + 1), ], O)
})
A = vapply(T_all, function(x) {
  abs(x[1, 1] * (x[2, 2] - x[3, 2]) +
        x[2, 1] * (x[3, 2] - x[1, 2]) +
        x[3, 1] * (x[1, 2] - x[2, 2]) ) / 2
}, FUN.VALUE = double(1))
C_list = lapply(T_all,  function(x) (x[1, ] + x[2, ] + x[3, ]) / 3)
C = do.call(rbind, C_list)
print(paste0("The area is: ", sum(A)))
print(paste0(
  "The coordinates are: ",
  round(weighted.mean(C[, 1], A), 2),
  ", ",
  round(weighted.mean(C[, 2], A), 2)
))
