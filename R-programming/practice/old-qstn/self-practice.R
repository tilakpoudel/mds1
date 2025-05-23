# SESSION 7 & 8

# rbind vs cbind
# rbind() is used to combine data frames by rows, while cbind() is used to combine data frames by columns.
# # rbind example

library(tibble)
region_a <- tibble(
  region = c("A", "B", "C"),
  value = c(1, 2, 3)
)
region_b <- tibble(
  region = c("D", "E", "F"),
  value = c(4, 5, 6)
)
combined_df <- rbind(region_a, region_b)
print(combined_df)

# add new column with cbind
is_happy <- c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)
combined_df <- cbind(combined_df, is_happy)
print(combined_df)


# Long vs Wide format
# Long format is a way of structuring data where each variable is stored in a separate column, and each observation is stored in a separate row.
# Long format is often used for time series data or when there are multiple measurements for each observation.
# A tibble: 6 × 3
#   student subject score
#   <chr>   <chr>   <dbl>
# 1 Alice   Math       90
# 2 Alice   Science    92
# 3 Bob     Math       85
# 4 Bob     Science    80
# 5 Carol   Math       88
# 6 Carol   Science    91


# Wide format is a way of structuring data where each variable is stored in a separate row, and each observation is stored in a separate column.
# Wide format is often used for data that has a fixed number of measurements for each observation.
# A tibble: 3 × 3
#   student  Math Science
#   <chr>   <dbl>   <dbl>
# 1 Alice      90      92
# 2 Bob        85      80
# 3 Carol      88      91

library(tibble)
wide_data <- tibble(
  student = c("Alice", "Bob", "Carol"),
  Math = c(90, 85, 88),
  Science = c(92, 80, 91)
)
print(wide_data)

library(tidyr)
# convert wide to long format
long_data <- pivot_longer(wide_data, cols = c("Math", "Science"), names_to = "subject", values_to = "score")
print(long_data)

# convert long to wide format
wide_data_converted <- pivot_wider(long_data, names_from = "subject", values_from = "score")
print(wide_data_converted)

# convert tp wide format using pipe
wide_data_converted <- long_data %>%
  pivot_wider(names_from = subject, values_from = score)
print(wide_data_converted)

# Create tibble with missing values
stocks <- tibble(
    year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
    qtr =c(1, 2, 3, 4, 2, 3, 4),
    return = c(0.1, 0.2, 0.35, NA, 0.5, 0.17, 0.7)
)
print(stocks)
# convert to wider format
stocks %>%
    pivot_wider(names_from = year, values_from = return) %>%
    pivot_longer(
        cols = c(2015, 2016), 
        names_to = "year", 
        values_to = "return",
        values_drop_na = TRUE
    )
    
print(stocks)

# handling missing values
# use of complete command
stocks %>%
    complete(year, qtr)
print(stocks)
# use of fill command
stocks %>%
    fill(year, qtr)
print(stocks)

# other example
treatment <- tribble(
  ~ person, ~ treatment, ~ response,
  "Derrick Whitmore", 1, 7,
  "Derrick Whitmore", 2, 10,
  "Derrick Whitmore", 3, 9,
  "Katherine Burke", 1, 4
)
print(treatment)

# use fill command
treatment %>%
    fill(person)


# TRANSFORM/ MANIPULATION DATA WITH dplyr
# filter()
# arrange()
# select()
# mutate()
# summarise()
# group_by()

# Use nycflights13 dataset
library(dplyr)
library(nycflights13)
flights

filter(flights, month == 1, day == 1)
jan1 <- filter(flights, month == 1, day == 1)
print(jan1)

(jan1 <- filter(flights, month == 1, day == 1))

filter(flights, month == 1)

# multiple conditions
filter(flights, month == 1 & day == 1)
filter(flights, month == 1 | day == 1)

nov_dec <- filter(flights, month %in% c(11, 12))
print(nov_dec)

# De morgan laws
# !(x & y) == !x | !y
# !(x | y) == !x & !y
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120 & dep_delay <= 120)

arrange(flights, year, month, day)
arrange(flights, desc(dep_delay))
select(flights, -(year:day))

# select, it can be used to rename variables
# rename() is used to rename variables in a data frame.

rename(flights, tail_num = tailnum)
str(flights)

# everything()
# select all columns except the specified ones
select(flights, time_hour, air_time, everything())

