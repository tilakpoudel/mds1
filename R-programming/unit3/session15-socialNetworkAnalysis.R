# social network analysis
install.packages('igraph')

library(igraph)

g <- graph(c(1,2))
plot(g)

# First node contains 1, second contains 2, by default directed graph

plot(g,
     vertex.color = "green",
     vertex.size = 40,
     edge.color = "red",
     edge.size = 20
)

# closed directed graph
g <- graph(c(1,2,2,3,3,4,4,1))

plot(g,
     vertex.color = "green",
     vertex.size = 40,
     edge.color = "red",
     edge.size = 20
)

# closed undirected graph eg. like following
g <- graph(
  c(1,2,2,3,3,4,4,1),
  directed = F
)

plot(g,
     vertex.color = "green",
     vertex.size = 40,
     edge.color = "red",
     edge.size = 20
)

# closed undirected graph eg. like following
g <- graph(
  c(1,2,2,3,3,4,4,1),
  directed = F,
  n=7
)

plot(g,
     vertex.color = "green",
     vertex.size = 40,
     edge.color = "red",
     edge.size = 20
)

# 7 x 7 sparse Matrix of class "dgCMatrix"
print(g[])

g1 <- graph(
  c("Sita", "Ram", "Ram", "Rita", "Rita", "Sita", "Sita", "Rita", "Anju", "Ram")
)

plot(g1,
     vertex.color = "green",
     vertex.size = 40,
     edge.color = "red",
     edge.size = 1
)

print(g1)

# see the metrics
degree(g1)
degree(g1, mode = "all")

# how many nodes are comming to the node
degree(g1, mode = "in")
# Sita  Ram Rita Anju 
# 1    2    2    0 
# nodes going out of the node
degree(g1, mode="out")
# Sita  Ram Rita Anju 
# 2    1    1    1 

#degree = numnber nodes connected

# diameter
diameter(g1, directed = F, weights = NA)

# edge density, the extent to which nodes are inter connected
edge_density(g1, loops=F)

ecount(g1)/(vcount(g1) * (vcount(g1) - 1)) 
# 5/4 * (4-1)
# [1] 0.4166667

# Interpretation of density: no of connections / total no of person

# Reciprocity : percent reciprocatted ties
reciprocity(g1)

# Total edges = 5
# Tied edges = 2
# reciprocity = 2/5 = 0.4
# Intepretation: 0.4 total no of connections / total no of ties

# closeness
closeness(g1, mode = "all", weights = NA)
# Sita       Ram      Rita      Anju 
# 0.2500000 0.3333333 0.2500000 0.2000000 

# Interpretation: Ram is closest to other 3 persons
# Anju is farthest to other 3 persons

# Betweeness
betweenness(g1, directed = T, weights = NA)
# Sita  Ram Rita Anju 
# 1    2    2    0 

# Interpretation: Ram and rita have two inner edges . sita has 1 and anju has 0

# edge_betweeness
edge_betweenness(g1, directed = T, weights = NA)
# 2 4 4 1 3

?igraph
?edge_betweenness


# TODO : SNA from youTube 0xM0MbRPGE