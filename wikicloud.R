library('tm')
cloud <- Corpus(DirSource("/media/braelan/302F-6E98/training/wordcloud/"))
cloud <- tm_map(cloud, stripWhitespace)
cloud <- tm_map(cloud, tolower)
cloud <- tm_map(cloud, PlainTextDocument)
cloud <- tm_map(cloud, removeWords, stopwords("english"))
cloud <- tm_map(cloud, stemDocument)

# wordcloud(cloud, scale= c(5, 0.5), max.words = 100, randome.order = FALSE, rot.per =  0.35, use.r.layout = FALSE, colors=brewer.pal(8, "Dark2"))