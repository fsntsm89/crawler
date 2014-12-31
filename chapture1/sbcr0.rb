# coding: utf-8
page_source = open("samplepage.html", &:read)
dates = page_source.scan(%r!(\d+)年 ?(\d+)月 ?(\d+)日<br />!)
puts dates[0, 4]

url_titles = page_source.scan(%r!^<a href="(.+?)">(.+?)</a><br />!)
puts url_titles[0, 4]

puts dates.length
puts url_titles.length

puts dates[0, 2].zip(url_titles[0, 2])