# mutate() is used to create new variables or modify existing ones in a data frame.
# Adding variables in flights_sml
flights_sml <- select(
    flights, 
    year:day, 
    ends_with("delay"), 
    distance, 
    air_time
)
print(flights_sml)
flights_sml <- mutate(
    flights_sml, 
    gain = arr_delay - dep_delay,
    speed = distance / air_time * 60
)
print(flights_sml)

mutate(
    flights_sml, 
    gain = arr_delay - dep_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours
)

# transmutate() is used to create new variables and drop the existing ones.
transmute(
    flights_sml, 
    gain = arr_delay - dep_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours
)

# summarise() is used to create summary statistics for a data frame.
# It can be used to calculate mean, median, sum, count, etc.

summarise(flights,
          avg_delay = mean(dep_delay, na.rm = TRUE),
          avg_arrival_delay = mean(arr_delay, na.rm = TRUE)
)
# group_by() is used to group a data frame by one or more variables.
# It is often used in conjunction with summarise() to calculate summary statistics for each group.

by_day <- group_by(flights, year, month, day)
daily_summaries <- summarise(
    by_day,
    avg_delay = mean(dep_delay, na.rm = TRUE),
    avg_arrival_delay = mean(arr_delay, na.rm = TRUE)
)
print(daily_summaries)

# multiple operations : pipes
delays <- flights %>%
group_by(dest) %>%
summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm =
    TRUE)
) %>%
filter(count > 20, dest != "HNL")

# How to remove cancelled flights?
# And, get summaries by groups!?
not_cancelled <- flights %>%
    filter(!is.na(dep_delay), !is.na(arr_delay))
not_cancelled %>%
    group_by(year, month, day) %>%
    summarise(
        avg_delay = mean(dep_delay, na.rm = TRUE),
        avg_arrival_delay = mean(arr_delay, na.rm = TRUE)
    )

# counts : example
delays <- not_cancelled %>%
    group_by(tailnum) %>%
    summarise(delay = mean(arr_delay, na.rm = TRUE))
hist(delays$delay)

delays <- not_cancelled %>%
group_by(tailnum) %>%
summarise(
    delay = mean(arr_delay,

    na.rm = TRUE),
    n = n()
)
print(delays)

# plot
hist(delays$delay)
hist(delays$n)

plot(delays$delay, delays$n)

# When do the first and last flights
# leave each day?
not_cancelled %>%
    group_by(year, month, day) %>%
    summarise(
        first = min(dep_time),
        last = max(dep_time)
    )

# How many flights are delayed?
not_cancelled %>%
    group_by(year, month, day) %>%
    summarise(
        avg_delay = mean(dep_delay, na.rm = TRUE),
        avg_arrival_delay = mean(arr_delay, na.rm = TRUE)
    )

# Why is distance to some destinations more variable than to others?
not_cancelled %>%
group_by(dest) %>%
summarise(
    distance_sd =
    sd(distance)
) %>%
arrange(desc(distance_sd))

# Which destinations have the most carriers?
not_cancelled %>%
group_by(dest) %>%
summarise(
    carriers =
    n_distinct(carrier)
) %>%
arrange(desc(carriers))

# How many flights left before 5am? (these usually indicate delayed flights from the previous day)
not_cancelled %>%
group_by(year, month, day) %>%
summarise(
    n_early = sum(dep_time < 500)
) %>%
    arrange(desc(n_early))

# What proportion of flights are delayed by more than an hour?
not_cancelled %>%
group_by(year, month, day) %>%
summarise(
    hour_prop =
    mean(arr_delay > 60)
) %>%
    arrange(desc(hour_prop))

# Find all groups bigger than a threshold:
not_cancelled %>%
    group_by(year, month, day) %>%
    summarise(
        n = n()
    ) %>%
    filter(n > 500)

# Find the popular destinations:
not_cancelled %>%
    group_by(dest) %>%
    summarise(
        n = n()
    ) %>%
    arrange(desc(n))

popular_dest <- flights %>%
    group_by(dest) %>%
       filter(n() > 365)
print(popular_dest) 

# Get the top 10 most popular destinations
head(popular_dest$dest, 10)
# Least popular destinations
tail(popular_dest$dest, 10)

# Get the top 10 most popular destinations
popular_dest <- flights %>%
    group_by(dest) %>%
    summarise(
        n = n()
    ) %>%
    arrange(desc(n))
    print(popular_dest)

