#install.packages("nycflights13")
# it is not time series data , it is wide data
library(nycflights13)
library(dplyr)

head(flights)
str(flights)

# dplyr 5 important fuctions
#1. filter
jan1 <- dplyr::filter(flights, month == 1, day == 1)
print(jan1)
(jan1 <- dplyr::filter(flights == 1, day == 1)) # save as an object

dec25 <- dplyr::filter(flights, month == 12, day == 25)
dec25 <- dplyr::filter(flights, month == 12, day == 25)

dplyr::filter(flights, month = 1) # can't assign the value with single "="
dplyr::filter(flights, month == 1) # works with "==" 

dplyr::filter(flights, month == 11 | month == 12)
dplyr::filter(flights, month == 11 | 12)

nov_dec <- dplyr::filter(flights, month %in%c(11,12))
print(nov_dec)

# Demorgan's law:
# get the filghts with delay 
dplyr::filter(flights, !(arr_delay > 120 | dep_delay > 120)) # works, usage of demorgan law

dplyr::filter(flights, arr_delay <= 120, dep_delay <= 120)

#CASE 2: Usage of AP data
# Aus 1949 to , air passengers values in millions, time series data
AP <- AirPassengers
AP
head(AP)
tail(AP)

# plot the data
plot(AP)
# Analysis
# The plot shows that over the year number of AP are increasing, The number is peak (in december)


#2. arrange
# Arrange will order the data in ascending order (by default)

# Sort the flight data by dep_delay
# Airlines with highest delay
dplyr::arrange(flights, desc(dep_delay))

# Missing values are always in the bottom
dplyr::arrange(flights)

# Look for help in docs
?dplyr


#3. Select
# Only select the required attributes
dplyr::select(flights, year, month, day)

# get variable from year to day, col
dplyr::select(flights, year:day)


#4. Expect (-)
# Exclude the attributes
# changes columns
# select all columns expect year to day (i.e year, month, day)
dplyr::select(flights, -(year:day))


#5. Other available functions
# starts_with
# ends_with()
# contains()

?dplyr::num_range
dplyr::num_range("x", 1:3) #matches x1, x2 and x3


#6. rename()
#rename column
#rename(flights, tail_num=tailnum)


#7. mutate
#crate a new variable / coumn

# Adding var in flight_sml
flight_sml <- dplyr::select(flights, 
  year:day,
  ends_with("delay"),
  distance,
  air_time
)

print(flight_sml)

# Add new variable gain and speed at the end
dplyr::mutate(flight_sml,
   gain = dep_delay - arr_delay,
   speed = distance / air_time * 60
)

head(flight_sml)
str(flight_sml)

# Use only add newly added variable
# transmute() keep the new variable only

# 8. summarize
# get the mean of dep_delay
dplyr::summarize(flights, delay_mean = mean(dep_delay, na.rm = TRUE))

# get standard deviation of dep_delay
dplyr::summarize(flights, delay_sd = sd(dep_delay, na.rm = TRUE))

# histogram plot for dep_delay 
hist(flights$dep_delay)
# Analysis?
# It is left skewed

# mean and sd is used for bell shaped distribution only, DON'T use mean and sd for distribution other than bell shaped
# Use Interquartile range for other shape (left, right skewed)

# summarize works best for group summaries
by_day <- dplyr::group_by(flights, year, month, day)

dplyr::summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

# what happens?
delays <- flights %>%
  dplyr::group_by(dest) %>%
  dplyr::summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean (arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")


# Q. How to remove cancelled flights? and get summaries by groups!
not_cancelled <- flights %>%
  dplyr::filter(
    !is.na(dep_delay),
    !is.na(arr_delay)
  )

not_cancelled%>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))

delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay)
  )

hist(delays$delay)
# Still the graph is left skewed, a bit better than before

# Q. Find the popular destinations?
head(popular_dests$dest)


# 10. slice function
# Random sampling
flights %>% slice(1L)
flights

# Use set seed to produce the same data on every sampling

flights %>%slice_sample(n=5)
flights %>%slice_sample(n=5, replace=TRUE)
set.seed(123) # always produce the same sample data every time with set seed
flights %>%slice_sample(n=5)


