#system.file(package = "dplyr")
#subsample is used to take sample from a large data set in order to load to local computer through sub-setting.
library(dplyr)
iris <- read.csv("D:/Master's/I Semester/Statistical Computing with R/iris.csv1")
iris %>% sample_n(size=5)

#iris_sqlite %>% 
  
install.packages("RSQLite")
library(RSQLite)
library(DBI)
#create an ephemeral in-memory
RSQLite database
con 
