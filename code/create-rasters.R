set.seed(2017-12-16)
library("raster")
elev = raster(nrow = 6, ncol = 6, res = 0.5, 
           xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
           vals = 1:36)

grain_size = c("clay", "silt", "sand")
grain = raster(nrow = 6, ncol = 6, res = 0.5, 
               xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
               vals = factor(sample(grain_size, 36, replace = TRUE), 
                             levels = grain_size))