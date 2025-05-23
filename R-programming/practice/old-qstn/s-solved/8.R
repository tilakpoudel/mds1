# Do the followings in R Studio using "airquality" dataset with R script:

data("airquality")

# a. Perform Shapiro-Wilk test on "Wind" variable to check if it follows normal distribution or not.

shapiro_test <- shapiro.test(airquality$Wind)
print(shapiro_test)

# Interpretation:
# Here, the p-value is less than 0.05.
# We reject the null hypothesis.
# Conclusion: The "Wind" variable does not follow a normal distribution.

# b. Perform Bartlett test on "Wind" variable by "Month" variable to check if the variables of Wind are equal or not on Month variable categories.

bartlett_test <- bartlett.test(Wind ~ Month, data = airquality)
print(bartlett_test)

#Interpretation:
# Here, the p-value is greater than 0.05.
# We accept the null hypothesis.
# Conclusion: The variances are equal across the months.

# c. Fit 1-way ANOVA to compare "Wind" variable by "Month" variable and interpret the result carefully.

anova_model <- aov(Wind ~ factor(Month), data = airquality)
summary(anova_model)

# Interpretation:
# Here, the p-value in the ANOVA table is less than 0.05.
# We reject the null hypothesis.
# Conclusion: There are significant differences in the mean wind speed between at least two months.

# d. Fit the TukeyHSD post-hoc test with 95% confidence interval and interpret the result carefully.

tukey_test <- TukeyHSD(anova_model, conf.level = 0.95)
print(tukey_test)

# Interpretation:
# The TukeyHSD test provides pairwise comparisons between the levels of the "Month" variable.
# Here, the confidence interval for a pair does not include 0.
# The means of those months are significantly different at the 95% confidence level.