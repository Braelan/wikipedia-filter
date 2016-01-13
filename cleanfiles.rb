require 'rubygems'
require 'nokogiri'

def writeFile(textfile, directory, item)
    wiki = File.open(directory + '/' + item, 'r')
    nokowiki =  Nokogiri::HTML(wiki)
    textfile.write(nokowiki.css('#mw-content-text')[0].text)
end

def makeDirectories(directory)
  # stem = directory.split('/').last
  Dir.mkdir directory + 'testtext'
  Dir.mkdir directory + 'text'
end


# make a hash of file names so they can be randomly sampled
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

# make an array of the specified length for the sample
def randomArray(directoryLength, arrayLength)
    array = []
  0.upto(directoryLength) {|num| array << num}
  array.shuffle!
  array.slice(0, arrayLength)
end

#randomly assign a file to either a test or a train folder
def splitData(directory, item)
    n = rand * 10
    if n < 3
      outputText = File.open(directory + 'test' + 'text/' + 'clean'+ item + '.txt', 'w')
    else
      outputText = File.open(directory + 'text/' + 'clean' + item + '.txt', 'w')
    end
      writeFile(outputText, directory, item)
end

#Use a random array to sample file names
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

# /media/braelan/302F-6E98/training/

def run
  puts "Please specify a full path to the training directory (leading and trailing '/')"
  directory = gets.chomp
  cleanAndPartition(directory + 'positive', 5)
  cleanAndPartition(directory + 'negative',5)
end

run()
