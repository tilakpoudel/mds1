VADeaths
gd <- as.data.frame(VADeaths)
View(gd)
barplot(gd$'Rural Male')
barplot(gd$`Rural Male`,horiz = T, names.arg = c("50-54", "55-59", "60-64", "65-69", "70-74"), main = "Death Rate in Virginia, USA", xlab = "Age group", ylab = "Rate", col = "blue", border = "red", xlim = c(0,70), cex.axis = 0.8)

gdm <- as.matrix(gd)
barplot(gdm, col = c("lightblue", "mistyrose", "lightcyan", "lavender", "cornsilk"), legend = rownames(gd))
#define a set of colors
my_colors <- c("lightblue", "mistyrose", "lightcyan", "lavender", "cornsilk")
#Bar plot
barplot(gdm, col = my_colors)
#add legend
legend("topright", legend = rownames(gdm), fill = my_colors, box.lty = 0, cex = 0.8)

barplot(gdm, col = c("lightblue", "mistyrose", "lightcyan", "lavender", "cornsilk"), legend = rownames(gdm), beside = T)
legend("topright", legend = rownames(gdm), fill = my_colors, box.lty = 0, cex = 0.8)

gdcar <- as.data.frame(cars)
gdcar
summary(gdcar)
hist(gdcar$speed, col = "lightblue", border = "red", xlab = "Speed", main = "Histogram of Car Speed")
hist(gdcar$speed, col = "lightblue", border = "red", xlab = "Speed", main = "Histogram of Car Speed", breaks = 10)
#Q-Q plot
qqnorm(gdcar$speed)
#Q-Q line
qqline(gdcar$speed, col = "red")
#density plot using cars dataset
dens <- density(cars$speed)
#plot density
plot(dens, frame = F, col = "steelblue", main = "Density plot of mpg")
polygon(dens, col = "steelblue")

gd <- as.data.frame(VADeaths)
pie(gd$`Rural Male`, labels = rownames(gd), radius = 1, col = c("red", "blue", "black", "green","yellow"))
#adding % and legend
gd$piepercent <- round(100*gd$`Rural Male`/sum(gd$`Rural Male`), 1)
#piechart
pie(gd$`Rural Male`,
    labels = gd$piepercent,
    main = "% Deaths by Age groups for Rural Male",
    col = rainbow(length(gd$`Rural Male`)))
legend("topright",
       c("50-54", "55-59", "60-64", "65-69", "70-74"),
       cex = 0.8,
       fill = rainbow(length(gd$`Rural Male`)))
plot(gdcar$speed)
plot(gdcar$speed, type="o")

plot(gdcar$speed, gdcar$dist, main = "Speed Vs Displacement", xlab = "Speed", ylab = "Displacement")
#pearson is for straight line data
#spearman for other line

boxplot(gdcar$speed)
#Box Plot
boxplot(mpg~cyl, data = mtcars)
#Tukey Box Plot
boxplot(mpg~gear, data = mtcars, xlab = "Number of cylinders", ylab = "Miles Per Gallon", main = "Mileage Data")

str(mtcars)
barplot(mtcars$mpg, xlab = "MPG", ylab = "Frequency")
hist(mtcars$mpg, xlab = "MPG", ylab = "Frequency")
View(mtcars)
dens1 <- density(mtcars$mpg)
plot(dens1)
plot(dens1, frame = F, col = "steelblue", main = "Density plot of mpg of mtcars")
polygon(dens1, col = "steelblue")
boxplot(mtcars$mpg)
#define as data frame, if required
df <- as.data.frame(mtcars)
#bar plot of cylinder data
barplot(df$cyl)
#define cyl as a factor variable
f.cyl <- as.factor(df$cyl)
#bar plot of cylinder data
barplot(f.cyl)
#first we need frequencies of cars
table(df$f.cyl)
#bar plot of freq. of cylinder data
barplot(table(df$cyl))
#we can assign this as object
bpd <- table(df$cyl)
#get the barplot
barplot(bpd)
f.gear <- as.factor(mtcars$gear)
table(f.gear)
barplot(table(f.gear))
barplot(table(as.factor(mtcars$carb)))
hist(df$mpg, col = "steelblue", main = "Histogram of MPG", xlab = "MPG Categories")
abline(v=median(df$mpg), lwd = 3, lty = 2)
IQR(df$mpg)

#scatterplot with abline
plot(df$mpg, df$wt, pch = 16, main = "Scatterplot of MPG and Weight", xlab = "MPG", ylab = "Weight")
abline(h=2, col = "blue", lwd = 2)
abline(h=4, col = "blue", lwd = 2)

plot(df$wt, df$mpg, pch = 16)
abline(h=mean(df$mpg), lwd = 2, col = "red")
abline(h=mean(df$mpg)+1*sd(df$mpg), col = "blue", lwd = 3, lty = 2)
abline(h=mean(df$mpg)-1*sd(df$mpg), col = "blue", lwd = 3, lty = 2)

plot(df$wt, df$mpg, main = "Scatterplot with abline", xlab = "Weight", ylab = "MPG")
reg_mod <- lm(df$mpg~df$wt)
abline(reg_mod)
plot(df$wt, df$mpg, main = "Scatterplot with abline", xlab = "Weight", ylab = "MPG")
abline(lm(df$mpg~df$wt))

plot(df$hp, df$disp, main = "Scatterplot with model abline", xlab = "Horse power", ylab = "Displacement")
abline(lm(df$disp~df$hp))
lines(lowess(df$hp, df$disp), col = )