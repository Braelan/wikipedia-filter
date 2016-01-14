Hi Mark,
  Thanks again for checking out my solution.

  This is an improvement on the Python benchmark and detects disease related articles
  in the dataset with a specificity of 99% and a sensitivity of 91%.  This is based on a random sample
  of 500 articles (to accomodate my hardware in a run time < 10 minutes).






Running the programs:


a) cleaning with Ruby
  console: ruby cleanfiles.rb

  This will ask for a full path to a training directory expected to contain 'positive'
  and 'negative' folders.  It is currently set to randomly sample 500 positive cases and 500 negative cases (can be changed in the ruby file).

  It will take the raw html randomly assign to testing and training sets and get it ready to read into R.

b) Naive Bayes Support Vector Machine with R
    The algorithm calculates probabilities of occurence of words in disease and non-disease articles,
    then predictes the value of a new article based on the words it contains using a naive bayes equation.

    This requires the e1071, tm and wordcloud packages and was built in Rstudio
    The directories in the program must be edited to a local Machine. (marked in the RBayes.R file)
    Once the directory names are changed in the file it can be loaded into the R console in rstudio.

    rstudio console: disease_test_pred
                   : normal_test_pred

    disease_test_pred returns the test results of a run on disease articles.  

    normal_test_pred returns the test results of a run on non-disease articles.

              truth
             pos neg
  test pos  |_a_|_b_|
       neg  | d | c |

    Sensitivity can be calculated as a / a + d
    Specificity can be calculated as c / c + b

  c) print the title
     isDisease.py prints the title of an article in the same directory as the previous solution

  from this directory console: python isDisease.py
  enter a filename from this directory.
