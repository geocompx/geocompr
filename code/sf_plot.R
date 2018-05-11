# https://stackoverflow.com/questions/35631889/ggplot2-align-multiple-plots-with-varying-spacings-and-add-arrows-between-them
library(sf)
library(ggplot2)
library(lattice)
library(grid)
library(gridExtra)

## sfc objects creation ---------
point_sfc = st_sfc(st_point(c(1, 1)), crs = 4326)
linestring_sfc = st_sfc(st_linestring(rbind(c(0.8, 1), c(0.8, 1.2), c(1, 1.2))), crs = 4326)
polygon_sfc = st_sfc(st_polygon(list(rbind(
  c(1.2, 0.6), c(1.4, 0.6), c(1.4, 0.8), c(1.2, 0.8), c(1.2, 0.6)
))), crs = 4326)
multipoint_sfc = st_sfc(st_multipoint(rbind(c(1, 0.6), c(1.4, 1.1))), crs = 4326)
multilinestring_sfc = st_sfc(st_multilinestring(list(rbind(
  c(1.2, 1), c(1.2, 1.4)
),
rbind(
  c(1.4, 0.4), c(1.6, 0.6), c(1.6, 0.8)
))), crs = 4326)
multipolygon_sfc = st_sfc(st_multipolygon(list(list(rbind(
  c(1.4, 1.2), c(1.6, 1.4), c(1.4, 1.4), c(1.4, 1.2)
)),
st_polygon(
  list(rbind(
    c(0.6, 0.6), c(0.9, 0.6), c(0.9, 0.9), c(0.6, 0.9), c(0.6, 0.6)
  ),
  rbind(
    c(0.7, 0.7), c(0.8, 0.8), c(0.8, 0.7), c(0.7, 0.7)
  ))
))),
crs = 4326)

## sf objects creation ---------
point_sf = st_sf(geometry = point_sfc)
linestring_sf = st_sf(geometry = linestring_sfc)
polygon_sf = st_sf(geometry = polygon_sfc)
multipoint_sf = st_sf(geometry = multipoint_sfc)
multilinestring_sf = st_sf(geometry = multilinestring_sfc)
multipolygon_sf = st_sf(geometry = multipolygon_sfc)
geometrycollection_sf = st_cast(
  c(
    point_sfc,
    linestring_sfc,
    polygon_sfc,
    multipoint_sfc,
    multilinestring_sfc,
    multipolygon_sfc
  ),
  "GEOMETRYCOLLECTION"
)

## single plots ----------
p_point_sf = ggplot() +
  geom_sf(data = point_sf) +
  labs(title = "POINT") +
  coord_sf(xlim = c(0.6, 1.6), ylim = c(0.4, 1.4)) +
  theme(line = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank())

p_linestring_sf = ggplot() +
  geom_sf(data = linestring_sf) +
  labs(title = "LINESTRING") +
  coord_sf(xlim = c(0.6, 1.6), ylim = c(0.4, 1.4)) +
  theme(line = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank())

p_polygon_sf = ggplot() +
  geom_sf(data = polygon_sf, fill = "grey") +
  labs(title = "POLYGON")  +
  coord_sf(xlim = c(0.6, 1.6), ylim = c(0.4, 1.4)) +
  theme(line = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank())

p_multipoint_sf = ggplot() +
  geom_sf(data = multipoint_sf) +
  labs(title = "MULTIPOINT") +
  coord_sf(xlim = c(0.6, 1.6), ylim = c(0.4, 1.4)) +
  theme(line = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank())

p_multilinestring_sf = ggplot() +
  geom_sf(data = multilinestring_sf) +
  labs(title = "MULTILINESTRING") +
  coord_sf(xlim = c(0.6, 1.6), ylim = c(0.4, 1.4)) +
  theme(line = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank())

p_multipolygon_sf = ggplot() +
  geom_sf(data = multipolygon_sf, fill = "grey") +
  labs(title = "MULTIPOLYGON")  +
  coord_sf(xlim = c(0.6, 1.6), ylim = c(0.4, 1.4)) +
  theme(line = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank())

