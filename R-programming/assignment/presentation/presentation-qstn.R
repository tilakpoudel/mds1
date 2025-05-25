# a) code used to generate 500 random data with five variables where one of the variables must be defined as binary factor (0 and 1) dependent variable for Roll 1-10 models and categorical factor (1, 2 and 3) dependent variable for Roll 11-20 models
# b) code used to fix the random data with random seed i.e. your roll number 
# c) code used to fit the assigned supervised classification and unsupervised statistical models 
# d) codes used to get model accuracy indices and 
# e) interpretations of the outputs from these codes
# 
# Assigned models:
#   
# 1. Roll 1-10: Fitting Logistic regression and KNN classification models with binary dependent variable and 
# comparison of the model assumptions and accuracy indices to 
# select the best model for the data based on training and testing datasets

# 2. Roll 11-20: Fitting Decision Tree and Random Forest classification models 
# with categorical dependent variable and comparison of the model assumptions and accuracy 
# indices to select the best model for the data based on training and testing datasets

# 3. Roll 21-30: Fitting dimension (variables) reduction techniques i.e. PCA and MDS 
# and selecting the best model for this data with careful interpretations of the bi-plots

# 4. Roll 31-40: Fitting dimension (cases) reduction techniques i.e. HCA and k-means 
# and selecting the best model for this data with careful interpretations of the cluster plots

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

# 1. Roll 1-10: Fitting Logistic regression and KNN classification models with 
# binary dependent variable and comparison of the model assumptions and accuracy indices to 
# select the best model for the data based on training and testing datasets
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
# use caret package to get the confusion matrix and accuracy.
confusion_matrix_logistic <- confusionMatrix(as.factor(predicted_classes), as.factor(data$binary_var))
# Print confusion matrix and accuracy for logistic regression
print(confusion_matrix_logistic)

# split the data into training and testing sets
set.seed(39)  # Ensure reproducibility
train_index <- sample(1:nrow(data), 0.7 * nrow(data))  # 70% for training
train_data <- data[train_index, ]
test_data <- data[-train_index, ]  # 30% for testing


# Fitting logistic model on training data
logistic_model_train <- glm(binary_var ~ ., data = train_data, family = binomial)
# Predicting on test data
predicted_probs_test <- predict(logistic_model_train, newdata = test_data, type = "response")
# Converting probabilities to binary predictions for test data
predicted_classes_test <- ifelse(predicted_probs_test > 0.5, 1, 0)
# Confusion matrix for logistic regression on test data
confusion_matrix_logistic_test <- confusionMatrix(as.factor(predicted_classes_test), as.factor(test_data$binary_var))
# Print confusion matrix and accuracy for logistic regression on test data
print(confusion_matrix_logistic_test)

# Fitting logistic model in test data
logistic_model_test <- glm(binary_var ~ ., data = test_data, family = binomial)
# Summary of the logistic regression model on test data
summary(logistic_model_test)
# Predicting probabilities using the logistic regression model on test data
predicted_probs_test <- predict(logistic_model_test, type = "response")
# Converting probabilities to binary predictions for test data
predicted_classes_test <- ifelse(predicted_probs_test > 0.5, 1, 0)
# Confusion matrix for logistic regression on test data
confusion_matrix_logistic_test <- confusionMatrix(as.factor(predicted_classes_test), as.factor(test_data$binary_var))
# Print confusion matrix and accuracy for logistic regression on test data
print(confusion_matrix_logistic_test)


# Fitting KNN classification model
# Normalize the data for KNN
normalize_data <- function(df) {
  return(as.data.frame(scale(df)))
}
normalized_data <- normalize_data(data[, -ncol(data)])  # Exclude the binary variable for normalization
# Add the binary variable back to the normalized data
normalized_data$binary_var <- data$binary_var
# Split the normalized data into training and testing sets
train_index_knn <- sample(1:nrow(normalized_data), 0.7 * nrow(normalized_data))  # 70% for training
train_data_knn <- normalized_data[train_index_knn, ]
test_data_knn <- normalized_data[-train_index_knn, ]  # 30% for testing
# Fitting KNN model
k_value <- 5  # Set the number of neighbors
knn_model <- knn(train = train_data_knn[, -ncol(train_data_knn)], 
                 test = test_data_knn[, -ncol(test_data_knn)], 
                 cl = train_data_knn$binary_var, 
                 k = k_value)
