
# filenames <- dir(path="/media/braelan/302F-6E98/training/dfsetuptext", pattern="*.txt", all.files=TRUE,
#                 full.names=TRUE, include.dirs=FALSE )
#cleanDf <-lapply(filenames, function(x) read.csv(x, header = FALSE)) 
library('wordcloud')
library('tm')
cloud <- Corpus(DirSource("/media/braelan/302F-6E98/training/dfsetuptext/"))
cloud <- tm_map(cloud, stripWhitespace)
cloud <- tm_map(cloud, tolower)
cloud <- tm_map(cloud, PlainTextDocument)
cloud <- tm_map(cloud, removePunctuation)
cloud <- tm_map(cloud, removeWords, stopwords("english"))
cloud <- tm_map(cloud, stemDocument)
cloud_dtm <- DocumentTermMatrix(cloud)
meta(cloud, "disease") <- "yes"


normCloud <- Corpus(DirSource("/media/braelan/302F-6E98/training/dfsetupNormtext/"))
normCloud <- tm_map(normCloud, stripWhitespace)
normCloud <- tm_map(normCloud, tolower)
normCloud <- tm_map(normCloud, PlainTextDocument)
normCloud <- tm_map(normCloud, removePunctuation)
normCloud <- tm_map(normCloud, removeWords, stopwords("english"))
normCloud <- tm_map(normCloud, stemDocument)
normCloud_dtm <- DocumentTermMatrix(normCloud)
meta(normCloud, "disease") <- "no"

newCloud <- c(cloud, normCloud)

medFreq5 <- findFreqTerms(cloud_dtm, 5) 
med_train <- DocumentTermMatrix(cloud, control= list( dictionary = medFreq5))


count_to_binary <- function(x)  {
  y <- ifelse( x>0 , 1 , 0)
  y <- factor(y, levels=c(0,1), labels=c("No", "Yes"))
  y
}

