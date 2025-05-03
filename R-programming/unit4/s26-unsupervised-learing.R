# Unsupervised learning
# Priciplal component analysis
head(USArrests)
# USArrests is a data frame with 50 observations on 4 variables.
str(USArrests)

data <- USArrests
data
#  We combine murder assault and rape and create criminality score

library(dplyr)
USArrests.1 <- USArrests[,-3] %>%
  scale
# Fitting PCA in the new data
pca.1 <- prcomp(USArrests.1)
summary(pca.1)
# Importance of components:
#   PC1    PC2     PC3
# Standard deviation     1.5358 0.6768 0.42822
# Proportion of Variance 0.7862 0.1527 0.06112
# Cumulative Proportion  0.7862 0.9389 1.00000

# We can see SD for PC1 
# We can get eigen value by squaring sd
# 1.53 ^ 2 we get eigen value , if eigen value >=1 take the variable.

#  We can use psych package as well
library(psych)
fa.1 <- psych::principal(USArrests.1, nfactors = 3, rotate = "none")
summary(fa.1)

# We can use varimax to rotate the axis and select the variable with high eigen value (>=1)
fa.2 <- psych::principal(USArrests.1, nfactors = 3, rotate = "varimax")
summary(fa.2)


#2. Multi dimensional Scaling (mDS)
USArrests.1 <- scale(USArrests[,-3])
#  classical MDS with kruskal stress
# we first need distance
#  distance calculationm
state.disimilarity <- dist(USArrests.1)
# MDS fit 
mds.1 <- cmdscale(state.disimilarity)
summary(mds.1)
#  we can see the stress value

# MDS plot
plot(mds.1, pch=19)
abline(h=0, v=0)

#  We can tryuisng sammon's stress
library(MASS)
mds2 <- sammon(state.disimilarity, trace = FALSE)
mds2
plot(mds2$points, pch=19)
abline(h=0, v=0, lty=2)
text(mds2$points, labels = rownames(USArrests.1), cex=0.7, pos=4)