# Slice function example
flights %>% slice(1L)
flights %>% slice(n())
flights %>% slice(5: n())
slice(flights, -(1:4))

flights %>% slice_sample(n = 5)
flights %>% slice_sample(n = 5, replace = TRUE)
set.seed(39)
train_data <- flights %>% slice_sample(prop = 0.8)
train_data

test_data <- flights %>% slice_sample(prop = 0.2)
test_data


# Session10:  UNIT2, SESSION 4, Big Data

# SESSION 11, DATA MINING

# Session 12, Basic graphics / plots
# Bar chart, histogram, boxplot, scatterplot, piechart, line chart, 

install.packages("lattice")

# Bar diagram
?barplot

#use VADeaths dataset
gd <- as.data.frame(VADeaths)
gd
view(gd)

str(VADeaths)
head(VADeaths)

barplot(gd$`Rural Male`)
barplot(
    gd$`Rural Male`,
    names.arg = c("50-54", "55-59", "60-64", "65-69", "70-74"),
)

# Adding title and labels for x & y axes
barplot(
    gd$`Rural Male`,
    names.arg = c("50-54", "55-59", "60-64", "65-69", "70-74"),
    main = "Death Rates in Virginia",
    xlab = "Age Groups",
    ylab = "Death Rates"
)

# changing orientation and adding colors
barplot(
    gd$`Rural Male`,
    horiz = TRUE,
    names.arg = c("50-54", "55-59", "60-64", "65-69", "70-74"),
    main = "Death Rates in Virginia",
    xlab = "Age Groups",
    ylab = "Death Rates",
    col = "lightblue",
    border = "red",
    beside = TRUE
)

# changing axis lenght and font-size
barplot(
    gd$`Rural Male`,
    horiz = TRUE,
    names.arg = c("50-54", "55-59", "60-64", "65-69", "70-74"),
    main = "Death Rates in Virginia",
    xlab = "Age Groups",
    ylab = "Death Rates",
    col = "lightblue",
    border = "red",
    beside = TRUE,
    xlim = c(0, 70),
    cex.axis = 0.8,
    cex.names = 0.8
)

# sub divided / stacked bar chart
barplot(
    gd,
    main = "Death Rates in Virginia",
    xlab = "Age Groups",
    ylab = "Death Rates",
    col = c("lightblue", "lightgreen", "lightpink"),
    border = "red",
    legend = rownames(gd),
)

# Error:   'height' must be a vector or a matrix

# Data must be defined as matrix
gdm <- as.matrix(gd)
gdm
barplot(
    gdm,
    main = "Death Rates in Virginia",
    xlab = "Age Groups",
    ylab = "Death Rates",
    col = c("lightblue", "lightgreen", "lightpink"),
    border = "red",
    legend = rownames(gd),
)

# sub divided / stacked bar chart with placement, size and box of the legend
# define a set of colors
my_colors <- c("lightblue", "lightgreen", "lightpink", "lightyellow", "lightgray")
# create a barplot with legend
barplot(gdm, col=my_colors)
# add a legend
legend(
    "topright", 
    legend = rownames(gdm), 
    fill = my_colors, 
    cex = 0.8, 
    lty = 0
)

# multiple / Grouped bar diagram
barplot(
    gdm,
    col = c("lightblue", "mistyrose", "lightcyan", "lavender", "cornsilk"),
    legend  = rownames(gdm),
    beside = T
)

#  NOTE: Adding beside = TRUE will produce the multiple bar chart

#  Multiple / Group Bar diagram with change in legend values
my_colors <- c("lightblue", "mistyrose", "lightcyan", "lavender", "cornsilk")
barplot(
    gdm,
    col = my_colors,
    beside = TRUE,
    main = "Death Rates in Virginia",
    xlab = "Age Groups",
    ylab = "Death Rates",
    cex.axis = 0.8,
    cex.names = 0.8
)
legend(
    "topleft", 
    legend = rownames(gdm), 
    fill = my_colors, 
    cex = 0.8, 
    lty = 0
)

# Pie chart
# Pie chart is a circular statistical graphic, which is divided into slices to illustrate numerical proportions.
# Each slice of the pie represents a category's contribution to the total.
# The arc length of each slice (and consequently its central angle and area), is proportional to the quantity it represents.
# Pie charts are often used to visualize the percentage or proportion of different categories in a dataset.

