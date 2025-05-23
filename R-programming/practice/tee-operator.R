# load necessary libraries
library(magrittr)

set.seed(123)
# set 200 random normal distribution data
rnorm(200) %>%
  matrix(ncol = 2) %>%
  plot %>%
  colSums

# use of tee pipe operator
set.seed(123)
# set 200 random normal distribution data
rnorm(200) %>%
  matrix(ncol = 2) %T>%
  plot %>%
  colSums

x<-rnorm(100)

hist(x)
qqnorm(x)
qqline(x)
shapiro.test(x)
scatter.smooth(x)
