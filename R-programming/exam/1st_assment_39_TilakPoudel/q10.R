# Load the "igraph" package in R studio and do the basic SNA as follows with R scripts and HTML output:

# a. Define "g1" as graph object with ("R", "S", "S", "T", "T", "R", "R", "T", "U", "S") as its elements.

# Load igraph package
library(igraph)

# Define graph object g with the (1,2) as its elements)
edges <- c(1,2)
g <- graph(edges,
     directed = FALSE
)


plot(g,
     vertex.color = "green",
     vertex.size = 30,
     edge.color = "red",
     edge.width = 5)


# Define the graph object g1 with the given elements
edges <- c("S", "R", "R", "G", "G", "S", "S", "G", "A", "R")
g1 <- graph(edges,
    directed = FALSE
)

# b. Plot "g1" with node color as green, node size as 30, link color as red and link size as 5 and interpret it.

# Plot the graph with specified attributes
plot(g1,
     vertex.color = "green",
     vertex.size = 30,
     edge.color = "red",
     edge.width = 5)
# Interpretation:
# The nodes represent the elements A, R, G, and S.
# The edges represent the connections between these elements.
# The green color and size of the nodes make them easily visible.
# The red color and thickness of the edges highlight the connections between nodes.

# c. Get degree, closeness and betweenness of g1 and interpret them carefully.

# Calculate degree
degree_g1 <- degree(g1)
print("Degree of each node:")
print(degree_g1)

# Calculate closeness
closeness_g1 <- closeness(g1)
print("Closeness of each node:")
print(closeness_g1)

# Calculate betweenness
betweenness_g1 <- betweenness(g1)
print("Betweenness of each node:")
print(betweenness_g1)

# Interpretation:
# Degree:
# The number of edges connected to a node.
# Nodes with higher degrees are more central in the network.
# In this case, we saw that R , S and T have higher degree(same as 3). Hence they are central in this network.
# Closeness:
# The inverse of the average length of the shortest paths from a node to all other nodes in the graph.
# Nodes with higher closeness values are generally more central and can reach other nodes more quickly.
# Here, R and T has higher closeness values.
# Hence, they are more central.
# Betweenness:
# The number of shortest paths that pass through a node.
# Nodes with higher betweenness values play a crucial role as intermediaries in this network.

# d. Get hub and communities of this data and interpret them carefully.

# Calculate hub scores
hub_scores <- hub_score(g1)$vector
print("Hub scores of each node:")
print(hub_scores)

# Detect communities using the edge betweenness algorithm
communities <- edge.betweenness.community(g1)
print("Communities in the graph:")
print(communities)

# Plot the graph with community membership
plot(communities, g1)

