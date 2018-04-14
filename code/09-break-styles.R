library(tmap)
library(spData)
# breaks = c(0, 3, 4, 5) * 10000
# m_fixed = tm_shape(nz) + tm_polygons(col = "Median_income", style = "fixed", breaks = breaks) +
#   tm_layout(title = 'style = "fixed"', title.size = 0.7)    
# m_sd = tm_shape(nz) + tm_polygons(col = "Median_income", style = "sd") +                       
  # tm_layout(title = 'style = "sd"', title.size = 0.7)
m_equal = tm_shape(nz) + tm_polygons(col = "Median_income", style = "equal") +                 
  tm_layout(title = 'style = "equal"', title.size = 0.7)
m_pretty = tm_shape(nz) + tm_polygons(col = "Median_income", style = "pretty") +               
  tm_layout(title = 'style = "pretty"', title.size = 0.7)        
m_quantile = tm_shape(nz) + tm_polygons(col = "Median_income", style = "quantile") +           
  tm_layout(title = 'style = "quantile"', title.size = 0.7)
# m_kmeans = tm_shape(nz) + tm_polygons(col = "Median_income", style = "kmeans") +               
#   tm_layout(title = 'style = "kmeans"', title.size = 0.7)
# m_hclust = tm_shape(nz) + tm_polygons(col = "Median_income", style = "hclust") +               
#   tm_layout(title = 'style = "hclust"', title.size = 0.7)
# m_bclust = tm_shape(nz) + tm_polygons(col = "Median_income", style = "bclust") +               
#   tm_layout(title = 'style = "bclust"', title.size = 0.7)
# m_fisher = tm_shape(nz) + tm_polygons(col = "Median_income", style = "fisher") +               
#   tm_layout(title = 'style = "fisher"', title.size = 0.7)
m_jenks = tm_shape(nz) + tm_polygons(col = "Median_income", style = "jenks") +                 
  tm_layout(title = 'style = "jenks"', title.size = 0.7)
m_cont = tm_shape(nz_elev) + tm_raster(col = "elevation", style = "cont") +                   
  tm_layout(title = 'style = "cont"', title.size = 0.7)
# m_order = tm_shape(nz) + tm_polygons(col = "Median_income", style = "order") +                 
  # tm_layout(title = 'style = "order"', title.size = 0.7)
m_cat = tm_shape(nz) + tm_polygons(col = "Island", style = "cat") +                  
  tm_layout(title = 'style = "cat"', title.size = 0.7)          
tmap_arrange(m_pretty, m_equal, m_quantile, m_jenks, m_cont, m_cat) 
