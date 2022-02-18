# Aim: take a matrix representing a convex polygon, return its centroid,
# demonstrate how algorithms work

# Pre-requisite: an input object named poly_mat with 2 columns representing
# vertices of a polygon, with 1st and last rows identical:

if(!exists("poly_mat")) {
  message("No poly_mat object provided, creating object representing a 9 by 9 square")
  poly_mat = cbind(
    x = c(0, 0, 9, 9, 0),
    y = c(0, 9, 9, 0, 0)
  )
}

# Step 1: create sub-triangles, set-up ------------------------------------

Origin = poly_mat[1, ] # create a point representing the origin
i = 2:(nrow(poly_mat) - 2)
T_all = lapply(i, function(x) {
  rbind(Origin, poly_mat[x:(x + 1), ], Origin)
})


# Step 2: calculate triangle centroids ------------------------------------

C_list = lapply(T_all,  function(x) (x[1, ] + x[2, ] + x[3, ]) / 3)
C = do.call(rbind, C_list)

# Step 3: calculate triangle areas ----------------------------------------

A = vapply(T_all, function(x) {
  abs(x[1, 1] * (x[2, 2] - x[3, 2]) +
        x[2, 1] * (x[3, 2] - x[1, 2]) +
        x[3, 1] * (x[1, 2] - x[2, 2]) ) / 2
}, FUN.VALUE = double(1))

# Step 4: calculate area-weighted centroid average ------------------------

poly_area = sum(A)
print(paste0("The area is: ", poly_area))
poly_centroid = c(weighted.mean(C[, 1], A), weighted.mean(C[, 2], A))

# Step 5: output results --------------------------------------------------

print(paste0(
  "The coordinates of the centroid are: ",
  round(poly_centroid[1], 2),
  ", ",
  round(poly_centroid[2], 2)
))
