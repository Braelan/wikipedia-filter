require 'rubygems'
require 'nokogiri'

def writeFile(textfile, item)
    wiki = File.open('/media/braelan/302F-6E98/training/dataframeSetupNorm/' + item, 'r')
    nokowiki =  Nokogiri::HTML(wiki)
    textfile.write(nokowiki.css('#mw-content-text')[0].text)
end

def writeTextFiles
    n = 1


    Dir.foreach('/media/braelan/302F-6E98/training/dataframeSetupNorm') do |item|
      next if item == '.'  || item == ".."
      outputText = File.open('/media/braelan/302F-6E98/training/dfsetupNormtext/' + 'clean'+ item + '.txt', 'w')

      if n < 10
        writeFile(outputText, item)
      end
      n = n + 1
    end
end

writeTextFiles()
