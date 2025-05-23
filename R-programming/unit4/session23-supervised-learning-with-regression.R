# Load the data
library(caret)
boston = MASS::Boston
str(boston)

# Data partition
set.seed(123)
ind <-sample(
  2,
  nrow(boston),
  replace = T,
  prob = c(0.8, 0.2)
)
train.data = boston[ind == 1,]
test.data = boston[ind == 2,]

# Training data scaling (must for KNN)
train_x = train.data[, -14]
train_x = scale(train_x)[,]
train_y = train.data[, 14]

# Test validation data scaling
test_x = test.data[, -14]
test_x = scale(test.data[, -14])[,]
test_y = test.data[, 14]

# KNN regression, struture, predition
knnmodel = knnreg(train_x, train_y)
str(knnmodel)
summary(knnmodel)
# Prediction
pred_y = predict(knnmodel, data.frame(test_x))

# print accuracy indices
print(data.frame(test_y, pred_y))

mse = mean((test_y - pred_y) ^ 2)
print(mse)
mae = caret::MAE(test_y, pred_y)
print(mae)
rmse = caret::RMSE(test_y, pred_y)
print(rmse)

cat("MSE:", mse, "MAE:", mae, "RMSE:", rmse, "\n")

# Plot
plot(
  test_y,
  pred_y,
  col = "blue",
  pch = 19,
  xlab = "Index",
  ylab = "Value",
  main = "KNN Regression"
)
abline(0, 1, col = "red", lwd = 2)

# x = 1:length(test_y)
# plot(x, test_y, col = "blue", type="l", lwd=2,
#      xlab = "Index", ylab = "Value",
#      main = "KNN Regression")