gd <- as.data.frame(VADeaths)
pie(gd$`Rural Male`)
# Adding title and labels for x & y axes
pie(
    gd$`Rural Male`,
    main = "Death Rates in Virginia",
    labels = rownames(gd),
    radius = 1,
)

# pie-chart changing color
pie(
    gd$`Rural Male`,
    main = "Death Rates in Virginia",
    labels = rownames(gd),
    radius = 1,
    col = c("lightblue", "lightgreen", "lightpink", "lightyellow", "lightgray"),
)

# How to show % inside the pie chart?
gd$piepercent <- round(gd$`Rural Male` / sum(gd$`Rural Male`) * 100, 1)
pie(
    gd$`Rural Male`,
    main = "Death Rates in Virginia",
    labels = paste(rownames(gd), "\n", gd$piepercent, "%"),
    radius = 1,
    col = rainbow(length(gd$`Rural Male`)),
)

# How to place a legend on the topright corner?
legend(
    "topright", 
    legend = rownames(gd), 
    fill = rainbow(length(gd$`Rural Male`)), 
    cex = 0.8, 
    lty = 0
)

# How to change the size of the pie chart?
pie(
    gd$`Rural Male`,
    main = "Death Rates in Virginia",
    labels = paste(rownames(gd), "\n", gd$piepercent, "%"),
    radius = 0.8,
    col = rainbow(length(gd$`Rural Male`)),
)

## Line chart
# A line chart is a type of chart that displays information as a series of data points called 'markers' connected by straight line segments.
# load cars dataset

gdcar = as.data.frame(cars)
str(gdcar)
plot(gdcar$speed)

# Histogram , Q-Q plot, Boxplot, Density plot

hist(
    gdcar$speed,
    col="steelblue",
)

# How many breaks to access normality?
# 1. Use the default number of breaks
hist(
    gdcar$speed,
    col="steelblue",
    main = "Histogram of Speed",
    xlab = "Speed",
    ylab = "Distance",
    breaks = 10
)

# Density plot (freq polygin): speed variable
plot(
    density(gdcar$speed),
    main = "Density plot of Speed(mpg)",
    xlab = "Speed",
    ylab = "Density",
    col = "steelblue",
    frame = FALSE
)

# Density plot with polygon fill: Speed variable
dens <- density(cars$speed)
plot(
    dens,
    main = "Density plot of Speed(mpg)",
    xlab = "Speed",
    ylab = "Density",
    col = "steelblue",
    frame = FALSE
)
polygon(dens, col = "lightblue", border = "black")

# Q-Q plot
# A Q-Q plot (quantile-quantile plot) is a graphical tool to help assess if a dataset follows a given distribution.
# Always use this plot to access normality
# Q-Q plot of speed variable
qqnorm(gdcar$speed)
qqline(gdcar$speed, col = "red")

# Scatterplot
plot(
    gdcar$speed,
    gdcar$dist,
    main = "Scatterplot of Speed vs Distance",
    xlab = "Speed",
    ylab = "Distance",
    col = "steelblue",
    pch = 19
)

# Which correlation coefficient is appropriate here?
# The Pearson correlation coefficient is appropriate for this dataset, as it measures the linear relationship between two continuous variables.
# The Spearman correlation coefficient is appropriate for this dataset, as it measures the monotonic relationship between two continuous variables.

# use pearson correlation coefficient
cor(gdcar$speed, gdcar$dist, method = "pearson")
# use spearman correlation coefficient
cor(gdcar$speed, gdcar$dist, method = "spearman")

# Boxplot
# A boxplot is a standardized way of displaying the distribution of data based on a five-number summary ("minimum", first quartile (Q1), median, third quartile (Q3), and "maximum").
boxplot(
    mpg~cyl, 
    data=mtcars,
    main = "Boxplot of mpg by cyl",
    xlab = "Number of cylinders",
    ylab = "Miles per gallon",
    col = "lightblue",
    border = "red",
    horizontal = FALSE,
    notch = FALSE
)

# SESSION13: Graphics/ plot additional features
str(mtcars)
df <- as.data.frame(mtcars)
# bar plot of mpg by cyl
barplot(
    df$cyl
)

