r = raster(nrow = 6, ncol = 6, res = 0.5, 
           xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
           vals = 1:36)

grain_size = c("clay", "silt", "sand")
r_2 = raster(nrow = 6, ncol = 6, res = 0.5, 
             xmn = -1.5, xmx = 1.5, ymn = -1.5, ymx = 1.5,
             vals = factor(sample(grain_size, 36, replace = TRUE), 
                           levels = grain_size))