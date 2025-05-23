library(ggplot2)

ggplot(mpg, aes(displ, hwy, color=class))+
  geom_point()

ggplot(data = mpg)+
  geom_point(mapping = aes(x= displ, y=hwy, size=class))

# Warning message:
#   Using size for a discrete variable is not advised. 
# it means, our data should be ordinal, ie. size should be ordered.

# First
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y= hwy, alpha = class))
 # alpha - transparency of the points

# Right
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y= hwy, shape = class))
# shape can be used for max 6 categories.

# Right
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y= hwy), color = "blue")
# set get blue color of scatter plot

ggplot(data=mpg)
  +geom_point(mapping = aes(displ, y = hwy))
# the + should be just above not on new line
# Error in `+.gg`:
#   ! Cannot use `+` with a single argument.
# ℹ Did you accidentally put `+` on a new line?

ggplot(data=mpg)+
  geom_point(mapping = aes(displ, y = hwy))
# the + should be line by line

# Facets: Face wrap: 
ggplot(data=mpg)+
  geom_point(mapping = aes(x= displ, y = hwy))+
  facet_wrap(~class, nrow=2)
# create the scatter plot (subplot) for every class

# plot combination of two variables
ggplot(data=mpg)+
  geom_point(mapping = aes(x= displ, y = hwy))+
  facet_grid(drv ~ cyl)
# front with 4 wheels has high mileage

str(mpg)

ggplot(data=mpg)+
  geom_point(mapping = aes(x= displ, y = hwy))+
  facet_grid(drv ~ .)

# plots drv with all other variables (horizontal orientation)

ggplot(data=mpg)+
  geom_point(mapping = aes(x= displ, y = hwy))+
  facet_grid(. ~ cyl)
# plots cyl with all other variables (vertical orientation)

# First, fit the line
# see the data and graph
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))

# fit the line that fits the data
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y=hwy))
# `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
# Local Polynomial Regression Fitting

# Second
ggplot(data=mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy, linetype = drv))
# fit line every category of drv

# plot the data and fit line
ggplot(data=mpg)+
  geom_point(mapping = aes(x= displ, y= hwy))+
  geom_smooth(mapping = aes(x=displ, y=hwy))

# or 
ggplot(data=mpg, mapping = aes(x= displ, y= hwy))+
  geom_point()+
  geom_smooth()
# show points and fit the line


# give color for every data
ggplot(data=mpg, mapping = aes(x= displ, y= hwy))+
  geom_point(mapping = aes(color= class))+
  geom_smooth()

ggplot(data=mpg, mapping = aes(x= displ, y= hwy))+
  geom_point(mapping = aes(color= class))+
  geom_smooth(data=filter(mpg, class=="subcompact"), se=FALSE)

str(mpg)
mpg$class <- as.factor(mpg$class)

library(dplyr) # Needed for filter()

ggplot(data=mpg, mapping = aes(x= displ, y= hwy))+
  geom_point(mapping = aes(color= class))+
  geom_smooth(data=filter(mpg, class=="subcompact"), se=FALSE)

# create a bar diagram
ggplot(data=diamonds)+
  stat_count(mapping=aes(x=cut))

ggplot(data= diamonds)+
  geom_bar(mapping = aes(x= cut))

ggplot(data= diamonds) +
  stat_summary(
    mapping = aes(x= cut, y= depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )
# interpretation
# cut = premimum has minimum sd, it has very low variation, it has higher consistency, with minimum varation in depth
# cut = fair has maximum variation

ggplot(data = diamonds)+
  geom_bar(mapping=aes(x= cut, colour = cut))

ggplot(data= diamonds)+
  geom_bar(mapping = aes(x= cut, fill=cut))

# position adjustment happens here
ggplot(data= diamonds) +
  geom_bar(mapping = aes(x= cut, fill = clarity))
# use fill for the categorical variable i.e clarity is categorical variable


ggplot(data= diamonds, mapping = aes(x= cut, fill=clarity))+
  geom_bar(alpha= 1/5, position= "identity")

ggplot(data= diamonds, mapping = aes(x= cut, color=clarity))+
  geom_bar(fill= NA, position="identity")

ggplot(data=diamonds) +
  geom_bar(mapping=aes(x= cut, fill=clarity), position = "fill")

# position dodge
ggplot(data=diamonds) +
  geom_bar(mapping=aes(x= cut, fill=clarity), position = "dodge")



# COORDINATE SYSTEM
ggplot(data=mpg, mapping = aes(x=class, y=hwy))+
  geom_boxplot()

ggplot(data=mpg, mapping=aes(x= class, y= hwy))+
  geom_boxplot()+
  coord_flip()

# create map of newzealand
nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group))+
  geom_polygon(fill="white", color="black")

ggplot(nz, aes(long, lat, group=group))+
  geom_polygon(fill="white", color="black")+
  coord_quickmap()
# coord_quickmap create short and coordinated map, sets aspect ration correctly for maps.

bar <- ggplot(data= diamonds) +
  geom_bar(
    mapping= aes(x= cut, fill= cut),
    show.legend = FALSE,
    width = 1
  )+
  theme(aspect.ratio = 1)+
  labs(x= NULL, y=NULL)

bar+coord_flip()
bar+coord_polar()
