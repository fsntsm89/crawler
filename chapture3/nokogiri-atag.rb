require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://yahoo.co.jp'))

nodesets = doc.xpath('//a')
puts nodesets.inner_text

nodesets.each do |node|
  puts node.inner_text
end
