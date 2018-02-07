m_save = world %>% filter(continent != "Antarctica") %>% 
  tm_shape() + 
  tm_polygons() +
  tm_shape(urban_agglomerations) +
  tm_dots(size = "population_millions", title.size = "Population (m)", alpha = 0.5, col = "red") +
  tm_facets(by = "year", nrow = 1, ncol = 1) 
geocompr:::save_print_quality(m = m_save, f = "/tmp/urban-animated-print.png")
animation_tmap(tm = m_save, filename = "/tmp/urban-animated.gif", width = 1200, height = 800)