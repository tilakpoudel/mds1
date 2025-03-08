# use jsonlite package to load json data from api.

install.packages("jsonlite")
library(jsonlite)

Raw <- fromJSON("https://data.ny.gov/api/views/9a8c-vfzj/rows.json?accessType=DOWNLOAD")

food_market <- Raw[['data']]
str(food_market)
head(food_market)
Names <- food_market[,14]
head(Names)

table(Names) # get frequency of unique values

table(V19)

table(food_market$V19)

table(food_market[,19])

# always use to see the few records for large data
head(table(food_market[,19]))

# convert the data to data frame
df_food_market <- as.data.frame(food_market)
head(df_food_market)
