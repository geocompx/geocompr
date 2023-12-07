library(tmap)
library(spData)
library(spDataLarge)

# ?tmap_style_save
m_equal = tm_shape(nz) +
  tm_polygons(fill = "Median_income", fill.scale = tm_scale_intervals(style = "equal")) +
  tm_title('style = "equal"') +
  tm_layout(legend.position = tm_pos_auto_in(), title.position = tm_pos_in("right", "bottom"), scale = 0.8, 
  inner.margins = c(0.15, 0.35, 0.02, 0.02))
m_pretty = tm_shape(nz) +
  tm_polygons(fill = "Median_income", fill.scale = tm_scale_intervals(style = "pretty")) +
  tm_title('style = "pretty"')+
  tm_layout(legend.position = tm_pos_auto_in(), title.position = tm_pos_in("right", "bottom"), scale = 0.8, 
  inner.margins = c(0.15, 0.35, 0.02, 0.02))    
m_quantile = tm_shape(nz) +
  tm_polygons(fill = "Median_income", fill.scale = tm_scale_intervals(style = "quantile")) +           
  tm_title('style = "quantile"')+
  tm_layout(legend.position = tm_pos_auto_in(), title.position = tm_pos_in("right", "bottom"), scale = 0.8, 
  inner.margins = c(0.15, 0.35, 0.02, 0.02))
m_jenks = tm_shape(nz) +
  tm_polygons(fill = "Median_income", fill.scale = tm_scale_intervals(style = "jenks")) +
  tm_title('style = "jenks"')+
  tm_layout(legend.position = tm_pos_auto_in(), title.position = tm_pos_in("right", "bottom"), scale = 0.8, 
  inner.margins = c(0.15, 0.35, 0.02, 0.02))
m_log10 = tm_shape(nz) +
  tm_polygons(fill = "Population", fill.scale = tm_scale_intervals(style = "log10_pretty", values = "bu_pu")) +
  tm_title('style = "log10_pretty"')+
  tm_layout(legend.position = tm_pos_auto_in(), title.position = tm_pos_in("right", "bottom"), scale = 0.8, 
  inner.margins = c(0.15, 0.35, 0.02, 0.02))

tmap_arrange(m_pretty, m_equal, m_quantile, m_jenks, m_log10, nrow = 2) 