# Confusion matrix for KNN model
confusion_matrix_knn <- confusionMatrix(as.factor(knn_model), as.factor(test_data_knn$binary_var))
# Print confusion matrix and accuracy for KNN model
print(confusion_matrix_knn)
# Compare the accuracy of logistic regression and KNN models
logistic_accuracy <- confusion_matrix_logistic_test$overall['Accuracy']
knn_accuracy <- confusion_matrix_knn$overall['Accuracy']

# Print accuracies
print(paste("Logistic Regression Accuracy:", logistic_accuracy))
print(paste("KNN Accuracy:", knn_accuracy))


# Interpretations of the outputs from these codes
# > print(paste("Logistic Regression Accuracy:", logistic_accuracy))
# [1] "Logistic Regression Accuracy: 0.6"
# > print(paste("KNN Accuracy:", knn_accuracy))
# [1] "KNN Accuracy: 0.513333333333333"

# The accuracies indicate that the logistic regression model has an accuracy of 0.6, 
# while the KNN model has an accuracy of approximately 0.51.
# The logistic regression model seems to perform better than the KNN model in this case.

# I want both the ROC in one plot
plot(roc_logistic, main = "ROC Curves for Logistic Regression and KNN", col = "blue")
plot(roc_knn, add = TRUE, col = "red")
# Add AUC for both models
text(0.5, 0.5, paste("AUC Logistic:", round(auc_logistic, 2)), col = "blue")
text(0.5, 0.4, paste("AUC KNN:", round(auc_knn, 2)), col = "red")
# The ROC curves and AUC values provide a visual and quantitative measure of the model's performance.
# The logistic regression model has a higher AUC (0.53), indicating better performance compared to the KNN model (0.47).
# The logistic regression model is preferred based on accuracy and AUC values.


# 2. Roll 11-20: Fitting Decision Tree and Random Forest classification models with
# categorical dependent variable and comparison of the model assumptions and accuracy
# indices to select the best model for the data based on training and testing datasets

# Load necessary libraries for classification
library(rpart)
library(randomForest)
# Generate random data with five variables and a categorical dependent variable
# I want the first 4 variables of different distributions and the last variable as a categorical factor
data_cat <- data.frame(
  var1 = rnorm(500, mean = 50, sd = 10),  # Normal distribution
  var2 = runif(500, min = 20, max = 80),  # Uniform distribution
  var3 = rpois(500, lambda = 30),          # Poisson distribution
  var4 = rexp(500, rate = 0.1),            # Exponential distribution
  categorical_var = sample(1:3, 500, replace = TRUE) # Categorical factor with three levels
)
# View first few rows of the data
head(data_cat)
# Print dimensions of the data
print(dim(data_cat))
# Split the data into training and testing sets
set.seed(39)  # Ensure reproducibility
train_index_cat <- sample(1:nrow(data_cat), 0.7 * nrow(data_cat))  # 70% for training
train_data_cat <- data_cat[train_index_cat, ]
test_data_cat <- data_cat[-train_index_cat, ]  # 30% for testing
# Fitting Decision Tree model
decision_tree_model <- rpart(categorical_var ~ ., data = train_data_cat, method = "class")
# Summary of the Decision Tree model
summary(decision_tree_model)
# Predicting on test data using Decision Tree model
predicted_classes_tree <- predict(decision_tree_model, newdata = test_data_cat, type = "class")
# Confusion matrix for Decision Tree model
confusion_matrix_tree <- confusionMatrix(as.factor(predicted_classes_tree), as.factor(test_data_cat$categorical_var))
# Print confusion matrix and accuracy for Decision Tree model
print(confusion_matrix_tree)

# Plot the Decision Tree and do purning if necessary
library(rpart.plot)
rpart.plot(decision_tree_model, main = "Decision Tree for Categorical Variable", extra = "auto", fallen.leaves = TRUE)

# Prunning the Decision Tree
# Prune the tree to avoid overfitting
pruned_tree <- prune(decision_tree_model, cp = 0.015)  # Adjust cp value as needed
# Plot the pruned Decision Tree
rpart.plot(pruned_tree, main = "Pruned Decision Tree for Categorical Variable", extra = "auto", fallen.leaves = TRUE)

# Predicting on test data using the pruned Decision Tree model
predicted_classes_tree_pruned <- predict(pruned_tree, newdata = test_data_cat, type = "class")
# Confusion matrix for pruned Decision Tree model
confusion_matrix_tree_pruned <- confusionMatrix(as.factor(predicted_classes_tree_pruned), as.factor(test_data_cat$categorical_var))
# Print confusion matrix and accuracy for pruned Decision Tree model
print(confusion_matrix_tree_pruned)

