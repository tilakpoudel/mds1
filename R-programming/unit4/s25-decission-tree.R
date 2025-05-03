# 
library(readr)
getwd()
setwd("~/projects/tilak/mds1/R-programming")
getwd()

cardiotocographics <- read_csv("data/Cardiotocographic.csv")

data <- cardiotocographics
str(data)

table(data)

#  NSP = Dependent vatriable (response)
#  Three categories of NSP
# NSP = 1, normal cth (No hypoxia or acidosis)
# NSP = 2 = Suspicious CTG (Low probability of hypoxia / acidosis)
# NSP = 3 = Pathological CTG (High probability of hypoxia / acidosis)

data$NSPF <- factor(data$NSP)

str(data$NSPF)

#  Independent vaiables 
# LB: fetal hearth rate
# AC: of accelerations / minute
# FM: of fetal movements / minute

#  Data partition
set.seed(1234)
ind <- sample(2, nrow(data), replace=T, prob=c(0.8, 0.2))
train <- data[ind==1,]
test <-data[ind==2,]

# Party package
install.packages("party")
library(party)

# Fit the decision treel model
tree <- ctree(NSPF~LB+AC+FM, data=train)

tree

plot(tree)

#  For predicting 3 variables we have a tree with 19 nodes ! so it is a over fitting

#  Prunning the tree with 99% confidence interavel and split at 500 samples
tree1 <- ctree(
  NSPF ~ LB+AC+FM, 
  data = train,
  controls=ctree_control(mincriterion = 0.99, minsplit = 500)
)
tree1
plot(tree1)

# It is imporoved model but missed the critical case 

#  Now lets predict
predict(tree, type="prob")

predict(tree1, type="prob")

# Predict the cateogory for each case in test data
predict(tree, test)
predict(tree1, test)

# Create confusion matrix
(tab <- table(predict(tree), train$NSPF))

#  Accuracy
accuracy <- sum(diag(tab))/sum(tab)
accuracy

# Misclassification error
mce <- 1 -accuracy
mce

# Prediction on test data
pred.test <- predict(tree, newdata= test)

# Confusion matrix of test data
(tab1<- table(pred.test, test$NSPF))

#  Accuracy
accuracy1 <- sum(diag(tab1))/ sum(tab1)
accuracy1

#  Misclassification error
mce1 <- 1 - accuracy1
mce1

# Drawbacks of decision tree
# - Suffers from high variance 

#  DECISION TREE IMPROVEMENT
# - Bagging
# - Random Forest
# - Boosting

# - Bagging : Bootstrap aggeration
# Use ipred package for bagging
# 1. BAGGING
library(ipred)
MBTree <- bagging(NSPF~LB+AC+FM, data=train, coob=T)
print(MBTree)

#  Prediction
MBPredict1 <- predict(MBTree, test)
MBPredict1

library(caret)

# Confusion matrix
confusionMatrix(MBPredict1, test$NSPF)

# 2. RANDOM FOREST
library(randomForest)
set.seed(222)
# Fit random forest model
rfm <- randomForest(NSPF~LB+AC+FM, data= train)
print(rfm)

#  use caret to predict
library(caret)
p1 <- predict(rfm, train)
head(p1)

#  see original valies
head(train$NSPF)

#  We can see the error

#  Confusion matrix
confusionMatrix(p1, train$NSPF)
#  Accuracy : 0.8661          
# 95% CI : (0.8491, 0.8819)
mce <- 1- 0.8661
mce
#  training data looks fine, accuracy has increase to 86%

#  see on test data
p2 <- predict(rfm, test)
confusionMatrix(p2, test$NSPF)
# Accuracy : 0.8186          
# 95% CI : (0.7777, 0.8548)
# The accuracy on the test data is 0.8186. But the accuracy of the train data does not fit in the ci, so clearly it is over fitting

plot(rfm)
# we can see that the error is same after 200 samples, soe may be we can use 200

#  TUning the random forest model
train <- as.data.frame(train)
# use tuneRF 
t<- tuneRF(
  train[, -22], 
  train[,22],
  stepFactor = 0.5,
  plot
)

# fined tuned random forest and check OOB error
# Improved  rfm model
rfm1 <- randomForest(
  NSP~LB+AC+FM,
  data= train,
  ntree = 300,
  mtry = 4,
  importance = TRUE,
  proximity = TRUE
)
print(rfm1)

# predict on training data
p1 <- predict(rfm1, train)
head(p1)


# 3. BOOSTING
# Generalized Boositing refression model
library(caret)
mod.gbm <- train(NSP~., data= train, method="gbm", verbose=F)
print(mod.gbm)

# use use 