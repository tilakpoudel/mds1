# Display multiple graphs in single window
x <- rnorm(500)
y <- x + rnorm(500)

# data 
my_ts <- ts(
  matrix(
    rnorm(500),
    nrow = 500,
    ncol = 1),
  start = c(1950, 1),
  frequency = 12
)

my_dates <- seq(
  as.Date("2005/1/1"),
  by = "month",
  length = 50
)

my_factor <- factor(mtcars$cyl)

fun <- function(x) x^2

# create a window for graphs in 2 rows and 3 columns
par(mfrow = c(2,3))
plot(x,y, main="Scatterplot")
plot(my_factor, main="Barplot")
plot(my_factor, rnorm(32), main="Boxplot")
plot(my_ts,  main= "Time series")
plot(my_dates, rnorm(50), main = "Time based plot")
plot(fun, 0, 10, main="PLot a function")

# Reset to default mode
par(mfrow=c(1,1))
plot(x, y, main = "Sctterplot")

abline(
  v=mean(x),
  lwd=3,
  lty = 2
)

# With out calculation of scatter plot , donot 
# if linear pearson
# if not then cant use pearson, use spearson correlation coeffectient

# Correlation matrix plot
plot(trees[, 1:3], main="Correlation plot")

# intepreatation 
# there is correlation between girth and volume only

# plot type 
j <- 1:20
k <-j

par(mfrow=c(1,3))
plot(j,k, type="l", main="L")
plot(j,k, type="l", main="L", pch = 16)


# 
# r <- c(
#   sapply(
#     seq
#   )
# )

# usage of log
# Sometimes we may need to transform the data , we can use them.
x <- 1:50
y <- x^3
logx <- log(x)
logy <- log(y)
par(mfrow=c(2,2))
plot(x, y)
plot(x, logy)
plot(logx, y)
plot(logx, logy)
par(mfrow=c(1,1))
