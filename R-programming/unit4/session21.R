# load mtcars data
str(mtcars)

shapiro.test(mtcars$mpg)
# data:  mtcars$mpg
# W = 0.94756, p-value = 0.1229

# since p > 0.05, which confirms that the dependent variable follows normal distribution

## Test correlation between mpg and wt
cor.test(mtcars$mpg, mtcars$wt)

# sample estimates:
#   cor 
# -0.8676594 

# we can see that there is high negative linear relationship

# Now fit the linear model
lm1 <- lm(mtcars$mpg~mtcars$wt, data = mtcars)
lm1
summary(lm1)

# The weight variables explains about 75 % of the mpg variable
# Multiple R-squared:  0.7528, > 0.5, ok
# The coefficient of determination R-square = 0.75 means dependent variable is 
# p-value p-value: 1.294e-10 < 0.05, ok
# 1 kg increase in weight decreases the mileage by 5.34

# LINE test of residuals
# 1. Linearity of resiuals test
# Graphical (suggestive)
plot(lm1, which = 1, col=c("blue"))

# Calcualtion (confirmative )
summary(lm1$residuals)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -4.5432 -2.3647 -0.1252  0.0000  1.4096  6.8727
# Since mean is 0 , so it confirms the linearity of residual. 

# 2. Independence of residuals
# Graphical
acf(lm1$residuals)
#  Updown, shows that the variables are independent

# Calcualtion
# packages.install(cars)
library(car)
durbinWatsonTest(lm1)

#  p-value < 0.05, there is not independence. ie. the residuals are dependent, ie the assumption failed

#3. Test of normality of residuals
# Graphical
plot(lm1, which = 2, col=c("blue"))

# Confirmative test
shapiro.test(lm1$residuals)
# data:  lm1$residuals
# W = 0.94508, p-value = 0.1044
# p-value > 0.05 , means that the residuals follow normal distribution

# 4. Equal variance (homoscedasticity)
plot(lm1, which = 3, col=c("blue"))
#  if random then equal variance else not equal variance. it seems random

# confirmative test
# install.packages("lmtest")
library(lmtest)
bptest(lm1)
# data:  lm1$residuals
# W = 0.94508, p-value = 0.1044
# p-value is > 0.05, so there is equal variance

#  IF LINE is valid After BLUE then we can predict
p<- as.data.frame(6)
colnames(p) <- "wt"
predict(p)


# Outliers, Leverage points, and influential observations in linear model
plot(lm1, which=4, col=c("blue"))
