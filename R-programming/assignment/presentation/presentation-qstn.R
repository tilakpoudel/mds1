# a) code used to generate 500 random data with five variables where one of the variables must be defined as binary factor (0 and 1) dependent variable for Roll 1-10 models and categorical factor (1, 2 and 3) dependent variable for Roll 11-20 models
# b) code used to fix the random data with random seed i.e. your roll number 
# c) code used to fit the assigned supervised classification and unsupervised statistical models 
# d) codes used to get model accuracy indices and 
# e) interpretations of the outputs from these codes
# 
# Assigned models:
#   
# 1. Roll 1-10: Fitting Logistic regression and KNN classification models with binary dependent variable and comparison of the model assumptions and accuracy indices to select the best model for the data based on training and testing datasets
# 2. Roll 11-20: Fitting Decision Tree and Random Forest classification models with categorical dependent variable and comparison of the model assumptions and accuracy indices to select the best model for the data based on training and testing datasets
# 3. Roll 21-30: Fitting dimension (variables) reduction techniques i.e. PCA and MDS and selecting the best model for this data with careful interpretations of the bi-plots
# 4. Roll 31-40: Fitting dimension (cases) reduction techniques i.e. HCA and k-means and selecting the best model for this data with careful interpretations of the cluster plots

# Load necessary libraries
library(cluster)
library(ggplot2)
# install.packages('factoextra')
library(factoextra)
# Set seed for reproducibility
set.seed(39)
# Generate random data with five variables

# I want the first 4 variables of different distributions and the last variable as a binary factor
data <- data.frame(
  var1 = rnorm(500, mean = 50, sd = 10),  # Normal distribution
  var2 = runif(500, min = 20, max = 80),  # Uniform distribution
  var3 = rpois(500, lambda = 30),          # Poisson distribution
  var4 = rexp(500, rate = 0.1),            # Exponential distribution
  binary_var = sample(0:1, 500, replace = TRUE) # Binary factor
)

# View first few rows of the data
head(data)
# Print dimensions of the data
print(dim(data))

# 1. Roll 1-10: Fitting Logistic regression and KNN classification models with binary dependent variable and comparison of the model assumptions and accuracy indices to select the best model for the data based on training and testing datasets
# Load necessary libraries for classification
library(caret)
library(class)

# Fitting logistic regression model
logistic_model <- glm(binary_var ~ ., data = data, family = binomial)
# Summary of the logistic regression model
summary(logistic_model)
# Predicting probabilities using the logistic regression model
predicted_probs <- predict(logistic_model, type = "response")
# Converting probabilities to binary predictions
predicted_classes <- ifelse(predicted_probs > 0.5, 1, 0)
# Confusion matrix for logistic regression
confusion_matrix_logistic <- table(data$binary_var, predicted_classes)
# Accuracy for logistic regression
accuracy_logistic <- sum(diag(confusion_matrix_logistic)) / sum(confusion_matrix_logistic)
# Print accuracy for logistic regression
print(paste("Accuracy of Logistic Regression:", round(accuracy_logistic, 4)))

# use package to get the confusion matrix and accuracy.
library(caret)
confusion_matrix_logistic <- confusionMatrix(as.factor(predicted_classes), as.factor(data$binary_var))
# Print confusion matrix and accuracy for logistic regression
print(confusion_matrix_logistic)



# Fitting KNN classification model