# define cyl as a factor
df$cyl <- as.factor(df$cyl)
bar plot of mpg by cyl
barplot(
    df$cyl,
    main = "Bar plot of mpg by cyl",
    xlab = "Number of cylinders",
    ylab = "Miles per gallon",
    col = "lightblue",
    border = "red",
    horizontal = FALSE,
    notch = FALSE
)
# Error in barplot.default(f.cyl) : 'height' must be a vector or a matrix
# • This means variable is factor but its frequencies are not found!
# barplot(f.cyl)

# How to get bar diagram from data frame?

# First we need frequencies of cars with 4, 6 and 8 cylinders
# Use table() function to get frequencies
table(df$cyl)
barplot(
    table(df$cyl),
    main = "Bar plot of mpg by cyl",
    xlab = "Number of cylinders",
    ylab = "Miles per gallon",
    col = "lightblue",
    border = "red",
    horizontal = FALSE,
    notch = FALSE
)

bpd <- table(df$cyl)
barplot(bpd)
# bar plot for gear and carb too the
barplot(table(df$gear))
barplot(table(df$carb))

# How to get barplot of “mpg” variable? mpg: miles per gallon (continuous variable)
#mpg is a continuous variable, so we need to convert it to a factor first
range(df$mpg)
# • R = 33.9 - 10.4 #23.5
# • I = round(sqrt(R)) # 5
#We need to construct 5 classes with
# width of 5 (10, 15, 20, 25, 30)
#We need to define the breaks
# breaks = c(10, 15, 20, 25, 30, 35) or
breaks <- seq(10, 35, by=5)
mpg.bin <- cut(
    df$mpg, 
    breaks,
    labels = c("10-15", "15-20", "20-25", "25-30", "30-35"),
)
mpg.bin
table(mpg.bin)
# barplot of mpg variable
barplot(
    table(mpg.bin),
    main = "Bar plot of mpg by cyl",
    xlab = "Miles per gallon",
    ylab = "Frequency",
    col = "lightblue",
    border = "red",
    horizontal = FALSE,
    notch = FALSE
)

# Histogram and abline for mean of mpg
hist(
    df$mpg,
    main = "Histogram of mpg",
    xlab = "Miles per gallon",
    ylab = "Frequency",
    col = "lightblue",
    border = "black",
    horizontal = FALSE,
    notch = FALSE
)

abline(
    v = mean(df$mpg), 
    col = "red", 
    lwd = 3
)

# • v = vertical “abline”
# • h = horizontal “abline”
# • lwd = line width (3=3 times wide)
# • lty =line types (2 = dashed line)

# Can you justify the use of mean for “mpg”variable in the histogram?
qqnorm(df$mpg)
qqline(df$mpg, col = "red")
# • The Q-Q plot shows that the data points are approximately linear, indicating that the data is normally distributed.
# • The Q-Q plot also shows that the data points are not perfectly linear, indicating that the data is not perfectly normally distributed.
# • The Q-Q plot also shows that the data points are not perfectly linear, indicating that the data is not perfectly normally distributed.

# Histogram and abline of median of “mpg”:
hist(
    df$mpg,
    main = "Histogram of mpg",
    xlab = "Miles per gallon",
    ylab = "Frequency",
    col = "lightblue",
    border = "black",
    horizontal = FALSE,
    notch = FALSE
)
# Locate median graphically for “mpg” variable

abline(
    v = median(df$mpg), 
    col = "red", 
    lwd = 3
)

# Histogram and abline of mode of “mpg”:
hist(
    df$mpg,
    main = "Histogram of mpg",
    xlab = "Miles per gallon",
    ylab = "Frequency",
    col = "lightblue",
    border = "black",
    horizontal = FALSE,
    notch = FALSE
)
abline(
    v = 3*median(df$mpg)-2*mean(df$mpg), 
    col = "red", 
    lwd = 3
)
# • Mode = 3*median - 2*mean

# Scatterplot with horizontal “abline”:
plot(
    df$mpg, 
    df$wt,
    main = "Scatterplot of mpg vs disp",
    xlab = "Miles per gallon",
    ylab = "weight",
    col = "lightblue",
    pch = 16
)

abline(h = 2, col = "red", lwd = 3)
abline(h = 4, col = "red", lwd = 3)

# Scatterplot with mean ± 1*sd of y-variable:
plot(df$wt, df$mpg, pch=16)
abline(h=mean(df$mpg), lwd =
2, col = "red")
abline(h=mean(df$mpg) +
1*sd(df$mpg), col = "blue",
lwd=3, lty = 2)
abline(h=mean(df$mpg) -
1*sd(df$mpg), col = "blue",
lwd=3, lty = 2)

