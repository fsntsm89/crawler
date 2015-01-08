# coding: utf-8
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://yahoo.co.jp'))

puts doc%'//title'
puts doc/'//title'

# 検索にヒットした最初のノード
puts doc.at('//title')

# xpathの検索にヒットした最初のノード
puts doc.at_xpath('//title')

# cssの検索にヒットした最初のノード
puts doc.at_css('title')

# cssで検索 NodeSet
puts doc.css('title')

# cssで検索 NodeSetから最初のノード
puts doc.css('title')[0]

# xpathかcssで検索 NodeSet
puts doc.search('title')

# xpathかcssで検索 NodeSetから最初のノード
puts doc.search('title')[0]

# xpathで検索 NodeSet
puts doc.xpath('//title')

# xpathで件s区 NodeSetから最初のノード
puts doc.xpath('//title')[0]

# xpathで検索 NodeSetから最初のノードbbun
puts doc.xpath('//title').first

