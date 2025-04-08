# 1. Getting multi-way table with array
# a. Create a 3-way table using the array function
data <- data.frame(
    gender = c("Male", "Female", "Male", "Female"),
    age = c("Young", "Old", "Old", "Young"),
    result = c("Pass", "Fail", "Pass", "Fail")
)
# Create a multi-way table
table_data <- table(data$gender, data$age, data$result)
print(table_data)

table_3way <- with(data, table(gender, age, result))
print(table_3way)

#  b. Creating class interval of continuous variable
ages <- c(15, 17, 22, 35, 40, 25, 28, 45, 55, 60, 70)
# Create class intervals
age_intervals <- cut(
    ages, 
    breaks = c(0, 20, 30, 40, 50, 60, 70, 80), 
    right = FALSE
)
table(age_intervals)


#4.  Reference ranges and outliers
# Reference ranges are typically defined as the 2.5th and 97.5th percentiles of a normal distribution.
# Outliers are typically defined as values that fall outside of the 1.5 times the interquartile range (IQR) from the first and third quartiles.
x <- c(10, 20, 21, 25, 40, 100)

# a.Reference Range based mean
mean_x <- mean(x)
sd_x <- sd(x)
lower_bound <- mean_x - 1.96 * sd_x
upper_bound <- mean_x + 1.96 * sd_x
cat("Reference Range: [", lower_bound, ", ", upper_bound, "]\n")

# b.Reference ranged based on median
median_x <- median(x)
q1_x <- quantile(x, 0.25)
q3_x <- quantile(x, 0.75)
iqr_x <- IQR(x)
lower_bound <- q1_x - 1.5 * iqr_x
upper_bound <- q3_x + 1.5 * iqr_x
cat("Reference Range: [", lower_bound, ", ", upper_bound, "]\n")

# c. Outliers
outliers <- x[x < lower_bound | x > upper_bound]
cat("Outliers: ", outliers, "\n")

# boxplot
boxplot(x, main = "Boxplot of x", ylab = "Values")

# 2078
# Tidy data
# Tidy data is a way of structuring datasets to make them easier to work with.
# In tidy data, each variable forms a column, each observation forms a row, and each type of observational unit forms a table.
# The tidyverse package in R provides a set of packages designed for data science that share an underlying design philosophy, grammar, and data structures.

library(tidyverse)
library(tidyr)
# Tidy data example
data <- data.frame(
    id = c(1, 2, 3, 4),
    age = c(25, 30, 35, 40),
    result = c("Pass", "Fail", "Pass", "Fail")
)
print(data)


# Data frame subsetting
df <- data.frame(matrix(1:25, nrow = 5, byrow = TRUE))
print(df)

# 1st 2 rows
df[1:2, ]
# 1st 2 rows and 1st 2 columns
df[1:2, 1:2]
# 3rd and 5th rows, 2nd and 4th columns
df[c(3,5), c(2, 4)]
# add new 5 rows
df <- rbind(df, matrix(26:50, nrow = 5, byrow = TRUE))
print(df)
