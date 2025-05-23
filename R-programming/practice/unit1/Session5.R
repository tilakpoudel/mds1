# The sample() function in R is used for random sampling from a given vector.

# Define a die with values 1 to 6
die <- 1:6  

# 1. Randomly pick one value (without replacement)
sample(x = die, size = 1)  

# 2. Another random pick (without replacement)
sample(x = die, size = 1)  

# 3. Randomly pick one value (with replacement - same as default here)
sample(x = die, size = 1, replace = TRUE)  

# 4. Randomly pick two values (without replacement)
sample(x = die, size = 2)  
# Output example: [1] 3 5  

# 6. Randomly pick two values (with replacement, allowing duplicates)
sample(x = die, size = 2, replace = TRUE)  
# Output example: [1] 2 2  or  [1] 4 6
