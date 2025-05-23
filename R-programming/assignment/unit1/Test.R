#store the current directory
initial.dir <- getwd()

#change to new directory
setwd("~/projects/tilak/mds1/R-programming")

# load necessary libraries
library(magrittr)

# set the output file (it will bypass R and Rstudio)
sink("session3.out")

# load the data set from the folder
iris <- read.csv("data/iris-data.csv")

# DO the analysis
plot(iris)

# result will appear in the output file
summary(iris)

# Correlation between sepal length and width
# iris %>% cor(Sepal.Length, Sepal.Width)
# Problem:
# iris (a data frame) is passed as the first argument to cor(),
# cor() expects either two numeric vectors or a numeric matrix, but iris
# contains a Species column (a factor/string).
# Also, Sepal.Length and Sepal.Width are not recognized correctly as separate columns.

cor(iris$Sepal.Length, iris$Sepal.Width)

#Close the output file
sink()

# unload the libraries
detach("package:magrittr")

# change back to original directory
setwd(initial.dir)