# Scatterplot with “abline” from a model:
plot(df$wt, df$mpg, main =
"Scatterplot with abline", xlab =
"Weight", ylab = "MPG")
reg_mod <- lm(df$mpg ~ df$wt)
abline(reg_mod)

plot(
    df$wt, 
    df$mpg, 
    main ="Scatterplot with abline", 
    xlab ="Weight", 
    ylab = "MPG"
)

abline(lm(df$mpg ~ df$wt))

# Scatterplot with “abline” and “lines” for a non-linear data:

plot(df$hp, df$disp, main =
"Scatterplot with model abline",
xlab = "Horse power", ylab =
"Displacement")

abline(lm(df$disp ~ df$hp))

lines(lowess(df$hp, df$disp), col
= "red", lwd = 3)

# • Lowess = Locally weighted
# Scatterplot Smoothing

# SESSION 14: Goodness of fit tests
• Null hypothesis (H0): Observed
data (of a variable under
consideration) follows normal
distribution (p>0.05)

• Null hypothesis (H1): Observed
data (of a variable under
consideration) does not follow
normal distribution (p<=0.05)

Test of normality is confirmatory
test

• Before using this:
• We use histogram
• We use density plot
• We use normal Q-Q plot

# Let us use “airquality” data: aq <- airquality
aq <- airquality
str(aq)

# Ozone variable of aq dataframe
hist(aq$Ozone)
plot(density(aq$Ozone, na.rm =
T))
qqnorm(aq$Ozone)
qqline(aq$Ozone, col = 2)
shapiro.test(aq$Ozone)

# Solar Radiation variable

hist(aq$Solar.R)
plot(density(aq$Solar.R, na.rm =
T))
qqnorm(aq$Solar.R)
qqline(aq$Solar.R, col = 2)
shapiro.test(aq$Solar.R)


NOTE:
Parametric vs Non-parametric tests
• If a dependent variable (speed,
wind etc.) is normally distributed
then we use parametric tests:

• T-test = compare mean of the
dependent variable in two groups
e.g. speed by 4 and 6 cylinder cars

• 1-way ANOVA = compare mean of
the dependent variable in more
than two groups e.g. speed by 4, 6
and 8 cylinder cars

• Post-hoc test is done if 1-way
ANOVA p-value <=0.05


If a dependent variable (speed,
wind etc.) is not normally
distributed then we use non- parametric tests:

• Mann-Whitney test = compare median of the dependent variable
in two groups e.g. speed by 4 and 6
cylinder cars

• Kruskal-Wallis test = compare median of the dependent variable
in more than two groups e.g. speed
by 4, 6 and 8 cylinder cars
• Post-hoc test is done if K-W test p-value <=0.05


# Multiple graphs in a single window?

# Random Data

x <- rnorm(500)
y <- x + rnorm(500)

# Data
my_ts <- ts(matrix(rnorm(500),
nrow = 500, ncol = 1), start = c(1950, 1), frequency = 12)

my_dates <- seq(as.Date("2005/1/1"), by = "month", length = 50)

my_factor <- factor(mtcars$cyl)

fun <- function(x) x^2

#Creat a window for graphs in 2 rows and 3 columns
par(mfrow = c(2, 3))
plot(x, y, main = "Scatterplot")
plot(my_factor, main = "Barplot")
plot(my_factor, rnorm(32), main = "Boxplot")
plot(my_ts, main = "Time series")
plot(my_dates, rnorm(50), main = "Time based plot")
plot(fun, 0, 10, main = "Plot a
function")
# Graph is default mode
par(mfrow = c(1, 1))
plot(x, y, main = "Scatterplot")


# Correlation matrix plot of 3 continuous
# variable (multiple plots in a single window)
#Correlation matrix plot
plot(trees[, 1:3], main =
"Correlation plot")
# • Girth and Height is not linear so
# we must use Spearman’s
# correlation coefficient
# • Girth and Volume is linear so we
# must use Pearson’s correlation
# coefficient

# What will happen? • # Create dataframe with groups • 
group <- ifelse(
    x < 0 , "car", ifelse(x > 1, "plane", "boat")
)
df < - data.frame(x = x, y = y, group = factor(group))

• # Color by group • 
plot(df$x, df$y, col = df$group,
pch = 16)
