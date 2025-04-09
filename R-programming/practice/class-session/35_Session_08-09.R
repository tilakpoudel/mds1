#loading dplyr package
install.packages("dplyr")
library(dplyr)
library(nycflights13) #abstracting the data set of 
flights
str(flights)
jan1 <- filter(flights, month == 1, day ==1) #sub-setting the nycflights13 with filter() function
(jan1 <- filter(flights, month == 1, day == 1))
dec25 <- filter(flights, month == 12, day == 25)
(dec25 <- filter(flights, month == 12, day == 25))
jan <- filter(flights, month == 1)
filter(flights,month == 11 | month == 12)
filter(flights, month == 11 | 12)
(nov_dec <- filter(flights, month %in% c(11,12)))
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

#arrange
arrange(flights, year, month, day)
arrange(flights, desc(dep_delay)) #desc() to re-order by a column in descending order
dep_delay_20 <- head(arrange(flights, desc(dep_delay)), n = 20)
table(dep_delay_20$carrier)
mean(dep_delay_20$dep_delay)

#helper function in R(starts_with(), ends_with(), contains(), num_range(), everything())
#select
select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day))
select(flights, time_hour, air_time, everything())
select(flights, time_hour, air_time)
rename(flights, tail_num = tailnum)

#mutate
#is used to add a new columns
flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)
mutate(flights_sml, gain = dep_delay - arr_delay, speed = distance / air_time * 60)
mutate(flights_sml, gain = dep_delay - arr_delay, hours = air_time / 60, gain_per_hour = gain / hours)

#transmute()
transmute(flights, gain = dep_delay - arr_delay, hours = air_time / 60, gain_per_hour = gain / hours)
# %/% is used as integer division and %% is used to execute remainder
transmute(flights, dep_time, hour = dep_time %/% 100, minute = dep_time %% 100)

#summarise
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm=TRUE))
delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")
delays

flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay, na.rm = TRUE))

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay),
         !is.na(arr_delay))
not_cancelled

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

#count()
delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(delay = mean(arr_delay))
hist(delays$delay)

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(delay = mean(arr_delay,
                         na.rm = TRUE),
            n = n())
hist(delays$n)
hist(delays$delay)
plot(delays$n, delays$delay)

#When do the first and last flights leave each day ?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

#Why is distance to some destinations more variable than others ?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))

#Which destinations have the most carriers ?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))

count(select(flights, dep_time < (5*60)))

#How many flights left before 5 am ?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(n_early = sum(dep_time<500))

not_cancelled %>% 
  group_by(year, month) %>% 
  summarise(n_early = sum(dep_time<500))

#What proportion of flights are delayed by more than an hour ?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(hour_prop = mean(arr_delay>60))

#Find all groups bigger than a threshold.
popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n()>365)
popular_dests

head(popular_dests$dest)
tail(popular_dests$dest)

#slice
flights %>% slice_sample(n=5)
flights %>% slice_sample(n=5, replace = TRUE)
set.seed(123)
train_data <- flights %>% 
  slice_sample(prop = 0.8)
train_data
test_data <- flights %>% 
  slice_sample(prop = 0.2)
test_data