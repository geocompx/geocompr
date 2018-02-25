# Aim: create diagram representing sf classes
library(sf)
library(diagram)
sf_classes = getClasses(where = asNamespace("sf"))
n = sf_classes[grepl(pattern = "sfc_", sf_classes)]
n = gsub(pattern = "sfc_", replacement = "", n)
n = gsub(pattern = "GEOMETRY", replacement = "GEOMETRY COLLECTION", n)
n = sort(n)[c(1, 4, 3, 5, 6, 2, 7)]

# see https://davetang.org/muse/2017/03/31/creating-flowchart-using-r/
png(filename = "figures/sf-classes.png", width = 600, height = 500)
# openplotmat()
pos = coordinates(c(1, 3, 3))
plot(pos, type = 'n')
text(pos)
par(mar = rep(1, 4))
openplotmat()
straightarrow(from = pos[5, ], to = pos[2, ])
straightarrow(from = pos[5, ], to = pos[1, ])
straightarrow(from = pos[6, ], to = pos[3, ])
straightarrow(from = pos[7, ], to = pos[4, ])
straightarrow(from = pos[7, ], to = pos[1, ])
straightarrow(from = pos[2, ], to = pos[1, ])
straightarrow(from = pos[3, ], to = pos[1, ])
straightarrow(from = pos[4, ], to = pos[1, ])
for(i in seq_along(n))
  textrect(mid = pos[i,], radx = 0.14, rady = 0.05, lab = n[i])
i = 1
textrect(mid = pos[i,], radx = 0.18, rady = 0.05, lab = n[i])
dev.off()

## attempt with DiagrammR -----
# nodes = create_node_df(n = length(n), label = n, shape = "rectangle", width = 3, )
# graph_attrs = c("layout = circo",
#                  "overlap = false",
#                  "fixedsize = true",
#                  "ranksep = 3",
#                  "outputorder = edgesfirst")
# edges = create_edge_df(from = c(1, 2, 3, 4, 5, 6),
#                        to = c(4, 5, 6, 7, 7, 7))
# g = create_graph(nodes_df = nodes, edges_df = edges)
# 
# render_graph(g, layout = "forceDirected")
# export_graph(g,file_name = "f.gexf", file_type = "gexf")
