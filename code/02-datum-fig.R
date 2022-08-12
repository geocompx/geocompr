library(grid)
library(gridExtra)
library(jpeg)
library(PlaneGeometry)
library(ggplot2)
geo_dat = Ellipse$new(center = c(0.5, 0.5), rmajor = 1.02, rminor = 1, alpha = 0, degrees = TRUE)
geo_dat = geo_dat$path()
geo_dat = as.data.frame(rbind(geo_dat, geo_dat[1, ]))

geoid = readJPEG("images/geoid.jpg")
geoid = abind::abind(geoid, geoid[,,1]) # add an alpha channel
geoid[,,4] = 0.5

pals = palette.colors(8)

gg_geo = ggplot() +
  geom_path(data = geo_dat, aes(x = x, y = y),
            color = pals[1], size = 1.2) +
  geom_vline(xintercept = 0.5, color = pals[1]) +
  geom_hline(yintercept = 0.5, color = pals[1]) +
  annotate(geom = "curve", xend = -0.11, yend = 1.3, x = -0.31, y = 1.4,
           curvature = -0.3, arrow = arrow(length = unit(2, "mm")),
           color = pals[1]) +
  annotate(geom = "text", x = -0.31, y = 1.4,
           label = "Geocentric\ndatum", hjust = "right",
           color = pals[1]) +
  coord_equal(clip = "off") +
  theme_void()

gg_loc = ggplot() +
  geom_path(data = geo_dat, aes(x = x, y = y),
            color = pals[8], linetype = 2, size = 1.2) +
  annotate(geom = "curve", xend = 1.53, yend = 0.5, x = 1.7, y = 0,
           curvature = 0.3, arrow = arrow(length = unit(2, "mm")),
           color = pals[8]) +
  annotate(geom = "text", x = 1.7, y = 0,
           label = "Local\ndatum", hjust = "right",
           color = pals[8]) +
  coord_equal(clip = "off") +
  theme_void()

vp_geo = viewport(0.5, 0.5, width = 0.9 * 1.06, height = 0.9 * 1.06)
vp_loc = viewport(0.53, 0.525, width = 0.9 * 1.06, height = 0.9 * 1.06)

png("figures/02_datum_fig.png", width = 831*3, height = 425*3, res = 300)
grid.newpage()
grid.raster(geoid, interpolate = TRUE, height = 0.9)
print(gg_geo, vp = vp_geo)
print(gg_loc, vp = vp_loc)
dev.off()

# system("optipng figures/02_datum_fig.png")

