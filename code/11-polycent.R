# Aim: create visualization showing steps in centroid algorithm
if(!exists("poly_mat")) {
  # source("code/chapters/10-algorithms.R")
  x_coords = c(10, 0, 0, 2, 20, 10)
  y_coords = c(0, 0, 10, 12, 15, 0)
  poly_mat = cbind(x_coords, y_coords)
  O = poly_mat[1, ] # create a point representing the origin
  
  t_area = function(x) {
    abs(
      x[1, 1] * (x[2, 2] - x[3, 2]) +
        x[2, 1] * (x[3, 2] - x[1, 2]) +
        x[3, 1] * (x[1, 2] - x[2, 2])
    ) / 2
  }
  
  t_centroid = function(x) {
    (x[1, ] + x[2, ] + x[3, ]) / 3
  }
  
  i = 2:(nrow(poly_mat) - 2)
  T_all = purrr::map(i, ~rbind(O, poly_mat[.:(. + 1), ], O))
  A = purrr::map_dbl(T_all, ~t_area(.))
  C_list = lapply(T_all, t_centroid)
  C = do.call(rbind, C_list)
}
# plot(poly_mat)
# lines(poly_mat)

# # manual solution:
# lines(T_all[[1]], col = "blue", lwd = 2)
# text(x = C[1, 1], y = C[1, 2], "C1", col = "blue")
# lines(T_all[[2]], col = "red", lwd = 2)
# text(x = C[2, 1], y = C[2, 2], "C2", col = "red")

# iterating solution:
par(mfrow = c(1, 3), mar = c(0, 0, 0, 0), pty = "s") # optional wide plot (alternative = animation)
i = 2
cols = c("red", "blue", "darkgreen")
for(i in rep(1:length(T_all), 2)) {
  if(i == 1 | sum(par()$mfrow) > 2) {
    plot(poly_mat, xlab = "", ylab = "", axes = FALSE)
    lines(poly_mat)
  }
  lines(T_all[[i]], col = cols[i], lwd = 2)
  # lines(do.call(rbind, T_all[1:i]), col = cols[1:i], lwd = 2)
  text(x = C[i, 1], y = C[i, 2], paste0("C", i), col = cols[i])
  if(i != 1) {
    points(x = mean(C[1:i, 1]), y = mean(C[1:i, 2]), pch = 4, cex = 2)
  }
  Sys.sleep(time = 0.5)
}
par(mfrow = c(1, 1))
