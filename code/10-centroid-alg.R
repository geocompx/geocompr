# Aim take a matrix representing a convex polygon, return its centroid
# demonstrate how algorithms work
i = 2:(nrow(poly_mat) - 2)
T_all = lapply(i, function(x) {
  rbind(O, poly_mat[x:(x + 1), ], O)
})
A = sapply(T_all, function(x) {
  abs(x[1, 1] * (x[2, 2] - x[3, 2]) +
        x[2, 1] * (x[3, 2] - x[1, 2]) +
        x[3, 1] * (x[1, 2] - x[2, 2]) ) / 2
})
C = t(sapply(T_all,  function(x) (x[1, ] + x[2, ] + x[3, ]) / 3))
print(paste0("The area is: ", sum(A)))
print(paste0(
  "The coordinates are: ",
  round(weighted.mean(C[, 1], A), 2),
  ", ",
  round(weighted.mean(C[, 2], A), 2)
))
