require 'rubygems'
require 'nokogiri'

def writeFile(textfile, directory, item)
    wiki = File.open(directory + '/' + item, 'r')
    nokowiki =  Nokogiri::HTML(wiki)
    textfile.write(nokowiki.css('#mw-content-text')[0].text)
end

# def writeTextFiles(directory)
#     dir = 0
#     makeDirectories(directory)
#
#     Dir.foreach(directory) do |item|
#       next if item == '.'  || item == ".."
#
#       n = rand * 10
#       if n < 3
#         outputText = File.open(directory + 'test' + 'text/' + 'clean'+ item + '.txt', 'w')
#       else
#         outputText = File.open(directory + 'text/' + 'clean' + item + '.txt', 'w')
#       end
#
#         writeFile(outputText, directory, item)
#
#         dir = dir + 1
#         if dir > 500
#           return true
#         end
#
#
#     end
# end

def makeDirectories(directory)
  # stem = directory.split('/').last
  Dir.mkdir directory + 'testtext'
  Dir.mkdir directory + 'text'
end

def hashDirectory(directory)
  count = 0
  hash = {}
  Dir.foreach(directory) do |item|
    next if item == '.' || item == '..'
    hash[count] = item
    count = count + 1
  end
   hash
end



def randomArray(directoryLength, arrayLength)
    array = []
  0.upto(directoryLength) {|num| array << num}
  array.shuffle!
  array.slice(0, arrayLength)
end


def splitData(directory, item)
    n = rand * 10
    if n < 3
      outputText = File.open(directory + 'test' + 'text/' + 'clean'+ item + '.txt', 'w')
    else
      outputText = File.open(directory + 'text/' + 'clean' + item + '.txt', 'w')
    end
      writeFile(outputText, directory, item)
end

def splitDirectory(directory, array, hash)
  array.each do |num|
    splitData(directory, hash[num])
  end
end

def cleanAndPartition(directory, numberOfEndFiles)
  makeDirectories(directory)
  hash = hashDirectory(directory)
  array = randomArray(hash.length, numberOfEndFiles)
  splitDirectory(directory, array, hash)
end


cleanAndPartition('/media/braelan/302F-6E98/training/positive', 500)
cleanAndPartition('/media/braelan/302F-6E98/training/negative',500)
