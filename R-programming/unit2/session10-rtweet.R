# install.packages('tweetR')
# is was not found so installed rtweet package

# install.packages('rtweet')
# install.packages('tm')
# rtweet

library('rtweet')

load(file="data/rmdTweets.RData")

tweets <- rdmTweets
str(tweets)

(n.tweet <- length(tweets))

strwrap(tweets[[154]]$text, width=52)

# get first 3 tweets
tweets[1:3]

# convert to data frame
df <- lwListToDF(tweets)
str(df)

# load text mining library
library('tm')

# build corpus
myCorpus <- Corpus(VectorSource(df$text))

inspect(myCorpus[1:3])


# 3 steps while doing text mining
# 1. convert to lower case
myCorpus <- tm_map(myCorpus, lower)
#2. remove number, 
#3. remove punctation

# Stemming => run, runs, runnig, convert similar word to run



