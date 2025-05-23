# Association Rule
# Market basket analysis
# Create a list of baskets
market_baskets <- 
  list(
    c("bread", "milk"),
    c("bread", "diapers", "beer", "eggs"),
    c("milk", "diapers", "beer", "cola"),
    c("bread", "milk", "diapers", "beer"),
    c("bread", "milk", "diapers", "cola")
  )

# set transaction names (T1 to T5)
names(market_baskets) <- paste("T", c(1:5), sep="")
market_baskets

# library: association rules (arules)
library(arules)
# Transformation
trans <- as(market_baskets, "transactions")
# dimension
dim(trans)
# Item label
itemLabels(trans)

#  summary
summary(trans)

# plot
image(trans)

# inspect, in list inspect command is used more frequently to see the data if it is correct
inspect(trans)

# Modeling , Apriori algorithm, for frequent item generation
# For large data we may require optimization
# Either support or confidence should be set, prehand
# For large data start with min. confidence 0.5

# Start with support 0.3 (probabilty of buuying a single item 1/6), and confidence 0.5 (50% chance of purchasing)
rules <- apriori(
  trans,
  parameter = list(
      supp= 0.3,
      conf = 0.5,
      maxlen= 10,
      target = "rules"
    )
)
# Note : maxlen = maxlength of items
summary(rules)

# we select median, can't use mean. the 

inspect(rules)
# See items with lift > 1, these are the items of interest the items with lift > 1 are recommended

# Remove the empty rules
rules <- apriori(
  trans,
  parameter = list(
      supp = 0.3,
      conf=0.5,
      minlen=2,
      maxlen= 10,
      target="rules"
  )
)

inspect(rules)

# we set rhs=beer and default = lhs
beer_rules_rhs <- apriori(
  trans,
  parameter = list(
    supp = 0.3,
    conf=0.5,
    minlen=2),
  appearance = list(default="lhs", rhs="beer")
  )
inspect(beer_rules_rhs)
# item bought before beer

# we set lhs=beer and default = rhs
beer_rules_lhs <- apriori(
  trans,
  parameter = list(
    supp = 0.3,
    conf=0.5,
    minlen=2),
  appearance = list(default="rhs", lhs="beer")
)
inspect(beer_rules_lhs)

# Product recommendation


# Visualize rules
library(arulesViz)
plot(rules)
# item with high lift has has dense

plot(rules)

# interactive plot
plot(rules, engine="plotly")

# Graph based visualization
subrules <- head(rules, n = 10, by="confidence")
plot(subrules, method = "graph", engine="htmlwidget")

# Parallel coordinate plot for 10 rules
plot(subrules, method = "paracoord")
