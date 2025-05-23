# Built in data in R
# Bar graphs
VADeaths

str(VADeaths)
head(VADeaths)

gd <- as.data.frame(VADeaths)

View(gd)

barplot(gd$`Rural Male`)

barplot(
  gd$`Rural Male`, 
  names.arg = c("50-54", "55-59", "60-64", "65-69", "70-74")
)

barplot(
  gd$`Rural Male`, 
  names.arg = c("50-54", "55-59", "60-64", "65-69", "70-74"),
  main = "Deaths rate among rural male in Virginia, USA",
  xlab = "Age group",
  ylab = "Rate"
)

# Transpose the graph and add color
barplot(
  gd$`Rural Male`, 
  horiz = T,
  names.arg = c("50-54", "55-59", "60-64", "65-69", "70-74"),
  main = "Deaths rate among rural male in Virginia, USA",
  ylab = "Age group",
  xlab = "Rate",
  col="blue",
  border = "red"
)

# Add limit
barplot(
  gd$`Rural Male`, 
  horiz = T,
  names.arg = c("50-54", "55-59", "60-64", "65-69", "70-74"),
  main = "Deaths rate among rural male in Virginia, USA",
  ylab = "Age group",
  xlab = "Rate",
  col="blue",
  border = "red",
  xlim = c(0,70), # add limit to the x axis
  cex.axis = 0.80 # decrease font size
)

# compare all the data in gd
# convert the data frame to matrix to form sub-divided graph
gdm <- as.matrix(gd)
barplot(
  gdm,
  col = c("lightblue", "mistyrose", "lightcyan", "lavender", "cornsilk"),
  legend = rownames(gd)
)

# Adjust the legend position
my_colors <-   col = c("lightblue", "mistyrose", "lightcyan", "lavender", "cornsilk")


#Add legend
# legend ("topright", legend = rownames(gdm)),
# fill = my_colors, box.lty = 0, cex=0.8

# barplot(
#   gdm, 
#   col = my_colors,
#   legend = ("topright")
#   legend =rownames(gdm ),
#   fill = my_colors,
#   box.lty = 0,
#   cex=0.8
# )


barplot(
  gdm,
  col = c("lightblue", "mistyrose", "lightcyan", "lavender", "cornsilk"),
  legend = rownames(gdm),
  beside = T
)


# Pie chart

gd <- as.data.frame(VADeaths)
pie(
  gd$`Rural Male`,
  labels = rownames(gd),
  radius = 1
)

# Add manual color
pie(
  gd$`Rural Male`,
  labels = rownames(gd),
  radius = 1,
  col = c("#999999", "#E69F00", "#56B4E9", "red", "blue")
)

# Add percent and legend
gd$piepercent <- round(100*gd$`Rural Male` / sum(gd$`Rural Male`), 1)
pie(
  gd$`Rural Male`,
  labels = gd$piepercent,
  main = "% Deaths by age groups for Rural male",
  col = rainbow(length(gd$`Rural Male`)),
  
)
legend("topright", c("50-54", "55-59", "60-64", "65-69", "70-74"), cex = 0.8, fill = rainbow(length(gd$`Rural Male`)))


# Line chart
# gdcars
# Don't use line chart if there is not time series data
# line chart or time plot
plot(AirPassengers)

# Intrepretation
# increasing trend on number of air passengers over time period, and seasonality (peak) in the year

# percent is preferable over number because it is comparable
# YT review of new products: dev to dev, arun (british), martis


# For continuous data 
# Histogram (density based), Q-Q ,  Density Plot
# bar diagram are frequency based

gdcar <- as.data.frame(cars)
hist(gdcar$speed)
# bell shaped / 
str(gdcar)

hist(
  gdcar$speed,
  col = "steelblue"
)

# add interval using 
hist(
  gdcar$speed,
  col = "steelblue",
  breaks = 10
)

# Density plot
dens <- density(cars$speed)

# Q-Q plot
# Use q-q plot to test the normality 
# q-q plot, quantile to quantile plot
qqnorm(cars$speed)
qqline(cars$speed, col="red")
# if the points falls in the line , the data is normal distribution, others outside the line are outliers

# statistical test calculating the p value

# Scatter plot
# x(indenpenent variable), y
plot(cars$speed, cars$dist)

plot(
  cars$speed, 
  cars$dist,
  xlab = "Speed",
  ylab = "Distance",
  main = "Speed vs Distance plot"
)

# line of best fit
# linear = pearson coefficient
# non-linear = spearson's correlation coefficient
# parametric test => t-test/ p-test/ one way anova

# BOx plot , see the outliers
boxplot(
  mpg~cyl, data = mtcars
)

# q-q line to see the 
qqnorm(mtcars$mpg)
qqline(mtcars$mpg, col="red")


boxplot(
  mpg~gear, 
  data = mtcars,
  xlab = "Number of cylinders",
  ylab = "Miles per Gallon",
  main = "Mielage Data"
)


