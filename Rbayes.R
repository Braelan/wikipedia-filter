
# filenames <- dir(path="/media/braelan/302F-6E98/training/dfsetuptext", pattern="*.txt", all.files=TRUE,
#                 full.names=TRUE, include.dirs=FALSE )
#cleanDf <-lapply(filenames, function(x) read.csv(x, header = FALSE)) 
library('wordcloud')
library('tm')
library('e1071')

# create a corpus of plaintextdocuments labeled that they are disease articles
cloud <- Corpus(DirSource("/media/braelan/302F-6E98/training/positivetext/"))
cloud <- tm_map(cloud, stripWhitespace)
cloud <- tm_map(cloud, tolower)
cloud <- tm_map(cloud, PlainTextDocument)
cloud <- tm_map(cloud, removePunctuation)
cloud <- tm_map(cloud, removeWords, stopwords("english"))
cloud <- tm_map(cloud, stemDocument)
cloud_dtm <- DocumentTermMatrix(cloud)
meta(cloud, "disease") <- "yes"

# create a corpus of non-disease articles
normCloud <- Corpus(DirSource("/media/braelan/302F-6E98/training/negativetext/"))
normCloud <- tm_map(normCloud, stripWhitespace)
normCloud <- tm_map(normCloud, tolower)
normCloud <- tm_map(normCloud, PlainTextDocument)
normCloud <- tm_map(normCloud, removePunctuation)
normCloud <- tm_map(normCloud, removeWords, stopwords("english"))
normCloud <- tm_map(normCloud, stemDocument)
normCloud_dtm <- DocumentTermMatrix(normCloud)
meta(normCloud, "disease") <- "no"

cleanCorpus <- function(Directory)
normCloud <- Corpus(DirSource("/media/braelan/302F-6E98/training/negativetext/"))
normCloud <- tm_map(normCloud, stripWhitespace)
normCloud <- tm_map(normCloud, tolower)
normCloud <- tm_map(normCloud, PlainTextDocument)
normCloud <- tm_map(normCloud, removePunctuation)
normCloud <- tm_map(normCloud, removeWords, stopwords("english"))
normCloud <- tm_map(normCloud, stemDocument)
normCloud_dtm <- DocumentTermMatrix(normCloud)
meta(normCloud, "disease") <- "no"

cleanCorpus <- function(directory) {
  normCloud <- Corpus(DirSource(directory))
  normCloud <- tm_map(normCloud, stripWhitespace)
  normCloud <- tm_map(normCloud, tolower)
  normCloud <- tm_map(normCloud, PlainTextDocument)
  normCloud <- tm_map(normCloud, removePunctuation)
  normCloud <- tm_map(normCloud, removeWords, stopwords("english"))
  return( tm_map(normCloud, stemDocument))
}

raw_test <- cleanCorpus("/media/braelan/302F-6E98/training/testtext/")

newCloud <- c(cloud, normCloud)
newCloud_dtm <- DocumentTermMatrix(newCloud)
test_train <-DocumentTermMatrix(raw_test)

allFreq5 <- findFreqTerms(newCloud_dtm, 5) 
all_train <- DocumentTermMatrix(newCloud, control= list( dictionary = allFreq5))
test_train <- DocumentTermMatrix(raw_test, control= list(dictionary = allFreq5))




#turn counts of words into binaries
count_to_binary <- function(x)  {
  y <- ifelse( x>0 , 1 , 0)
  y <- factor(y, levels=c(0,1), labels=c("No", "Yes"))
  y
}

all_train <-apply(all_train, 2, count_to_binary)
test_train <- apply(test_train, 2, count_to_binary)



disease_classifier <- naiveBayes(all_train, factor(meta(newCloud)$disease))

disease_test_pred <- predict(disease_classifier, newdata=test_train)


