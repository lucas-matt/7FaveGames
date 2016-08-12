library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

replaceRoman <- function(vect) {
  numerals <- c("xviii", "xvii", "xiii", "viii", "xiv", "xvi", "xix", "vii", "iii", "xii", "ii", "iv", "vi", "ix", "xi", "xv", "xx", "i", "v", "x")
  numbers <- c(18, 17, 13, 8, 14, 16, 19, 7, 3, 12, 2, 4, 6, 9, 11, 15, 20, 1, 5, 10)
  for (i in c(1:length(numerals))) {
    vect <- gsub(paste("\\b", numerals[i], "\\b", sep=""), numbers[i], vect)
    vect <- gsub(paste("\\b", toupper(numerals[i]), "\\b", sep=""), numbers[i], vect)
  }
  return(vect)
}

data <- read.csv("7favegames.csv", row.names=NULL, stringsAsFactors = FALSE)
tweets <- data$text
tweets <- enc2utf8(tweets)
tweets <- replaceRoman(tweets)
# remove accented characters
tweets <- iconv(tweets, to='ASCII//TRANSLIT')
corpus <- Corpus(VectorSource(tweets))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, PlainTextDocument)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, c("7favegames", "amp", "rt", "lol", "follow", "twitter", "series", "new", "super", stopwords("english")))

# plot word cloud
pal <- brewer.pal(8,"Dark2")
wordcloud(corpus, max.words = 200, random.order=TRUE, scale=c(5, .5), colors = pal)
