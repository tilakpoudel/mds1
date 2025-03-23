# Data to barplot
str(mtcars)

barplot(mtcars$mpg)
hist(mtcars$mpg)

df <- as.data.frame(mtcars)
barplot(df$cyl)

# define as a factor (make category)
f.cyl <- as.factor(df$cyl)
barplot(f.cyl)
# gives error
# make table

# first we need frequecnies of cars with 4, 6, 8 cylinders
table(df$cyl)

# barplot of freq of cylinder data
barplot(table(df$cyl))

# assign to object 
bpd <- table(df$cyl)

# barplot of gear and carb
table(df$gear)
barplot(table(df$gear))

# bar plot of mpg (continuous data)
# define class interval
summary(mtcars$mpg)

range(df$mpg)

r <-33.9 - 10.4
I <- round(sqrt(r))
I
# define braks
# breaks = c (10, 15, 20, 25, 30, 35)
breaks = seq(10, 35, by=5)

# create bins
mpg.bin <- cut(
  df$mpg,
  breaks,
  labels = c("10-15", "15-20", "20-25", "25-30", "30-35")
)

mpg.bin
table(mpg.bin)

barplot(table(mpg.bin))

# creat histogram
hist(df$mpg)

hist(
  df$mpg,
  col ="steelblue",
  main="Histogram of MPG",
  xlab = "MPG",
)
abline(
  v=mean(df$mpg),
  lwd=3,
  lty = 2
)
# lwd = lien widht,
# lty = line types (2 dashed lines) , 1= solid, 2= dashed, 3= dotted, 4 dot and dashed, 5 long dash line, 6 = two dashed line

abline(
  v=median(df$mpg),
  lwd=3,
  lty = 2
)

# if  there are more than 2 items with highest frequency
abline(
  v=3* median(df$mpg) - 2 * mean(df$mpg),
  lwd=3,
  lty = 2
)

# check with media
qqnorm(df$mpg)

# calculate the mode grpjically
max_bin_index <- which.max(df$counts)
mode_bin_center <- hist_obj$mids[max_bin_index]

