Hi 20n team,
  Thanks for checking out my solution.

 My first thought on this problem was to download a csv file with ICD-9/10 codes
 and disease names, create a hash of disease names and search the hash for the
 wikipedia article title.

 Then I realized ICD-9 codes are often listed in the article.
This solution searches an article to see if it contains an icd code and if it
does, returns true.

The approach is very specific, but not all that sensitive.  ie it will not return
many false positives but does return false negatives for this dataset.

I capped my time at 3 hours including thinking about the problem, wrestling with
the Ubuntu and the tar file and writing code.


Next steps
  - look at the title for keywords/suffixes
  (itis, aria, ema, disease, oma, etc.) and see if the result can be improved

  - create a spam filter type SVM that marks as disease or not


Running the program

  from this directory console: python isDisease.py
  enter a filename from this directory.
