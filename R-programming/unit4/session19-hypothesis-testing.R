# Check the mean of mpg in mtcars
# NUll Hypothesis (H0) = 20
# Alternative Hypothesis !=20
mu0 <- 20
sigma <- 6
xbar <- mean(mtcars$mpg)
n <- length(mtcars$mpg)
print(n)

# test if mpg follow normal distribution
shapiro.test(mtcars$mpg)
# Shapiro-Wilk normality test
# 
# data:  mtcars$mpg
# W = 0.94756, p-value = 0.1229
#  it follows normal distribution

# function to calculate z value
z <- sqrt(n) * (xbar - mu0) / sigma
p_value <- 2 * pnorm(-abs(z))
print(p_value)

p_value <- 2 * pnorm(z)
print(p_value)

# Interpretation
# print(p_value)
# [1] 0.9319099
# If p-value > 0.05, accept null hypothesis,
# Our p value is > 0.05, we accept null hypothesis, So the mean is 20.


# USE t-test
t.test(mtcars$mpg, mu=mu0)


# TWO sample mpg and am (Transmission, automatic and manual)

# testing assumptions. 1. Test normality for am on both value 0 and 1
shapiro.test(mtcars$am)
# data:  mtcars$am
# W = 0.62507, p-value = 7.836e-08
# p-value < 

#  Test if the every category follows normal distribution
with(mtcars, shapiro.test(mpg[am==0]))
# Shapiro-Wilk normality test
# 
# data:  mpg[am == 0]
# W = 0.97677, p-value = 0.8987
# p-value > 0.05, so it follows normal distribution

with(mtcars, shapiro.test(mpg[am==1]))
# Shapiro-Wilk normality test

# data:  mpg[am == 1]
# W = 0.9458, p-value = 0.5363
#  p-value > 0.05 , so follows normal distribution

# 2. Test group varianve test
# H0 
var.test(mpg~am, data = mtcars)
# F test to compare two variances
# 
# data:  mpg by am
# F = 0.38656, num df = 18, denom df = 12, p-value = 0.06691
# since p-value > 0.05, accept H0, accept H0. ie. it follows normal distribution.
# so can use two sample student test

t.test(mpg~am, var.equal = T, data = mtcars)
# Two Sample t-test
# 
# data:  mpg by am
# t = -4.1061, df = 30, p-value = 0.000285
# alternative hypothesis: true difference in means between group 0 and group 1 is not equal to 0
# 95 percent confidence interval:
#   -10.84837  -3.64151
# sample estimates:
# mean in group 0 mean in group 1 
# 17.14737        24.39231 
# Since p-value is 0.000285, accept H0, i.e it follows normal distribution. Looking
# mean for group 1 (manual) has more mileage

# fit the linear model 
lm(mpg~am, data=mtcars)
# Call:
#   lm(formula = mpg ~ am, data = mtcars)
# 
# Coefficients:
#   (Intercept)           am  
# 17.147        7.245 

summary(lm(mpg~am, data=mtcars))
# Residuals is used to predict 

# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)   17.147      1.125  15.247 1.13e-15 ***
#   am             7.245      1.764   4.106 0.000285 ***
#  it means that vechile (am = manual) give 7.245 more mileage than am = automatic

# Test linear test better mpg and am
# x = am, y = mpg
plot(mtcars$am, mtcars$mpg)
# test linear with pearson correaltion coefficient test, the plot may not be
# convinced about linear but we have pearson's correlation test
cor.test(mtcars$am, mtcars$mpg)
# Interpretation
# Pearson's product-moment correlation
# 
# data:  mtcars$am and mtcars$mpg
# t = 4.1061, df = 30, p-value = 0.000285
# p-value < 0.05, it means it is linear
