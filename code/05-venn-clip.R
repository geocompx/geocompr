if (!exists("b")) {
  library(sf)
  b = st_sfc(st_point(c(0, 1)), st_point(c(1, 1))) # create 2 points
  b = st_buffer(b, dist = 1) # convert points to circles
  l = c("x", "y")
  x = b[1]
  y = b[2]
  x_and_y = st_intersection(x, y)
}

old_par = par(mfrow = c(2, 3), mai = c(0.1, 0.1, 0.1, 0.1))
plot(b, border = "gray")
plot(x, add = TRUE, col = "lightgray", border = "gray")
text(cex = 1.8, x = 0.5, y = 1, "x")
plot(b, add = TRUE, border = "gray")
x_not_y = st_difference(x, y)
plot(b, border = "gray")
plot(x_not_y, col = "lightgray", add = TRUE, border = "gray")
text(cex = 1.8, x = 0.5, y = 1, "st_difference(x, y)")

y_not_x = st_difference(y, x)
plot(b, border = "gray")
plot(y_not_x, col = "lightgray", add = TRUE, border = "gray")
text(cex = 1.8, x = 0.5, y = 1, "st_difference(y, x)")
x_or_y = st_union(x, y)
plot(x_or_y, col = "lightgray", border = "gray")
text(cex = 1.8, x = 0.5, y = 1, "st_union(x, y)")
x_and_y = st_intersection(x, y)
plot(b, border = "gray")
plot(x_and_y, col = "lightgray", add = TRUE, border = "gray") 
text(cex = 1.8, x = 0.5, y = 1, "st_intersection(x, y)")
# x_xor_y = st_difference(x_xor_y, x_and_y) # failing
x_xor_y = st_sym_difference(x, y)
plot(x_xor_y, col = "lightgray", border = "gray")
text(cex = 1.8, x = 0.5, y = 1, "st_sym_difference(x, y)")
# plot.new()
# plot(b, border = "gray")
# plot(y, col = "lightgray", add = TRUE, border = "gray")
# plot(b, add = TRUE, border = "gray")
# text(cex = 1.2, x = 0.5, y = 1, "y")
par(old_par)
