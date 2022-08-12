if(!exists("b")) {
  library(sf)
  b = st_sfc(st_point(c(0, 1)), st_point(c(1, 1))) # create 2 points
  b = st_buffer(b, dist = 1) # convert points to circles
  l = c("x", "y")
  x = b[1]
  y = b[2]
  x_and_y = st_intersection(x, y)
}

old_par = par(mfrow = c(2, 3), mai = c(0.1, 0.1, 0.1, 0.1))
plot(b, border = "grey")
plot(x, add = TRUE, col = "lightgrey", border = "grey")
text(cex = 1.2, x = 0.5, y = 1, "x")
plot(b, add = TRUE, border = "grey")
x_not_y = st_difference(x, y)
plot(b, border = "grey")
plot(x_not_y, col = "lightgrey", add = TRUE, border = "grey")
text(cex = 1.2, x = 0.5, y = 1, "st_difference(x, y)")

y_not_x = st_difference(y, x)
plot(b, border = "grey")
plot(y_not_x, col = "lightgrey", add = TRUE, border = "grey")
text(cex = 1.2, x = 0.5, y = 1, "st_difference(y, x)")
x_or_y = st_union(x, y)
plot(x_or_y, col = "lightgrey", border = "grey")
text(cex = 1.2, x = 0.5, y = 1, "st_union(x, y)")
x_and_y = st_intersection(x, y)
plot(b, border = "grey")
plot(x_and_y, col = "lightgrey", add = TRUE, border = "grey") 
text(cex = 1.2, x = 0.5, y = 1, "st_intersection(x, y)")
# x_xor_y = st_difference(x_xor_y, x_and_y) # failing
x_xor_y = st_sym_difference(x, y)
plot(x_xor_y, col = "lightgrey", border = "grey")
text(cex = 1.2, x = 0.5, y = 1, "st_sym_difference(x, y)")
# plot.new()
# plot(b, border = "grey")
# plot(y, col = "lightgrey", add = TRUE, border = "grey")
# plot(b, add = TRUE, border = "grey")
# text(cex = 1.2, x = 0.5, y = 1, "y")
par(old_par)
