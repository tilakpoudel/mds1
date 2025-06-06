# Use the first four variables "iris" data and do as follows in the R Studio with R script:

# Load the required libraries
library(datasets)
library(cluster)
library(ggplot2)
library(dendextend)
library(caret)

# Load the iris dataset
data(iris)
head(iris)

# Use the first four variables for clustering
iris_data <- iris[, 1:4]

# a. Fit a hierarchical clustering model using average linkage and get the dendogram for this model.

hc <- hclust(dist(iris_data),
             method = "average")
plot(hc,
     main = "Dendrogram of Iris Data",
     xlab = "",
     sub = "",
     cex = 0.9)

# b. Get the best value of number of clusters to form (k) using the fitted model above.

# We can use the cutree function and visualize the dendrogram with clusters
rect.hclust(hc,
            k = 3,
            border = "red")

# We found the optimal number of clusters to be 3
optimal_clusters <- 3

# c. Fit the k-means clustering with the best value of k identified above and interpret it carefully.

set.seed(35)
kmeans_model <- kmeans(iris_data,
                       centers = optimal_clusters,
                       nstart = 25)
kmeans_model

# Add the cluster assignments to the original data
iris$Cluster <- as.factor(kmeans_model$cluster)

# Visualize the k-means clustering results
pairs(iris_data,
      col = iris$Cluster,
      main = "K-means Clustering Results")

# d. Compare k-means result with the last variable of this data using confusion matrix and interpret the result carefully.

# Create a table to see the correspondence between clusters and actual species
cluster_species_table <- table(iris$Cluster,
                               iris$Species)
print(cluster_species_table)

# Find the mapping from clusters to species
map <- apply(cluster_species_table,
             1,
             function(x) names(which.max(x)))

# Map the clusters to species
predicted_species <- map[as.numeric(iris$Cluster)]

# Create a factor with the same levels as the actual species
predicted_species <- factor(predicted_species,
                            levels = levels(iris$Species))

# Calculate the confusion matrix
confusion_matrix <- confusionMatrix(predicted_species,
                                    iris$Species)
print(confusion_matrix)

# Interpretation
# The confusion matrix shows how the clusters identified by k-means correspond to the actual species.
# We can interpret the clustering accuracy and any misclassifications observed.