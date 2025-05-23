# PRESENTSTION 1

# Supervised Learning
# 1. Divide "mtcars" dataset as training data (70% random cases) and testing data (30% random cases) using "sample" in r
# 2. Fit simple linear regression models on training data with mpg as dependent and all other variables as independent variables one by one i.e. separately. Are these models BLUE? Why?
# 3. Identify the statistically significant (p<0.05) independent variables from simple linear regression models as potential candidate variables for the final model and list them for next step
# 4. Fit a multiple linear regression model on training data with mpg as dependent and all the statistically significant variables from simple linear regression models
# 5. Get VIF of all these variables to check multicollinearity and run the final model until none of the variables have VIF >= 10
# 6. Get summary and accuracy indices (R-square, RMSE, MAE) of the final model fitted with variables having VIF < 10
# 7. Use lasso regularization as alternative to deal with multicollinearity, show the results in the PPT and explain them well
# 8. Perform residual analysis on the final model using LINE tests. Can you do prediction using this model? Why?
# 9. Predict the mpg on testing data, get accuracy indices (R-square, RMSE, MAE) of prediction and interpret them carefully
# 10. Prediction: How much mpg is given by a car with 6000 lbs weight based on training and testing data? Which is correct?
# 11. Write a summary based on the results obtained above and include recommendations using data science approach.

# Load the data
library(caret)
library(car)
library(lmtest)

# 1. Load the data and partition it
data = mtcars
str(data)
names(data)
# Set seed for reproducibility
set.seed(39)
# Data partition
ind <- sample(2, nrow(data), replace = T,prob = c(0.7, 0.3))
print(ind)

# Training data
train_data <- data[ind == 1,]
train_data
# Check the partition
table(ind)

# Test data
test_data <- data[ind == 2,]
test_data
# Check the partition
table(ind)

# 2. Fit simple linear regression models on training data with mpg as dependent 
# and all other variables as independent variables one by one i.e. separately. 
# Are these models BLUE? Why?

# Fit simple linear regression models
lm1 <- lm(mpg ~ wt, data = train_data)
summary(lm1)
lm2 <- lm(mpg ~ hp, data = train_data)
summary(lm2)
lm3 <- lm(mpg ~ qsec, data = train_data)
summary(lm3)
lm4 <- lm(mpg ~ drat, data = train_data)
summary(lm4)
lm5 <- lm(mpg ~ disp, data = train_data)
summary(lm5)
lm6 <- lm(mpg ~ cyl, data = train_data)
summary(lm6)
lm7 <- lm(mpg ~ vs, data = train_data)
summary(lm7)
lm8 <- lm(mpg ~ am, data = train_data)
summary(lm8)
lm9 <- lm(mpg ~ carb, data = train_data)
summary(lm9)
lm10 <- lm(mpg ~ gear, data = train_data)
summary(lm10)
summary(lm10)$coefficients[2,4]

# The models are BLUE (Best Linear Unbiased Estimators) if the following assumptions are met:
# 1. Linearity: The relationship between the independent and dependent variables is linear.
# 2. Independence: The residuals (errors) are independent.
# 3. Homoscedasticity: The residuals have constant variance.
# 4. Normality: The residuals are normally distributed.

# We can check these assumptions using diagnostic plots and statistical tests.
# Check the assumptions of linear regression
# LINE TESTS
# 1. Linearity: Check if the relationship between the independent and dependent variables is linear

# Graphical test (suggestive)
plot(lm1, which = 1, col=c("blue")) # Residuals vs Fitted

# Calculation (Confirmative)
summary(lm1)$residuals
# Check if mean of resuduals is zero
mean(summary(lm1)$residuals)
mean(summary(lm2)$residuals)
mean(summary(lm3)$residuals)
mean(summary(lm4)$residuals)
mean(summary(lm5)$residuals)
mean(summary(lm6)$residuals)
mean(summary(lm7)$residuals)
mean(summary(lm8)$residuals)
mean(summary(lm9)$residuals)
mean(summary(lm10)$residuals)

# For lm1, the mean of residuals is not 0, so mpg and wt are not linear

# 2. Independence: Check if the residuals are independent
# Graphical test (suggestive)
acf(lm1$residuals)
acf(lm6$residuals)
# Calculation (Confirmative)
durbinWatsonTest(lm1)
durbinWatsonTest(lm2)

durbinWatsonTest(lm3)
durbinWatsonTest(lm4)
durbinWatsonTest(lm5)
durbinWatsonTest(lm6)

# The Durbin-Watson statistic is between 1.5 and 2.5, so the residuals are independent.

# 3. Homoscedasticity: Check if the residuals have constant variance
# Graphical test (suggestive)
plot(lm1, which=3, col=c("blue"))

