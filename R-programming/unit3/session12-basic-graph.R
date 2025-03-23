# HYpothesis: 
#   Accept H0, when p>0.05
#   
#   Accept H1 p < 0.05
# airquality
aq <- airquality
str(aq)

# test the distribution of ozone 
hist(aq$Ozone)

plot(
  density(aq$Ozone, na.rm = T)
)

qqnorm(aq$Ozone)

qqline(aq$Ozone, col=2)

shapiro.test(aq$Ozone)
?shapiro.test

# intrepretation: since the sample size is 153 > 100, so shapiro is not ideal 
# but the modern method can be used for sample size of 3-5000

# W = 0.87867, p-value = 2.79e-08
 # p < 0.005 , does not follow normal distribution


# test for radiation variable
# test the distribution of ozone 
hist(aq$Solar.R)

plot(
  density(aq$Solar.R, na.rm = T)
)

qqnorm(aq$Solar.R)

qqline(aq$Solar.R, col=2)

shapiro.test(aq$Solar.R)

# intrepretation, the value 
# W = 0.94183, p-value = 9.492e-06

# see the distribution before summarizing, the data is skewed here so it is not
# good to use mean and median


# test the distribution of ozone 
hist(aq$Wind)

plot(
  density(aq$Wind, na.rm = T)
)

qqnorm(aq$Wind)

qqline(aq$Wind, col=2)

shapiro.test(aq$Wind)

# Intrepretation 
# data:  aq$Wind
# W = 0.98575, p-value = 0.1178

# p < 0.05 , the data is normal. we can use mean and median

# SEE on cars data

hist(cars$speed)

plot(
  density(cars$speed, na.rm = T)
)

qqnorm(cars$speed)

qqline(cars$speed, col=2)

shapiro.test(cars$speed)
# Intrepration of the result (car speed data)
# Shapiro-Wilk normality test
# 
# data:  cars$speed
# W = 0.97765, p-value = 0.4576
# p <0.05 so , the distribution is normal

# Parametric: Normal distribution
#   Non parametric: For non 

# Mann-whiney , for two groups
# Kruskal wallis test for more than 2 groups



