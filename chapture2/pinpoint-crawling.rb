# coding: utf-8
require 'anemone'

# クロールの起点となるURLを指定
urls = []
urls.push("http://www.amazon.co.jp/gp/bestsellers/digital-text/2275256051/2291657051/")
urls.push("http://www.amazon.co.jp/gp/bestsellers/digital-text/2275256051/2291905051/")
urls.push("http://www.amazon.co.jp/gp/bestsellers/books/466298/")
urls.push("http://www.amazon.co.jp/gp/bestsellers/books/466282/")

Anemone.crawl(urls, :depth_limit => 0) do |anemone|
  # 取得したページに対する処理
  anemone.on_every_page do |page|
    puts page.url
  end
end
