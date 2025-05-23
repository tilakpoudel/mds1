# load data from internet
iris <- read.csv(
  url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"),
  header=FALSE)
head(iris)

# Add columns names for V,V2,V3,V4 nd V5 columns to the iris data
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

# See the new column name
head(iris)

# Save the iris data from internet in local computer (includes row names)
write.csv(iris, "~/projects/tilak/mds1/R-programming/data/iris-new.csv")
iris_new <- read.csv('~/projects/tilak/mds1/R-programming/data/iris-new.csv')
head(iris_new) # it has extra column for row name

# Save the iris data in local machine (excludes row names)
write.csv(
  iris,
  "~/projects/tilak/mds1/R-programming/data/iris-data.csv", 
  row.names = FALSE
)

iris_data <- read.csv('~/projects/tilak/mds1/R-programming/data/iris-data.csv')
head(iris_data)  # it has extra column for row name

# Convert the wide format data into long format
library(reshape2)

# Convert iris data set to long format
iris_long <- melt(iris, 
                  id.vars = "Species", 
                  variable.name = "Measurement", 
                  value.name = "Value")
head(iris_long)

# save the iris_long data in the working directory
write.csv(iris_long, "iris_long.csv", row.names = FALSE)

# save the iris_long data in custom directory
write.csv(iris_long, "~/projects/tilak/mds1/R-programming/data/iris_long.csv", row.names = FALSE)
