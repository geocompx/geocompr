library(DiagrammeR)
library(DiagrammeRsvg)
save_png = function(plot, path){
  par(bg = NA)
  DiagrammeRsvg::export_svg(plot) %>%
    charToRaw() %>%
    rsvg::rsvg() %>%
    png::writePNG(path)
}
sf_diagram = grViz("digraph {
                  graph [layout = dot, rankdir = LR]
                  
                  node [shape = rectangle]  
                  rec2 [label = 'sfg']
                  rec4 [label = 'sfc']
                  rec6 [label = 'sf']
                  rec7 [label = 'data.frame']
                  
                  node [shape = diamond]
                  rec1 [label = 'st_point()\nst_linestring()\n...']
                  rec3 [label = 'st_sfc()']
                  rec5 [label = 'st_sf()']
                  
                  # edge definitions with the node IDs
                  rec1 -> rec2 -> rec3 -> rec4 -> rec5 -> rec6
                  rec7 -> rec5
                  }",
                  height = 100)

save_png(sf_diagram, "figures/02-sfdiagram.png")
knitr::plot_crop("figures/02-sfdiagram.png")
