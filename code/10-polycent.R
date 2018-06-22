# Aim: create visualisation showing steps in centroid algorithm
plot(poly_mat)
lines(poly_mat)
lines(T1, col = "blue", lwd = 2)
text(x = C1[1], y = C1[2], "C1", col = "blue")
lines(Ti[[2]], col = "red", lwd = 2)
text(x = C[2, 1], y = C[2, 2], "C2", col = "red")