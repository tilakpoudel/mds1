# Part 3: Use "mpg" data of ggplot2 library and test the hypothesis that large engine cars (displ) 
# have less highway milage (hwy) using scatterplot (geom_point) for overall plot 
# and subcategories of disp variable with ggplot2 package. Then, perform smoothing 
# on this scatterplot and explain the algorithm/method used to do smoothing by the 
# ggplot2 package. Finally, use facet wrap and facet grid layers to show scatterplots
# for cyl and drv variables in ggplot2 and explain the results carefully.

# Load the required libraries
library(ggplot2)

data(mpg)
# Check the structure of the dataset
str(mpg)
# Check the first few rows of the dataset
head(mpg)
# Check the summary of the dataset
summary(mpg)
# Check the names of the columns in the dataset
names(mpg)

# Check the number of rows and columns in the dataset
dim(mpg)

# Hypothesis testing
# Hypothesis: Large engine cars (displ) have less highway mileage (hwy)
# Null Hypothesis (H0): There is no relationship between engine size (displ) and highway mileage (hwy).
# Alternative Hypothesis (H1): There is a negative relationship between engine size (displ) and highway mileage (hwy).

# Create a scatterplot of displ vs hwy
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  labs(title = "Scatterplot of disp vs hwy",
       x = "Engine Displacement (displ)",
       y = "Highway Mileage (hwy)"
  )
# Interpretation: We observe a negative correlation — as displ increases, 
# hwy tends to decrease. This supports the hypothesis that larger engines have lower fuel efficiency.

# Plot the scatter plot with subcategories of displ
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy, color = factor(cyl))) +
  labs(title = "Scatterplot of disp vs hwy with subcategories of cyl",
       x = "Engine Displacement (displ)",
       y = "Highway Mileage (hwy)",
       color = "Number of Cylinders (cyl)"
  )
# Interpretation: The scatterplot shows that cars with more cylinders (cyl) tend 
# to have larger displ and lower hwy.

# Smoothing
# perform smoothing on this scatterplot and explain the algorithm/method used to do smoothing by the ggplot2 package
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy), alpha=0.6) +
  geom_smooth(aes(x = displ, y = hwy), method = "loess", se = TRUE, color = "blue") +
  labs(title = "Scatterplot of disp vs hwy with smoothing",
       x = "Engine Displacement (displ)",
       y = "Highway Mileage (hwy)"
  )
# Interpretation: The blue line represents a locally weighted regression (loess)
# fitted to the data. The loess method is a non-parametric regression method that
# fits a smooth curve to the data by using local polynomial regression fitting.
# It is particularly useful for capturing non-linear relationships in the data.
# The shaded area around the line represents the confidence interval for the fitted values.

# Facet wrap
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(~cyl) +
  labs(title = "Scatterplot of disp vs hwy by Number of Cylinders (cyl)",
       x = "Engine Displacement (displ)",
       y = "Highway Mileage (hwy)"
  )
# Interpretation: The facet wrap creates separate scatterplots for each level of the cyl variable.
# This allows us to see how the relationship between displ and hwy varies with the number of cylinders.
# The vechile with less than 4 cylinders have higher hwy mileage compared to the vehicles with more than 4 cylinders.
# Vechile with 8 cylinders have the least hwy mileage.

# Facet grid
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl) +
  labs(title = "Scatterplot of disp vs hwy by Number of Cylinders (cyl) and Drive Type (drv)",
       x = "Engine Displacement (displ)",
       y = "Highway Mileage (hwy)"
  )
# Interpretation: The facet grid creates a grid of scatterplots based on the levels of the drv and cyl variables.
# This allows us to see how the relationship between displ and hwy varies with both the number of cylinders and the drive type.
# The grid layout helps to visualize the interaction between these two categorical variables.
# The scatterplots show that the relationship between displ and hwy is similar across different drive types (fwd, rwd, 4wd),
# but the overall trend is that larger engines (displ) tend to have lower highway mileage (hwy).
# Conclusion: The analysis shows that larger engine cars tend to have lower highway mileage.

