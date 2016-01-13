
# filenames <- dir(path="/media/braelan/302F-6E98/training/dfsetuptext", pattern="*.txt", all.files=TRUE,
#                 full.names=TRUE, include.dirs=FALSE )
#cleanDf <-lapply(filenames, function(x) read.csv(x, header = FALSE)) 
library('wordcloud')
library('tm')
library('e1071')

# read all the files from a directory and process them
cleanCorpus <- function(directory) {
  normCloud <- Corpus(DirSource(directory))
  normCloud <- tm_map(normCloud, stripWhitespace)
  normCloud <- tm_map(normCloud, tolower)
  normCloud <- tm_map(normCloud, PlainTextDocument)
  normCloud <- tm_map(normCloud, removePunctuation)
  normCloud <- tm_map(normCloud, removeWords, stopwords("english"))
  return( tm_map(normCloud, stemDocument))
}

#make a document term matrices showing word frequency for negatives, positives, and a test set
raw_negatives <- cleanCorpus("/media/braelan/302F-6E98/training/negativetext/")
meta(raw_negatives, "disease") <- "no"
negative_dtm <-DocumentTermMatrix(raw_negatives)

raw_positives <- cleanCorpus("/media/braelan/302F-6E98/training/positivetext/")
meta(raw_positives, "disease") <- "yes"
positive_dtm <-DocumentTermMatrix(raw_negatives)

raw_negative_test <- cleanCorpus("/media/braelan/302F-6E98/training/negativetesttext/")
#negative_test_dtm <-DocumentTermMatrix(raw_negative_test)
raw_positive_test <- cleanCorpus("/media/braelan/302F-6E98/training/positivetesttext/")
#positive_test_dtm <-DocumentTermMatrix(raw_positive_test)


newCloud <- c(raw_positives, raw_negatives)
newCloud_dtm <- DocumentTermMatrix(newCloud)



allFreq5 <- findFreqTerms(newCloud_dtm, 5) 
all_train <- DocumentTermMatrix(newCloud, control= list( dictionary = allFreq5))
positive_test <- DocumentTermMatrix(raw_positive_test, control= list(dictionary = allFreq5))
negative_test <- DocumentTermMatrix(raw_negative_test, control= list(dictionary = allFreq5))


#turn counts of words into binaries that can be used for bayes
count_to_binary <- function(x)  {
  y <- ifelse( x>0 , 1 , 0)
  y <- factor(y, levels=c(0,1), labels=c("No", "Yes"))
  y
}

all_train <-apply(all_train, 2, count_to_binary)
positive_test <- apply(positive_test, 2, count_to_binary)
negative_test <- apply(negative_test, 2, count_to_binary)


disease_classifier <- naiveBayes(all_train, factor(meta(newCloud)$disease))

disease_test_pred <- predict(disease_classifier, newdata=negative_test)
normal_test_pred <- predict(disease_classifier, newdata=positive_test)



