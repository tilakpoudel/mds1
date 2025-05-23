library("NLP")
library("tm")
library("twitteR")
load(file = "C:/Users/user/Downloads/rdmTweets.RData")
tweets <- rdmTweets
str(tweets)
(n.tweet <- length(tweets))
strwrap(tweets[[154]]$text, width = 55)
strwrap(tweets[[154]]$text, width = 62)
tweets[1:3]
df <- twListToDF(tweets)
str(df)
myCorpus <- Corpus(VectorSource(df$text))
inspect(myCorpus[1:3])
#convert to lower case
myCorpus <- tm_map(myCorpus, content_transformer(tolower))
inspect(myCorpus[1:3])
#remove punctuation
myCorpus <- tm_map(myCorpus, removePunctuation)
inspect(myCorpus[1:3])
#remove numbers
myCorpus <- tm_map(myCorpus, removeNumbers)
inspect(myCorpus[1:3])
#remove URLs
removeURL <- function(x) gsub("http[^[:space:]]*", "", x)
myCorpus <- tm_map(myCorpus,removeURL)
inspect(myCorpus[1:3])
myStopwords <- setdiff(stopwords("english"), c("r", "big"))
myCorpus <- tm_map(myCorpus, removeWords, myStopwords)
myCorpus <- tm_map(myCorpus, removeURL)
inspect(myCorpus[1:3])
myCorpusCopy <- myCorpus

library("SnowballC")
myCorpus <- tm_map(myCorpus, stemDocument)
inspect(myCorpus[1:3])
myCorpus <- tm_map(myCorpus, gsub, pattern="posit", replacement="position")
strwrap(myCorpus[154], width = 55)
myTdm <- TermDocumentMatrix(myCorpusCopy, control = list(wordLengths = c(1,Inf)))
str(myTdm)
(freq.terms <- findFreqTerms(myTdm, lowfreq = 10))
findAssocs(myTdm, "r", 0.2)

library(graph)
library(Rgraphviz)
plot(myTdm, term = freq.terms, corThreshold = 0.1, weighting = T)

library(wordcloud)
m <- as.matrix(myTdm)
freq <- sort(rowSums(m), decreasing = T)
wordcloud(words = names(freq), freq = freq, min.freq = 4, random.order = F)
wordcloud(words = names(freq), freq = freq, min.freq = 1, random.order = F)

library(topicmodels)
set.seed(123)
myLda <- LDA(as.DocumentTermMatrix(myTdm), k=5)