# Calculation (Confirmative)
# Breusch-Pagan test
bptest(lm1)

# 4. Normality: Check if the residuals are normally distributed
# Graphical test (suggestive)
plot(lm1, which=2, col=c("blue")) # Normal Q-Q plot

# Shapirt-Wilk test
shapiro.test(lm1$residuals)

# 3. Identify the statistically significant (p<0.05) independent variables

# The variables with p-value < 0.05 are considered statistically significant.
# We can check the p-values of each variable in the summary of the linear models.

# We take the variables with p-value < 0.05
# as potential candidate variables for the final model.
# The statistically significant variables are:
# 1. wt (weight of the car)
# 2. hp (horsepower)
# 3. qsec (1/4 mile time)
# 4. drat (rear axle ratio)
# 5. disp (displacement)
# 6. cyl (number of cylinders)

data
print(data[-1])

results <- lapply(names(data)[-1], function(var) {
  formula <- as.formula(paste("mpg ~", var))
  model <- lm(formula, data = train_data)
  summary(model)$coefficients[2, 4]  # p-value of the predictor
})
print(results)
names(results) <- names(data)[-1]
print(names(results))
sig_vars <- names(results)[unlist(results) < 0.05]
sig_vars
# The significiant variables are:
#  [1] "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear" "carb"

# 4. Fit a multiple linear regression model on training data with mpg as dependent
# and all the statistically significant variables from simple linear regression models
# Fit multiple linear regression model
mlr <- lm(mpg ~ ., data = train_data[, c("mpg", sig_vars)])
summary(mlr)
# The multiple linear regression model is fitted with mpg as dependent variable
# and all the statistically significant variables from simple linear regression models
# as independent variables.

# 5. Get VIF of all these variables to check multicollinearity
# and run the final model until none of the variables have VIF >= 10
# Check VIF
vif(mlr)
# cyl      disp        hp      drat        wt      qsec        vs        am      gear      carb 
# 13.519262 17.823053  9.910916  3.210539 12.573971  7.253988  4.316463  4.310556  5.613880  8.778022 
# The VIF values are greater than 10 for some variables, indicating multicollinearity.
# We can remove the variables with high VIF and refit the model.
# Remove the variable(cycl) with highest VIF
mlr1 <- lm(mpg ~ disp + hp + drat + wt + qsec + vs + am + gear + carb, data = train_data)
summary(mlr1)
vif(mlr1)

# disp        hp      drat        wt      qsec        vs        am      gear      carb 
# 17.274729  9.398860  3.101371 12.468026  6.588897  3.808760  4.151394  5.188897  8.663691
# The VIF values are still greater than 10 for some variables, indicating multicollinearity.
# We can remove the variables with high VIF and refit the model.
# Remove the variable(disp) with highest VIF
mlr2 <- lm(mpg ~ hp + drat + wt + qsec + vs + am + gear + carb, data = train_data)
summary(mlr2)
vif(mlr2)
# hp     drat       wt     qsec       vs       am     gear     carb 
# 4.991686 3.021481 5.344330 5.642614 3.615606 4.119152 5.046875 4.360945 
# There are no amy variable with VIF >= 10, so we can stop here.

# 6. Get summary and accuracy indices (R-square, RMSE, MAE) of the final model fitted with variables having VIF < 10
# Get summary of the final model
summary(mlr2)
# Residual standard error: 2.497 on 16 degrees of freedom
# Multiple R-squared:  0.8781,	Adjusted R-squared:  0.8171 
# F-statistic:  14.4 on 8 and 16 DF,  p-value: 5.716e-06
# The R-squared value is 0.8781, which indicates that the model explains 87.81% 
# of the variance in the dependent variable (mpg).
# The adjusted R-squared value is 0.8171, which indicates that the model explains
# 81.71% of the variance in the dependent variable (mpg) after adjusting for the number of predictors.
# The F-statistic is 14.4, which indicates that the model is statistically significant.
# The p-value is 5.716e-06, which indicates that the model is statistically significant.
# The residual standard error is 2.497, which indicates the average distance
# between the observed and predicted values of the dependent variable (mpg).
# The RMSE is 2.497, which indicates the average distance between the observed 
# and predicted values of the dependent variable (mpg).

# Calculate RMSE
rmse <- sqrt(mean(residuals(mlr2)^2))
print(rmse)
# [1] 1.997334
# Calculate MAE
mae <- mean(abs(residuals(mlr2)))
print(mae)
# [1] 1.610977

