# ggplot2

library(ggplot2)
ggplot()+
  layer(
    data = diamonds, mapping = aes(x=carat, y=price),
    geom = "point", stat="identity", position = "identity"
    )+
  scale_y_continuous()+
  scale_x_continuous()+
  coord_cartesian()

# every + is a new layer

# default
ggplot(diamonds, aes(carat, price))+
  geom_point()+
  scale_x_continuous()+
  scale_y_continuous()


 # scale not define
ggplot(diamonds, aes(carat, price))+
  geom_point()

str(diamonds)

# quick plot (alxi plot), not recommended
qplot(carat, price, data = diamonds)

# fit linear model and add line, log lowering the values 
ggplot(diamonds, aes(
  carat, price
)) +
  geom_point()+
  stat_smooth(method = lm)+
  scale_x_log10()+
  scale_y_log10()

# quick plot
qplot(
  carat, 
  price, 
  data = diamonds, 
  geom = c("point", "smooth"), 
  method="lm", 
  log="xy"
)

# plot the histogram
ggplot(
  data = diamonds,
  mapping = aes(price)
)+
  (geom_histogram(stat = "bin", position = "identity"))

# OR
ggplot(diamonds, aes(x=price))+
  geom_histogram()

# OR
qplot(price, data=diamonds, geom = "histogram", xlab = "price in $", ylab="count")

# pie chart
ggplot(diamonds, aes(x="", fill=clarity))+
  geom_bar(width = 1)+
  coord_polar(theta="y")+
  theme_void()

# theta = y means degree i.e 360 degree

# 
?mpg
# Do cars with big engies use more fuel than cars with small engiens
# TODO:
# Visualiz it 
# Describe it
# COnfirm it

ggplot(data = mpg)+
  aes(x=displ, y=hwy)+
  geom_point()+
  stat_smooth(method = "lm", se=FALSE)

# It it normal ? the values seems to have outliers
# so to confirm pearson correlation coeffecient
# Correlation test

cor(mpg$displ, mpg$hwy)
# -0.76, high 

cor.test(mpg$displ, mpg$hwy)
# euta dependent value lai 2ota independent variable ma compare garna t-test hunchha
#t = -18.151, df = 232, p-value < 2.2e-16
# the p value < 0.05. we accept H1. So it is linear

