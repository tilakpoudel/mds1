# Read titanic data
library(readr)

setwd("~/projects/tilak/mds1/R-programming")

titanic <- read_csv("data/titanic.csv")

View(titanic)

# data wrangling
data <- titanic[, -3]
str(data)
table(data$Pclass)
# it confirms that pclass is categorical

# Make sure all categorical val
data$Pclass <- as.factor(data$Pclass)
data$Sex <- as.factor(data$Sex)
str(data)

model.full <- glm(Survived ~ ., data = data, family = binomial)
# intercept an first 5 variables are significiant

summary(model.full)


# McFaddens's pseudo R2
(mfpr2 <- 1 - (model.full$deviance / model.full$null.deviance))

exp(coef(model.full))
exp(0.3130)
# 1.404526 > 1 => pClass2 have higher change of survival than Pclass1

# check for multiclinearity
library(car)
vif(model.full)

# vif for all variables are < 2 , so all variables are significiant

# Test accuracy of model
# create confusion matrix
# Prediction
predict<- predict(model.full, type="response")
predcted.fm <- as.numeric(ifelse(predict > 0.5, 1, 0)) 
# Confusion matrix
(cm <- table(predcted.fm, data$Survived))

#  Accuracy , error, sensitivity/ frn and spectificty/ fpr
# Sensitivity, specificitu, Accuracy
(accuracy <- sum(diag(cm)) / sum(cm))

(error <- 1 - accuracy)

(sensitivity <- cm[1,1] / (cm[1,1] + cm[2,1]))
#  model told that the 0.86 

(FNR <- 1 - sensitivity)

(specificity <- cm[2,2] / (cm[2,1] + cm[2,2]))

(FPR <- 1- specificity)

#  accuracy, sensitivity and specificity are improtant for classifier

#  Use caret package to get these

library(caret)
predicted <- factor(ifelse(predict > 0.5, 1, 0))
reference <- factor(data$Survived)

confusionMatrix(predicted, reference)
# We see the accuracy is 0.827 with confidence interval of 95% CI : (0.775, 0.8284)

# so the model is valid

# pROC
library(pROC)
# See slides for plot and check the value of
library(ROCR)

# Now do KNN-classifier and ANN for the titanic data

# Naive Bayes classifier

library(e1071)
# set the seed 
set.seed(120)

ind <- sample(2, nrow(data), replace=T, prob=c(0.7, 0.3))
train.data = data[ind == 1,]
test.data = data[ind == 2,]

# Fitting the model
model.nb <- naiveBayes(Survived~., data=train.data)
model.nb

# Prediction
y_pred <- predict(model.nb, newdata=test.data)

# Confusion data
cm <- table(test.data$Survived, y_pred)
cm 

confusionMatrix(cm)

# The accuracy of Naive bayes is 0.7963, slightly same as that of logistic regression, now see with SVM

# SVM classifier
library(e1071)
model.svm = svm(
  formula= Survived~., 
  data = train.data, 
  type='C-classification', 
  kernel='linear'
)
model.svm

# Prediction

y_pred <- predict(model.svm, newdata=test.data)

# Confusion data
cm <- table(test.data$Survived, y_pred)
cm 

confusionMatrix(cm)

# The accuracy of the model with svm is 0.8037, which seems to be better than logistic and navie bayes. So, choose it.