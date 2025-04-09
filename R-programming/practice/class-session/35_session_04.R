initial.dir <- getwd()
setwd("D:/Master's/I Semester/Statistical Computing with R/Test")
library(magrittr)
sink("session4.out")
iris <- read.csv("iris.csv")
plot(iris)
summary(iris)
iris %>% cor(Sepal.Length,Sepal.Width)
sink()
detach("package:magrittr")
setwd(initial.dir)

iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learningdatabases/iris/iris.data"), header = FALSE)
head(iris)

names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

initial.dir <- getwd()
setwd("D:/Master's/I Semester/Statistical Computing with R/Test")
write.csv(export_from_internet_iris, “iris.csv”)
setwd(initial.dir)

iris$Sepal.Length.SQRT <- iris$Sepal.Length %>% sqrt()
iris$Sepal.Length %<>% sqrt

set.seed(123)
rnorm(200) %>% 
matrix(ncol = 2) %T>% 
plot %>% 
colSums()

iris %>% 
  subset(Sepal.Length > mean(Sepal.Length)) %$% cor(Sepal.Length, Sepal.Width)

cor(iris$Sepal.Length, iris$Sepal.Width)