# 7. Use lasso regularization as alternative to deal with multicollinearity
# Lasso regularization is a technique used to prevent overfitting in linear regression models
# by adding a penalty term to the loss function.
# The penalty term is the sum of the absolute values of the coefficients multiplied by a tuning parameter (lambda).
# The tuning parameter (lambda) controls the strength of the penalty term.
# The larger the value of lambda, the stronger the penalty term, and the more the coefficients are shrunk towards zero.
# The lasso regularization can be implemented using the glmnet package in R.
# Install and load the glmnet package
install.packages("glmnet")
library(glmnet)
# Prepare the data for lasso regression
x <- model.matrix(mpg ~ ., data = train_data)[, -1]
y <- train_data$mpg
# Fit lasso regression model
lasso_model <- glmnet(x, y, alpha = 1)
# Plot the lasso regression model
plot(lasso_model, xvar = "lambda", label = TRUE)
# The plot shows the coefficients of the lasso regression model as a function of the tuning parameter (lambda).
# The coefficients are shrunk towards zero as the value of lambda increases.
# We can use cross-validation to find the optimal value of lambda.
cv_lasso <- cv.glmnet(x, y, alpha = 1)
# Plot the cross-validation results
plot(cv_lasso)
# The plot shows the mean cross-validated error as a function of the tuning parameter (lambda).
# The optimal value of lambda is the value that minimizes the mean cross-validated error.

# Get the optimal value of lambda
lambda_optimal <- cv_lasso$lambda.min
print(lambda_optimal)
# [1] 0.7044564

# 8. Perform residual analysis on the final model using LINE tests
# Check the assumptions of linear regression
# LINE TESTS
# 1. Linearity: Check if the relationship between the independent and dependent variables is linear
# Graphical test (suggestive)
plot(mlr2, which = 1, col=c("blue")) # Residuals vs Fitted
# Calculation (Confirmative)
summary(mlr2)$residuals
# Check if mean of resuduals is zero
mean(summary(mlr2)$residuals)
# [1] -9.775167e-17
# The mean of residuals is 0, so mpg and other independent variables are linear

# 2. Independence: Check if the residuals are independent
# Graphical test (suggestive)
acf(mlr2$residuals)
# Calculation (Confirmative)
durbinWatsonTest(mlr2)
# lag Autocorrelation D-W Statistic p-value
# 1      0.08511749      1.747558   0.236
# Alternative hypothesis: rho != 0
# The p-value is greater than 0.05, so we fail to reject the null hypothesis
# The residuals are independent.

# 3. Homoscedasticity: Check if the residuals have constant variance
# Graphical test (suggestive)
plot(mlr2, which=3, col=c("blue"))
# Calculation (Confirmative)
# Breusch-Pagan test
bptest(mlr2)
# studentized Breusch-Pagan test
# 
# data:  mlr2
# BP = 16.414, df = 8, p-value = 0.03683
# The p-value is less than 0.05, so we reject the null hypothesis
# The residuals have constant variance.
# 4. Normality: Check if the residuals are normally distributed
# Graphical test (suggestive)
plot(mlr2, which=2, col=c("blue")) # Normal Q-Q plot
# Shapirt-Wilk test
shapiro.test(mlr2$residuals)
# Shapiro-Wilk normality test

# data:  mlr2$residuals
# W = 0.96795, p-value = 0.5935
# The p-value is greater than 0.05, so we fail to reject the null hypothesis
# The residuals are normally distributed.

# 9. Predict the mpg on testing data, get accuracy indices (R-square, RMSE, MAE) of prediction and interpret them carefully
# Predict the mpg on testing data
predictions <- predict(mlr2, newdata = test_data)
# Get accuracy indices
# Calculate R-squared
r_squared <- cor(test_data$mpg, predictions)^2
print(r_squared)
# [1] 0.8225036
# Calculate RMSE
rmse_test <- sqrt(mean((test_data$mpg - predictions)^2))
print(rmse_test)
# [1] 3.426844
# Calculate MAE
mae_test <- mean(abs(test_data$mpg - predictions))
print(mae_test)
# [1] 3.012123
# The R-squared value is 0.8225, which indicates that the model explains 82.25%
# of the variance in the dependent variable (mpg).
# The RMSE is 3.4268, which indicates the average distance between the observed
# and predicted values of the dependent variable (mpg).
# The MAE is 3.0121, which indicates the average distance between the observed
# and predicted values of the dependent variable (mpg).

# 10. Prediction: How much mpg is given by a car with 6000 lbs weight based on training and testing data? Which is correct?
# Predict the mpg for a car with 6000 lbs weight
summary(mlr2)
# weight <- 6000
# predicted_mpg <- predict(mlr2, newdata = data.frame(wt = 6))
# Error in eval(predvars, data, env) : object 'hp' not found
# The error is because the model requires all independent variables to make a prediction.
# We can use the mean values of the other independent variables to make a prediction.
