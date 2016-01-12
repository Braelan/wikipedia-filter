require 'rubygems'
require 'nokogiri'

def writeFile(hugeFile, item)
    wiki = File.open('/media/braelan/302F-6E98/training/positive/' + item, 'r')
    nokowiki =  Nokogiri::HTML(wiki)
    hugeFile.write(nokowiki.css('#mw-content-text')[0].text)
end

def writeHugeFile
    n = 1
    output = File.open('/media/braelan/302F-6E98/training/large.txt', 'w')

    Dir.foreach('/media/braelan/302F-6E98/training/positive') do |item|
      next if item == '.'  || item == ".."
      if n < 10
        writeFile(output, item)
      end
      n = n + 1
    end
end

writeHugeFile()
