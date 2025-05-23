# Part 1: Use “airquality” data of R and locate median and mode of “Temp” variable graphically.
# Validate the value of median and mode obtained from graph with median and mode functions in R.
# Which summary measure (average and dispersion) must be used for "Wind" and "Temp" variables? 
# Why: Justify your decision with graphs and tests.

# Load the airquality dataset
data("airquality")
# Check the structure of the dataset
str(airquality)
# Check the first few rows of the dataset
head(airquality)
# Check the summary of the dataset
summary(airquality)
# Check the names of the columns in the dataset
names(airquality)
# Check the number of rows and columns in the dataset
dim(airquality)
# Check the number of missing values in each column
colSums(is.na(airquality))
# Check the number of missing values in the "Temp" column
sum(is.na(airquality$Temp))
# Check the number of missing values in the "Wind" column
sum(is.na(airquality$Wind))

# locate median and mode of "Temp" variable graphically
# Create a histogram of the "Temp" variable
data <- airquality
data$Temp
data$Temp <- as.numeric(data$Temp)
class(data$Temp)
# Check the summary of the "Temp" variable
summary(data$Temp)
# create breaks using min and max values
breaks <- seq(55, 100, by = 5)
breaks
# Create a histogram of the "Temp" variable
hist(data$Temp, 
     main = "Histogram of Temperature", 
     xlab = "Temperature", 
     ylab = "Frequency", 
     col = "lightblue", 
     border = "black", 
     breaks = breaks)
# Add a vertical line for the median
abline(v = median(data$Temp, na.rm = TRUE), col = "red", lwd = 2, lty = 2)

# validate the value of median obtained from graph with median function in R
median(data$Temp, na.rm = TRUE)

# Here we can see that the median value of the "Temp" variable is 79, which is 
# the same as the value obtained from the histogram.



# validate the value of mode obtained from graph with mode function in R
# get the mode of the dataset
# Create frequency table
temp_freq <- table(data$Temp))

# Find the value(s) with the highest frequency
mode_temp <- as.numeric(names(temp_freq)[which.max(temp_freq)])
mode_temp

# Create a histogram of the "Temp" variable with mode
hist(data$Temp, 
     main = "Histogram of Temperature with Mode", 
     xlab = "Temperature", 
     ylab = "Frequency", 
     col = "lightblue", 
     border = "black", 
     breaks = breaks)
# Add a vertical line for the mode
abline(v = mode_temp, col = "green", lwd = 2, lty = 2)
abline(v = median(data$Temp, na.rm = TRUE), col = "red", lwd = 2, lty = 2)

# display the mode and median value on y-axis
# text(median(data$Temp, na.rm = TRUE), 20, paste("Median:", median(data$Temp, na.rm = TRUE)), col = "red", pos = 4)
# text(mode_temp, 20, paste("Mode:", mode_temp), col = "green", pos =0 )

# Add a legend
legend("topright", 
       legend = c("Median", "Mode"), 
       col = c("red", "green"), 
       lty = 2, 
       lwd = 2)

# Here we can see that the mode value of the "Temp" variable is 81, which is
# the same as the value obtained from the histogram.

## Apply appropriate tests to determine the average and dispersion measures for "Wind" and "Temp" variables
# Check the distribution of the "Wind" variable
hist(data$Wind, 
     main = "Histogram of Wind", 
     xlab = "Wind", 
     ylab = "Frequency", 
     col = "lightblue", 
     border = "black")

# Test of normality with shapiro.test
shapiro.test(data$Wind)

# p-value > 0.05 indicates that the data is normally distributed. so we can use 
# mean and standard deviation as measures of central tendency and dispersion.

# Check the distribution of the "Temp" variable
hist(data$Temp, 
     main = "Histogram of Temperature", 
     xlab = "Temperature", 
     ylab = "Frequency", 
     col = "lightblue", 
     border = "black")
# Test of normality with shapiro.test
shapiro.test(data$Temp)
# p-value < 0.05 indicates that the data is not normally distributed. so we can use
# median and interquartile range as measures of central tendency and dispersion.