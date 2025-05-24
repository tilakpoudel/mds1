set.seed(39)

# Generate the data
data <- data.frame(
  X1 = rnorm(500, mean = 10, sd = 2),
  X2 = runif(500, min = 0, max = 100),
  X3 = rnorm(500, mean = 50, sd = 10),
  X4 = runif(500, min = 2, max=8),
  X5 = sample(1:3, 500, replace = TRUE)
)

# View first few rows
head(data)

print(dim(data))

# HCA (Hierarchical Cluster Analysis)

data <- scale(data)  # Scale is required if we have factor data like X5 here.
# data <- (data[, 1:4])  # No need to scale if we donot have factor

### Hiererchical clustering with single linkage

data.similarity <- dist(data)
hirar.1 <- hclust(data.similarity, method='single')
hirar.1

# Plot 
plot(
  hirar.1,
  labels=rownames(data),
  ylab="Distance"
)


### Hiererchical clustering with complete linkage

hirar.2 <- hclust(data.similarity, method='complete')
hirar.2

# Plot 
plot(
  hirar.2,
  labels=rownames(data),
  ylab="Distance"
)

abline(h = 90, col = 'red')

### Hiererchical clustering with average linkage

hirar.3 <- hclust(data.similarity, method='average')
hirar.3

# Plot 
plot(
  hirar.3,
  labels=rownames(data),
  ylab="Distance"
)

### Hiererchical clustering with centroid linkage
hirar.4 <- hclust(data.similarity, method='centroid')
hirar.4

# Plot 
plot(
  hirar.4,
  labels=rownames(data),
  ylab="Distance"
)

# Fit the model: Clustering(K-mean)

set.seed(39)
kmeans_model <- kmeans(data, centers=2, nstart = 20)
kmeans_model

# check with k = 3
kmeans_model1 <- kmeans(data, centers=3, nstart = 20)
kmeans_model1

## Plot the clusters

summary(data)
library(cluster)

# Reduce data to 2D with PCA for visualization.
# Since we have 5 variables it is not possible to visualize
pca_result <- prcomp(data, scale = FALSE)
pca_data <- pca_result$x[, 1:2]  # first two PCs

# Plot cluster
plot(
  pca_data, 
  col = kmeans_model$cluster, 
  main = "K-means Clustering (k = 2) on PCA-reduced Data", 
  xlab = "PC1", 
  ylab = "PC2", 
  pch = 20, 
  cex = 2
)

# Add cluster centers
points(
  aggregate(pca_data, by = list(kmeans_model$cluster), FUN = mean)[, 2:3],
  col = 1:3,
  pch = 8,
  cex = 3,
  lwd = 2
)

# Cusplot
clusplot(
  data, 
  kmeans_model$cluster, 
  color = TRUE, 
  shade = TRUE, 
  labels = 2, s
  lines = 0, 
  main = "Clusplot of K-means Clustering (k = 2)"
)

## Evaluate with WSS and silhoutte

kmeans_model$tot.withinss
kmeans_model$betweenss / kmeans_model$totss * 100

# Silhouette
library(cluster)
sil <- silhouette(kmeans_model$cluster, dist(data))
mean(sil[, 3])  # Average silhouette width
