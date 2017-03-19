library(sf) # load sf library
p = st_sfc(st_point(c(0, 1)), st_point(c(1, 1))) # create 2 points
b = st_buffer(p, dist = 1) # convert points to circles
i = st_intersection(b[1], b[2]) # find intersection between circles
plot(b) # plot circles
text(x = c(-0.5, 1.5), y = 1, labels = c("Geography", "R")) # add text
plot(i, col = "lightgrey", add = TRUE) # color intersecting area
