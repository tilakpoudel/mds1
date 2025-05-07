# install.packages("ClusterR")
# install.packages("cluster")
# install.packages("arules")
# install.packages("arulesViz")

# library(ClusterR)
set.seed(39)
# 50 observations with 2 columns
x <- matrix(rnorm(50*2), ncol=2)
x[1:25, 1] <- x[1:25, 1] + 3
x[1:25, 2] <- x[1:25, 2] - 4

# k-means clustering
# default nstart=20, telling start with 20 points from start
km.out <- kmeans(x, 2, nstart=20)

km.out2 <- kmeans(x, 3, nstart=20)

# check the variance
km.out
km.out2

# checking the clusters
km.out$cluster

# Start with HCL , Hierarchical clustering to idenitfy the number of clusters and then

# PLot
plot(
  x, 
  col=(km.out2$cluster +1), 
  main = "K-mean clustering results with k = 2", 
  xlab = "",
  ylab = "",
  pch=20, 
  cex=2
)

# never use k = 1, although it gives high varince

#  (between_SS / total_SS =  84.4 %) => it is variance, take high variance value

km.out$tot.withinss
km.out2$tot.withinss

# WORK WITH IRIS DATA
# install.packages("ClusterR")
# install.packages("gmp")
library(ClusterR)
library(cluster)

# Get check and make data
data(iris)
str(iris)
iris_1 <- iris[, -5]

# Fit k-mean
set.seed(39)

kmeans.res <- kmeans(
  iris_1, 
  centers = 3, 
  nstart = 20
)
kmeans.res
# between_SS / total_SS =  88.4 %) variance >80 is considered good

# confusion matrix, not needed for unsupervised learning, only done here as we have the output lanels this is not recommended
#  how do we know that cluster 1,2,3 are corresponding labels in original data?
cm<-table(iris$Species, kmeans.res$cluster)
cm

# Accuracy
(accuracy <- sum(diag(cm)) / sum(cm))

(mce <- 1 - accuracy)

# Adding cluster centers
# Visualizing cluster, it is mandaroty graph must be included
y_kmeans <- kmeans.res$cluster
library(cluster)
clusplot(
  iris_1[, c("Sepal.Length", "Sepal.Width")],
  y_kmeans,
  lines=0,
  shade = TRUE,
  color= TRUE,
  labels=2,
  plotchar = FALSE,
  span= TRUE,
  main=paste("Cluster iris"),
  xlab='Sepal.Length',
  ylab='Sepal.Width'
)

# Note: the plot in x and y has value -2 to 2 . it is because the values are normalized


## HCA , Hierarchical cluster Analysis
# Disadvantage of k-mean, we need to know the value of k before hand,
# HCA is used to find the appropriate k value

# Hierarchical clustering with single linkage
# Others are complete and cebtroid and find the variance 
# USArrests data
USArrests.1 <- USArrests[, -3]
state.disimilarity <- dist(USArrests.1)
hirar.1 <- hclust(state.disimilarity, method = 'single')
hirar.1
plot(
  hirar.1, 
  labels = rownames(USArrests.1), 
  ylab="Distance"
)
# Florida and north carolina, these tow states are very near
# Observing the graph, We can take 4 groups cutting at distance of 20-30

# Method complete
hirar.2 <- hclust(state.disimilarity, method = 'complete')

plot(
  hirar.2, 
  labels = rownames(USArrests.1), 
  ylab="Distance"
)

hirar.2

# Method centroid
hirar.3 <- hclust(state.disimilarity, method = 'centroid')

plot(
  hirar.3, 
  labels = rownames(USArrests.1), 
  ylab="Distance"
)

hirar.3

# First do, HCS, 
# Find k clusters
# Find the variance