# Predict on training data to test over fitting
predicted_classes_tree_train <- predict(decision_tree_model, newdata = train_data_cat, type = "class")
# Confusion matrix for Decision Tree model on training data
confusion_matrix_tree_train <- confusionMatrix(as.factor(predicted_classes_tree_train), as.factor(train_data_cat$categorical_var))
# Print confusion matrix and accuracy for Decision Tree model on training data
print(confusion_matrix_tree_train)

# Ensure categorical_var is a factor for classification
train_data_cat$categorical_var <- as.factor(train_data_cat$categorical_var)
test_data_cat$categorical_var <- as.factor(test_data_cat$categorical_var)

# Fitting Random Forest model first on train data
random_forest_model <- randomForest(categorical_var ~ ., data = train_data_cat, ntree = 100)
# get the summary of the Random Forest model
summary(random_forest_model)
# Predicting on test data using Random Forest model
predicted_classes_rf <- predict(random_forest_model, newdata = test_data_cat)
# Confusion matrix for Random Forest model
confusion_matrix_rf <- confusionMatrix(as.factor(predicted_classes_rf), as.factor(test_data_cat$categorical_var))
# Print confusion matrix and accuracy for Random Forest model
print(confusion_matrix_rf)
# Predict on training data to test over fitting
predicted_classes_rf_train <- predict(random_forest_model, newdata = train_data_cat)
# Confusion matrix for Random Forest model on training data
confusion_matrix_rf_train <- confusionMatrix(as.factor(predicted_classes_rf_train), as.factor(train_data_cat$categorical_var))
# Print confusion matrix and accuracy for Random Forest model on training data
print(confusion_matrix_rf_train)

# Use error plot to determine the optimal number of trees for random forest
plot(random_forest_model, main = "Error Rate vs Number of Trees for Random Forest Model")


# Plot ROC curves for Decision Tree and Random Forest models
library(pROC)
roc_tree <- roc(test_data_cat$categorical_var, as.numeric(predicted_classes_tree_pruned))
roc_rf <- roc(test_data_cat$categorical_var, as.numeric(predicted_classes_rf))
# Plot ROC curves
plot(roc_tree, main = "ROC Curves for Decision Tree and Random Forest", col = "blue")
plot(roc_rf, add = TRUE, col = "red")
# Calculate AUC for both models
auc_tree <- auc(roc_tree)
auc_rf <- auc(roc_rf)
# Add AUC for both models
text(0.5, 0.5, paste("AUC Decision Tree:", round(auc_tree, 2)), col = "blue")
text(0.5, 0.4, paste("AUC Random Forest:", round(auc_rf, 2)), col = "red")

# The AUC value of Decision Tree model is approximately 0.5, while the AUC value of Random Forest model is approximately 0.51.

# Compare the accuracy of Decision Tree and Random Forest models
decision_tree_accuracy <- confusion_matrix_tree_pruned$overall['Accuracy']
random_forest_accuracy <- confusion_matrix_rf$overall['Accuracy']
# Print accuracies along with the confidence intervals
print(paste("Decision Tree Accuracy:", decision_tree_accuracy))
# Accuracy : 0.3267          
# 95% CI : (0.2524, 0.4079)

print(paste("Random Forest Accuracy:", random_forest_accuracy))
# Accuracy : 0.3133          
# 95% CI : (0.2402, 0.3941)

# Interpretations of the outputs from these codes
# The accuracies indicate that the Decision Tree model has an accuracy of approximately 0.33,
# while the Random Forest model has an accuracy of approximately 0.31.
# The Decision Tree model seems to perform slightly better than the Random Forest model in this case.






# 3. Roll 21-30: Fitting dimension (variables) reduction techniques i.e. PCA and MDS
# and selecting the best model for this data with careful interpretations of the bi-plots
# Load necessary libraries for dimension reduction
library(ggplot2)
library(factoextra)
# Generate random data with five variables
# I want the first 4 variables of different distributions and the last variable as a categorical factor
# For PCA and MDS, the categorical variable is not used in the computation itself; 
# PCA and MDS require only numeric variables. The categorical variable is typically included 
# only for visualization or interpretation (e.g., coloring points by group in plots).
# So, you can generate the data as below, but only use the first 4 numeric variables for PCA/MDS:

