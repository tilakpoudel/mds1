#store the current directory
initial.dir <- getwd()

#change to new directory
setwd("~/projects/tilak/mds1/R-programming")

# load necessary libraries
library(magrittr)

# set the output file (it will bypass R and Rstudio)
sink("result.out")

# load the data set from the folder
iris <- read.csv("data/iris.csv")

# DO the analysis
plot(iris)

# result will appear in the output file
summary(iris)
iris %>% cor(sepal.length,sepal.width)

#Close the output file
sink()

# unload the libraries
detach("package:magrittr")

# change back to original directory
setwd(initial.dir)
