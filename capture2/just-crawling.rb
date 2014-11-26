# coding: utf-8
require 'anemone'

# クロールの起点となるURLを指定
urls = ["http://amazon.co.jp/gp/bestsellers/books/",
       "http://amazon.co.jp/gp/bestsellers/digital-text/2275256051/"]

Anemone.crawl(urls, :depth_limit => 2,
              :skip_query_strings => true) do |anemone|
  # 巡回先の絞込
  anemone.focus_crawl do |page|
    page.links.keep_if{|link| link.to_s.match(
      /\/gp\/bestsellers\/books|\/gp\/bestsellers\/digital-text/)}
  end

  # 取得したページに対する処理
  anemone.on_every_page do |page|
    puts page.url
  end
end