data_dim <- data.frame(
  var1 = rnorm(500, mean = 50, sd = 10),  # Normal distribution
  var2 = runif(500, min = 20, max = 80),  # Uniform distribution
  var3 = rpois(500, lambda = 30),         # Poisson distribution
  var4 = rexp(500, rate = 0.1),           # Exponential distribution
  categorical_var = sample(1:3, 500, replace = TRUE) # Categorical factor (optional, for plotting)
)
# View first few rows of the data
head(data_dim)
# Print dimensions of the data
print(dim(data_dim))
# Ensure categorical_var is a factor for PCA
data_dim$categorical_var <- as.factor(data_dim$categorical_var)
# Perform PCA on the data
pca_result <- prcomp(data_dim[, -ncol(data_dim)], center = TRUE, scale. = TRUE)
# Get the summary of PCA results
summary(pca_result)

# Use psych package to get the proportion of variance explained by each principal component
library(psych)
pca_model <- principal(data_dim[, -ncol(data_dim)], rotate = "none", nfactors = 4)
print(pca_model)
# PCA with SS loadings (eigenvalues > 1) are taken in to account
biplot(pca_model)

# Getting eigen values from “FactoMineR” package
library(FactoMineR)
pca_fm <- PCA(data_dim[, -ncol(data_dim)], graph = FALSE)
# Print eigenvalues from PCA
print(pca_fm$eig)
# Take the component with eigenvalue > 1

# Can we improve the PCA? We can try PCA with “VARIMAX” rotation
pca_varimax <- principal(data_dim[, -ncol(data_dim)], rotate = "varimax", nfactors = 4)
print(pca_varimax)


# Even better scree plot using factoextra
library(factoextra)
fviz_eig(pca_result, addlabels = TRUE, barfill = "steelblue", barcolor = "black")

# Create a biplot for PCA
biplot(pca_result, main = "Biplot for PCA", col = c("blue", "red"), cex = 0.5)


# Perform MDS on the data
# Perform MDS to find the stress value of the model and determine the number of dimensions

mds_result <- cmdscale(dist(data_dim[, -ncol(data_dim)]), k = 2, eig = TRUE)
print(summary(mds_result))  # Print eigenvalues for MDS

# Get the stress value of the MDS model with isoMDS
library(MASS)
mds_stress <- isoMDS(dist(data_dim[, -ncol(data_dim)]))
# Print the stress value
print(mds_stress$stress)

# Stress value indicates how well the MDS model fits the data. stress < 0.2 is considered a good fit.

# Plot the mds results in biplot
# plot(mds_result$points, main = "MDS Biplot", xlab = "MDS Dimension 1", ylab = "MDS Dimension 2", col = data_dim$categorical_var, pch = 19)
# Add a legend to the MDS plot
# legend("topright", legend = levels(data_dim$categorical_var), col = 1:length(levels(data_dim$categorical_var)), pch = 19)

plot(mds_result, pch=19)


# Create a data frame for MDS results
# mds_data <- data.frame(MDS1 = mds_result$points[, 1], MDS2 = mds_result$points[, 2])
# # Add the categorical variable to the MDS data
# mds_data$categorical_var <- data_dim$categorical_var
# # Plot MDS results with ggplot2
# ggplot(mds_data, aes(x = MDS1, y = MDS2, color = categorical_var)) +
#   geom_point() +
#   labs(title = "MDS Results", x = "MDS Dimension 1", y = "MDS Dimension 2") +
#   theme_minimal()

# After running MDS, plot with abline and text labels

# Example: Custom MDS plot (replace mds.1 and USArrests.1 with your objects if needed)
mds_points <- mds_result$points  # 2D coordinates from cmdscale
plot(mds_points, pch = 19, main = "Custom MDS Plot")
abline(h = 0, v = 0, lty = 2)
text(mds_points, pos = 4, labels = rownames(mds_points), col = 'tomato')

# Improve the MDS with Sammon't stress
sammon_result <- sammon(dist(data_dim[, -ncol(data_dim)]), k = 2)
# Plot the Sammon's MDS results
plot(sammon_result$points, pch = 19, main = "Sammon's MDS Plot")
# add abline to the Sammon's MDS plot
abline(h = 0, v = 0, lty = 2)

# Add text labels to the Sammon's MDS plot
text(sammon_result$points, pos = 4, labels = rownames(sammon_result$points), col = 'tomato')

# Add arrows to the Sammon's MDS plot
# arrows(0, 0, sammon_result$points[, 1], sammon_result$points[, 2], col = 'blue', length = 0.1)

# Add arrows from Sammon's MDS points to PCA points
# Make sure both sammon_result$points and pca_result$x have the same row order and number of rows
arrows(
  x0 = sammon_result$points[, 1], y0 = sammon_result$points[, 2],
  x1 = pca_result$x[, 1], y1 = pca_result$x[, 2],
  col = 'red', length = 0.1
)
