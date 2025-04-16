str(mtcars)
unique(mtcars$gear)
# [1] 4 3 5
# 3 gears

# Normality by category
with(mtcars, shapiro.test(mpg[gear == 3]))
# data:  mpg[gear == 3]
# W = 0.95833, p-value = 0.6634
with(mtcars, shapiro.test(mpg[gear == 4]))
# data:  mpg[gear == 4]
# W = 0.90908, p-value = 0.2076
with(mtcars, shapiro.test(mpg[gear == 5]))
# data:  mpg[gear == 5]
# W = 0.90897, p-value = 0.4614

# Equal variance among categories
# install.packages(car)
library(car)
leveneTest(mpg~gear, data(mtcars))

# Levene's test for hoongenity
Variance(mean = median)

# Classical 1 way anova
summary(aov(mpg~gear, data=mtcars))
# Df Sum Sq Mean Sq F value Pr(>F)   
# gear         1  259.7  259.75   8.995 0.0054 **
#   Residuals   30  866.3   28.88
# p-value < 0.05, Accept H1. Atleast one of the mean pairs are diffrent

# Now use Tukey miltiple comparision of means
mtcars$gear <- as.factor(mtcars$gear)  # Convert gear to factor
TukeyHSD(aov(mpg~gear, data=mtcars))
diff        lwr       upr     p adj
# 4-3  8.426667  3.9234704 12.929863 0.0002088
# 5-3  5.273333 -0.7309284 11.277595 0.0937176
# 5-4 -3.153333 -9.3423846  3.035718 0.4295874

#  it seems gear 4 and 3 are different


# fit linear model
summary(lm(mpg~gear, data = mtcars))
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)   16.107      1.216  13.250 7.87e-14 ***
#   gear4          8.427      1.823   4.621 7.26e-05 ***
#   gear5          5.273      2.431   2.169   0.0384 *  
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# Fischers LSD
pairwise.t.test(mtcars$mpg, mtcars$gear, p.adj="none")
# 3         4    
# 4 7.3e-05 -    
# 5 0.038   0.218

# MULTIPLE PORPORTION TEST
# H0: P1 = P2 = P3
# H1: At least one of the proportions are not equal

table(mtcars$gear)

prop.test(
  x = c(15, 12, 5),
  n = c(32, 32, 32)
)

# sample estimates:
#   prop 1  prop 2  prop 3 
# 0.46875 0.37500 0.15625 

# Rate ration porportion
pooled_mean <- (0.46875 + 0.37500 + 0.15625) / 3;

# data:  c(15, 12, 5) out of c(32, 32, 32)
# X-squared = 7.4062, df = 2, p-value = 0.02465
#  p-value > 0.05, accept H1, 

pairwise.prop.test(
  x = c(15, 12, 5),
  n = c(32, 32, 32),
  correct = F
)

