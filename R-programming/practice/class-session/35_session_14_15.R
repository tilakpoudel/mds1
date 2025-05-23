
aq <- airquality
str(aq)

#ozone variable of aq dataframe
hist(aq$Ozone)
plot(density(aq$Ozone,
             na.rm = T))
qqnorm(aq$Ozone)
qqline(aq$Ozone,
       col = 2)
shapiro.test(aq$Ozone)

#solar radiation variable
hist(aq$Solar.R)
plot(density(aq$Solar.R,
             na.rm = T))
qqnorm(aq$Solar.R)
qqline(aq$Solar.R,
       col = 2)
shapiro.test(aq$Solar.R)


#wind variable
hist(aq$Wind)
plot(density(aq$Wind,
             na.rm = T))
qqnorm(aq$Wind)
qqline(aq$Wind,
       col = 2)
shapiro.test(aq$Wind)

hist(cars$speed)
plot(density(cars$speed,
             na.rm = T))
qqnorm(cars$speed)
qqline(cars$speed,
       col = 2)
shapiro.test(cars$speed)


x <- rnorm(500)
y <- x + rnorm(500)
#data with date
my_ts <- ts(matrix(rnorm(500),
                   nrow  = 500,
                   ncol = 1),
            start = c(1950,1),
            frequency = 12)
my_dates <- seq(as.Date("2005/1/1"),
                by = "month",
                length = 50)
#transforming as factor
my_factor <- factor(mtcars$cyl)
fun <- function(x) x^2
#create a window for graphs in 2 rows and 3 columns
par(mfrow = c(2,3))
plot(x,
     y,
     main="Scatterplot")
plot(my_factor,
     main = "Barplot")
plot(my_factor, rnorm(32),
     main = "Boxplot")
plot(my_ts,
     main = "Time series")
plot(my_dates,
     rnorm(50),
     main = "Time based plot")
plot(fun,
     0,
     10,
     main = "Plot a function")

#graph is default mode
par(mfrow = c(1,1))
plot(x,
     y,
     main="Scatterplot")
plot(trees[, 1:3],
     main = "Correlation plot")
str(trees)

#goodness of fit is used if 
#shapiro.test is used if sample is less than 100 (small test) otherwise kolmogorov sminov test
#if the data is linear then use Pearson test otherwise Spearson

j <- 1:20
k <- j
par(mfrow = c(1,3))
plot(j,
     k,
     type = "l",
     main = "type = 'l'")
plot(j,
     k,
     type = "s",
     main = "type = 's'")
plot(j,
     k,
     type = "p",main = "type = 'p'")
par(mfrow = c(1,1))


par(mfrow = c(1,3))
plot(j,
     k,
     type = "o",
     main = "type = 'o'")
plot(j,
     k,
     type = "b",
     main = "type = 'b'")
plot(j,
     k,
     type = "h",
     main = "type = 'h'")
par(mfrow = c(1,1))

r <- c(sapply(seq(5,25,5),
              function(i)rep(i,5)))
t <- rep(seq(25,5,-5),5)
plot(r,
     t,
     pch = 1:25,
     cex = 2,
     yaxt = "n",
     xaxt = "n",
     ann = F,
     xlim = c(3,27),
     lwd = 1:3)
text(r - 1.5, t, 1:25)
plot(x,
     y,
     pch = 21,
     bg = "red",#fill colour
     col = "blue",#border colour
     cex = 3,#symbol size
     lwd = 3)#border width

plot(x,
     y,
     main = expression(alpha[1]^2 + frac(beta,3)))
#install.packages("latex2exp")
library(latex2exp)
plot(x,
     y,
     main = TeX('$\\beta^3,\\beta \\in 1 \\Idots 10$'))

############################################################################
library(igraph)
g <- graph(c(1,2))
plot(g)
plot(g,
     vertex.color = "green",
     vertex.size = 40,
     edge.color = "red",
     edge.size = 20)
h <- graph(c(1,2,2,3,3,4,4,1))
plot(h,
     vertex.color = "green",
     vertex.size = 40,
     edge.color = "red",
     edge.size = 20)
i <- graph(c(1,2,2,3,3,4,4,1),
           directed = F)
plot(i,
     vertex.color = "green",
     vertex.size = 40,
     edge.color = "red",
     edge.size = 20)
j <- graph(c(1,2,2,3,3,4,4,1),
           directed = F,
           n = 7)
plot(j,
     vertex.color = "green",
     vertex.size = 40,
     edge.color = "red",
     edge.size = 20)
j[]
g1 <- graph(c("Sita", "Ram", "Ram", "Rita", "Rita", "Sita", "Sita", "Rita", "Anju", "Ram"))
plot(g1,
     vertex.color = "green",
     vertex.size = 40,
     edge.color = "red",
     edge.size = 5)
g1[]
degree(g1)
diameter(g1,
         directed = F,
         weights = NA)
edge_density(g1,
             loops = F)
ecount(g1)/(vcount(g1)*(vcount(g1)-1))
reciprocity(g1)
closeness(g1,
          mode = "all",
          weights = NA)
betweenness(g1,
            directed = T,
            weights = NA)

