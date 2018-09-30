library(tmap)
library(spData)
library(spDataLarge)

# ?tmap_style_save
tmap_options(title.size = 0.7, title.position = c("right", "bottom"), legend.position = c("LEFT", "TOP"))
m_equal = tm_shape(nz) +
  tm_polygons(col = "Median_income", style = "equal") +
  tm_layout(title = 'style = "equal"')
m_pretty = tm_shape(nz) +
  tm_polygons(col = "Median_income", style = "pretty") +
  tm_layout(title = 'style = "pretty"')        
m_quantile = tm_shape(nz) +
  tm_polygons(col = "Median_income", style = "quantile") +           
  tm_layout(title = 'style = "quantile"')
m_jenks = tm_shape(nz) +
  tm_polygons(col = "Median_income", style = "jenks") +
  tm_layout(title = 'style = "jenks"')
m_cont = tm_shape(nz_elev) +
  tm_raster(col = "elevation", style = "cont", 
            contrast = c(0.2, 1)) +
  tm_layout(title = 'style = "cont"')
m_cat = tm_shape(nz) +
  tm_polygons(col = "Island", style = "cat") + 
  tm_layout(title = 'style = "cat"')          
tmap_arrange(m_pretty, m_equal, m_quantile, m_jenks, m_cont, m_cat) 
suppressMessages(tmap_options_reset())

# additional styles -------------------------------------------------------
# breaks = c(0, 3, 4, 5) * 10000
# m_fixed = tm_shape(nz) +
#   tm_polygons(col = "Median_income", style = "fixed", breaks = breaks) +
#   tm_layout(title = 'style = "fixed"')
# m_sd = tm_shape(nz) +
#   tm_polygons(col = "Median_income", style = "sd") +
#   tm_layout(title = 'style = "sd"')
# m_kmeans = tm_shape(nz) +
#   tm_polygons(col = "Median_income", style = "kmeans") +
#   tm_layout(title = 'style = "kmeans"')
# m_hclust = tm_shape(nz) +
#   tm_polygons(col = "Median_income", style = "hclust") +
#   tm_layout(title = 'style = "hclust"')
# m_bclust = tm_shape(nz) +
#   tm_polygons(col = "Median_income", style = "bclust") +
#   tm_layout(title = 'style = "bclust"')
# m_fisher = tm_shape(nz) +
#   tm_polygons(col = "Median_income", style = "fisher") +
#   tm_layout(title = 'style = "fisher"')
# m_order = tm_shape(nz) +
#   tm_polygons(col = "Median_income", style = "order") +
#   tm_layout(title = 'style = "order"')