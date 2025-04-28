# Title: Social Network Analysis of PDF Texts, Purports from 108 important BG slokas by HGD Srila Prabhupada.


library(pdftools)
library(tm)
library(SnowballC)
library(magrittr)
library(Rgraphviz)
library(wordcloud)

# Set working directory
setwd("/home/tilak/projects/tilak/mds1/projects/")

# Read PDF files
files <- list.files(pattern = "pdf$")
pdf_files <- lapply(files, pdf_text)

# Create text corpus
corpus <- Corpus(VectorSource(unlist(pdf_files)))

# Text preprocessing
corpus <- corpus %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removeWords, stopwords("english")) %>%
  tm_map(content_transformer(removePunctuation)) %>%
  tm_map(content_transformer(removeNumbers)) %>%
  tm_map(stripWhitespace) %>%
  tm_map(stemDocument)

# Create Term-Document Matrix
tdm <- TermDocumentMatrix(corpus, control = list(wordLengths = c(4, Inf)))

# Word frequency
mat <- as.matrix(tdm)
freq <- sort(rowSums(mat), decreasing = TRUE)

print(head(freq, 10))

# Word cloud
wordcloud(words = names(freq), freq = freq, min.freq = 5, random.order = FALSE, colors = brewer.pal(8, "Dark2"))

# Visualizing Word Relationships (Clustering)
# Reduce matrix size
tdm2 <- removeSparseTerms(tdm, 0.95)

# I want to see the most frequent words
# Convert to data frame
tdm2_df <- as.data.frame(as.matrix(tdm2))
tdm2_df$word <- rownames(tdm2_df)
tdm2_df <- tdm2_df %>%
  select(word, everything()) %>%
  arrange(desc(rowSums(tdm2_df[, -1])))
# Print most frequent words
print(head(tdm2_df))
# Create a word cloud

# Convert to matrix
m <- as.matrix(tdm2)

# Compute distances
distMatrix <- dist(scale(m))

# Hierarchical clustering
fit <- hclust(distMatrix, method = "ward.D2")

# Plot dendrogram of the clusters
plot(fit, main = "Cluster Dendrogram of Frequent Words", xlab = "", sub = "")

# Cut tree into k clusters

# Step 1: Remove sparse terms
tdm2 <- removeSparseTerms(tdm, 0.95)
m <- as.matrix(tdm2)

# Step 2: Calculate word frequencies
word_freq <- rowSums(m)
word_freq_sorted <- sort(word_freq, decreasing = TRUE)

# Step 3: Select top 20 most frequent words
top_words <- names(word_freq_sorted)[1:20]
print(top_words)
# Step 4: Subset the matrix to only those words
m_top <- m[top_words, ]

# Step 5: Compute distances and cluster
distMatrix <- dist(scale(m_top))
fit <- hclust(distMatrix, method = "ward.D2")

# Step 6: Plot colored dendrogram
library(dendextend)

dend <- as.dendrogram(fit)
dend_colored <- color_branches(dend, k = 4)

plot(dend_colored, main = "Clustered Dendrogram (Top 20 Words)", ylab = "Height")
rect.hclust(fit, k = 4, border = 2:5)


# Step 7: Cut into 4 groups and examine
groups <- cutree(fit, k = 4)
print(groups)

# See words by cluster
split(names(groups), groups)



