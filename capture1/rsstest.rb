# coding: utf-8
require "rss"

rss = RSS::Maker.make("2.0") do |maker|
  # フィードの言語
  maker.channel.language = "ja"
  # フィード作成者
  maker.channel.author = "hoge"
  # フィード更新時刻
  maker.channel.updated = Time.now.to_s
  # フィードURL
  maker.channel.link = "https://www.ruby-lang.org/ja/feeds/news.rss"
  # フィードの名前
  maker.channel.title = "Example Feed"
  # フィードの趣旨
  maker.channel.description = "A longer description of my feed."
  # フィードの項目
  maker.items.new_item do |item|
    # 記事のURL
    item.link = "https://www.ruby-lang.org/ja/news/2014/10/27/ruby-2-1-4-released/"
    # 記事のタイトル
    item.title = "Ruby 2.1.4 リリース"
    # 記事の更新時刻
    item.updated = Time.now.to_s
  end
end

puts rss
