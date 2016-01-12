import re

def returnTitle(article_text):
    strings = re.findall(r'(<title>)([^-]*)', article_text)
    return strings[0][1]

file_name = raw_input('input filename:')

article = open(file_name, 'r')

lines = article.read()

answer = lines.find("International_Statistical_Classification_of_Diseases_and_Related_Health_Problems")

if answer != -1:
    print( returnTitle(lines))
    print("this is a disease article")
else:
    print("not a disease article")
