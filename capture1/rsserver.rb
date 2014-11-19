# coding: utf-8
require "cgi"
require "open-uri"
require "rss"

def parse(page_source)
  dates = page_source.scan(%r!(¥d+)年 ?(¥d+)月 ?(¥d+)日<br />!)
  url_titles = page_source.scan(%r!^<a href="(.+?)">(.+?)</a><br />!)

  url_titles.zip(dates).map{|(aurl, atitle),
                             ymd|[CGI.unescapeHTML(aurl),
                                  CGI.unescapeHTML(atitle), Time.local(*ymd)]}
end

def format_text(title, url, url_title_time_ary)
  s = "Title: #{title}\nURL: #{url}\n\n"
  url_title_time_ary.each do |aurl, atitle, atime|
    s << "* (#{atime})#{atitle}\n"
    s << "    #{aurl}\n"
  end
  s
end

def format_rss(title, url, url_title_time_ary)
  rss = RSS::Maker.make("2.0") do |maker|
    # フィード更新時刻
    maker.channel.updated = Time.now.to_s
    # フィードURL
    maker.channel.link = url
    # フィードの名前
    maker.channel.title = title
    # フィードの趣旨
    maker.channel.description = title
    url_title_time_ary.each do |aurl, atitle, atime|
      maker.items.new_item do |item|
        # フィードURL
        item.link = aurl
        # フィードの名前
        item.title = atitle
        # フィード更新時刻
        item.updated = atime
        # フィードの趣旨
        item.description = atitle
      end
    end
  end
end
