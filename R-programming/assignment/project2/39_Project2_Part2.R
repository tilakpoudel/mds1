old_directory <- getwd()
old_directory

# install.packages("BiocManager")
# install.packages("Rgraphviz")
# install.packages('haven')
# install.packages('SnowballC')

suppressWarnings({
    library(pdftools)
    library(tm)
    library(magrittr)
    library(Rgraphviz)
    library(wordcloud)
})

setwd("/home/tilak/projects/tilak/mds1/R-programming/assignment/project2/MDS503P2")
files <- list.files(pattern = "pdf$")
length(files)

pdf_files <- lapply(files, pdf_text)
corpus <- Corpus(VectorSource(unlist(pdf_files)))
inspect(corpus[1])

corpus_copy <- corpus
suppressWarnings({
corpus <- tm_map(corpus, tolower)
})
inspect(corpus[1:2])


suppressWarnings({
    corpus <- tm_map(corpus, removePunctuation)
    corpus <- tm_map(corpus, removeNumbers)
    corpus <- tm_map(corpus, stemDocument)
})
corpus_copy <- corpus
tdm <- TermDocumentMatrix(corpus, control = list(wordLengths = c(1, Inf)))
low_frequent_terms <- findFreqTerms(tdm, lowfreq = 25)
head(low_frequent_terms)

suppressWarnings({
    mat <- as.matrix(tdm)
    freq <- mat %>% rowSums() %>%
    sort(decreasing = TRUE)
    wordcloud(words = names(freq), freq = freq, min.freq = 4, random.order = FALSE)
})