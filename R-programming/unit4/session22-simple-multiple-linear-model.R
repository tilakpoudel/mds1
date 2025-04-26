# Accuracy indices
# 1. MSE
# using residuals of linear model
lm1 <- lm(mpg~wt, data=mtcars)

# see all attributes stored in linear model
names(lm1)

# mean squared error
(mse <- mean(lm1$residuals ^ 2))

# saving predicted values
data <- data.frame(
  pred = predict(lm1), actual=mtcars$mpg
)
head(data)
# 
mean((data$actual - data$pred) ^2)
# The less MSE the better the model is

# 2. R-square, higher is better
# Root mean squared error

# 3. RMSE - Root of MSElower_limit is better)

# 4. MAPE - Mean absolute percentage

# install.packages('caret')
library(caret)

R2 <- R2(data$pred, data$actual)
print(R2)

RMSE <- RMSE(data$pred, data$actual)
print(RMSE)

MAE <- MAE(data$pred, data$actual)
print(MAE)

# Get MAPE in R as:
# 12.60

# Validation and cross-validation for predictive modelling including linear model

# 1 Validation
data <- mtcars

#  use random seed to replicate the result
set.seed(1234)

# DIvide into training and test data
ind <- sample(2, nrow(mtcars), replace = T, prob= c(0.7, 0.3))
print(ind)
# Data partition
train.data <- data[ind == 1,]
test.data <- data[ind == 2,]

# Model fitting
lm4 <- lm(mpg~wt, data = train.data)
summary(lm4)

library(dplyr)
library(caret)
predictions <- lm4 %>%
  predict(test.data)

data.frame(
  R2 = R2(predictions, test.data$mpg),
  RMSE = RMSE(predictions, test.data$mpg),
  MAE = MAE(predictions, test.data$mpg)
)

# We found that the accuracy is 90 % in test data and error is reduced to 2.2793

# Leave one out Cross Validation/ Also called model tuning using LOOCV
library(caret)
# Define training control
train.control <- trainControl(method = "LOOCV")

# Train the model
model1 <- train(
  mpg~wt,
  data = train.data,
  method="lm",
  trControl=train.control
)
summary(model1)


# test on test data
prediction1 <- model1 %>%
  predict(test.data)
data.frame(
  R2 = R2(prediction1, test.data$mpg),
  RMSE = RMSE(prediction1, test.data$mpg),
  MAE = MAE(prediction1, test.data$mpg)
)

#  use k-fold to test the data validation
# library(caret)


# MULTIPLE LINEAR REGRESSION MODEL
# more than 1 independent variable
mlr <- lm(mpg~., data = mtcars)
str(mtcars)
summary(mlr)

install.packages('car')
library(car)
vif(mlr)

#  disp has vif >10 so drop it
mlr1 <- lm(
  mpg~cyl+hp+drat+wt+qsec+vs+am+gear+carb,
  data = mtcars
)
summary(mlr1)

vif(mlr1)

# cyl has vif > 10, so remove cyl

#  cyl has vif >10 so drop it
mlr2 <- lm(
  mpg~hp+drat+wt+qsec+vs+am+gear+carb,
  data = mtcars
)
summary(mlr2)

vif(mlr2)

#  gear has vif >10 so drop it
mlr3 <- lm(
  mpg~hp+drat+wt+qsec+vs+am+carb,
  data = mtcars
)
summary(mlr3)

vif(mlr3)

# We see that wt has low p-value so, better not to buy vechile with higher weight

