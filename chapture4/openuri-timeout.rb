require 'nokogiri'
require 'open-uri'

urls = []
urls.push("http://www.yahoo.co.jp")

nokogiri_options = {
  :read_timeout => 5
}

urls.each do |url|
  html = open(url, nokogiri_options)
  doc = Nokogiri::HTML(html)
  puts doc.title
  puts url
end








