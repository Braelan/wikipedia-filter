require 'rubygems'
require 'nokogiri'

def writeFile(textfile, directory, item)
    wiki = File.open(directory + '/' + item, 'r')
    nokowiki =  Nokogiri::HTML(wiki)
    textfile.write(nokowiki.css('#mw-content-text')[0].text)
end

def writeTextFiles(directory)
    dir = 0
    Dir.foreach(directory) do |item|
      next if item == '.'  || item == ".."

      n = rand * 10
      if n < 3
        outputText = File.open(directory + 'test' + 'text/' + 'clean'+ item + '.txt', 'w')
      else
        outputText = File.open(directory + 'text/' + 'clean' + item + '.txt', 'w')
      end

        writeFile(outputText, directory, item)

        dir = dir + 1
        if dir > 500
          return true
        end


    end
end


writeTextFiles('/media/braelan/302F-6E98/training/positive')