p_geometrycollection_sf = ggplot() +
  geom_sf(data = point_sf) +
  geom_sf(data = linestring_sf) +
  geom_sf(data = polygon_sf, fill = "grey") +
  geom_sf(data = multipoint_sf) +
  geom_sf(data = multilinestring_sf) +
  geom_sf(data = multipolygon_sf, fill = "grey") +
  labs(title = "GEOMETRYCOLLECTION")  +
  coord_sf(xlim = c(0.6, 1.6), ylim = c(0.4, 1.4)) +
  theme(
    line = element_blank(),
    axis.text = element_blank(),
    axis.title = element_blank(),
    title = element_text(size = 8)
  )

## combine plot ------------
png("figures/sf-classes.png", height = 600, width = 600)
# Empty grob for spacing
b = nullGrob() # per @baptiste's comment, use nullGrob() instead of rectGrob()

# grid.bezier with a few hard-coded settings
mygb = function(x, y) {
  grid.bezier(
    x = x,
    y = y,
    gp = gpar(col = "grey", fill = "grey"),
    arrow = arrow(type = "closed", length = unit(2, "mm"))
  )
}

r1 = arrangeGrob(
  b,
  p_multilinestring_sf,
  b,
  p_multipoint_sf,
  b,
  layout_matrix = rbind(c(1, 2, 3, 4, 5)),
  widths = c(13.3, 30, 13.3, 30, 13.3)
)
r2 = arrangeGrob(b)
r3 = arrangeGrob(
  p_multipolygon_sf,
  b,
  p_geometrycollection_sf,
  b,
  p_polygon_sf,
  layout_matrix = rbind(c(1, 2, 3, 4, 5)),
  widths = c(30, 5, 30, 5, 30)
)
r4 = arrangeGrob(b)
r5 = arrangeGrob(
  b,
  p_point_sf,
  b,
  p_linestring_sf,
  b,
  layout_matrix = rbind(c(1, 2, 3, 4, 5)),
  widths = c(13.3, 30, 13.3, 30, 13.3)
)

grid.arrange(r1,
             r2,
             r3,
             r4,
             r5,
             ncol = 1,
             heights = c(30, 5, 30, 5, 30))

# topleft arrow
vp = viewport(
  x = 0.35,
  y = 0.66,
  width = 0.08,
  height = 0.1
)
pushViewport(vp)

# grid.rect(gp=gpar(fill="black", alpha=0.1)) # Use this to see where your viewport is located on the full graph layout

mygb(x = c(0, 0.4, 0.4, 1), y = c(1, 0.4, 0.4, 0))

# left arrow
popViewport()
vp = viewport(
  x = 0.33,
  y = 0.5,
  width = 0.12,
  height = 0.1
)
pushViewport(vp)

mygb(x = c(0, 0.33, 0.66, 1), y = c(0.5, 0.5, 0.5, 0.5))

# bottom left arrow
popViewport()
vp = viewport(
  x = 0.35,
  y = 0.31,
  width = 0.08,
  height = 0.1
)
pushViewport(vp)

mygb(x = c(0, 0.6, 0.6, 1), y = c(0, 0.4, 0.4, 1))


# bottom right arrow
popViewport()
vp = viewport(
  x = 0.65,
  y = 0.31,
  width = 0.08,
  height = 0.1
)
pushViewport(vp)

mygb(x = c(1, 0.4, 0.4, 0), y = c(0, 0.4, 0.4, 1))

# right arrow
popViewport()
vp = viewport(
  x = 0.68,
  y = 0.5,
  width = 0.12,
  height = 0.1
)
pushViewport(vp)

mygb(x = c(1, 0.66, 0.33, 0), y = c(0.5, 0.5, 0.5, 0.5))

# top right arrow
popViewport()
vp = viewport(
  x = 0.65,
  y = 0.66,
  width = 0.08,
  height = 0.1
)
pushViewport(vp)

mygb(x = c(1, 0.6, 0.6, 0), y = c(1, 0.4, 0.4, 0))
dev.off()