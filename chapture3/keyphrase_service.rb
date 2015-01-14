# coding: utf-8
require 'open-uri'
require 'rexml/document'
require 'nokogiri'

# configファイルの読み込み
require 'yaml'
@@config = YAML.load_file("../config.yml")

APPLICATION_ID = @@config["yahoo"]["api_key"]
BASE_URL = 'http://jlp.yahooapis.jp/KeyphraseService/V1/extract'

$word_list = Hash::new

def request(text)
  app_id = APPLICATION_ID
  params = "?appid=#{app_id}&output=xml"
  url = "#{BASE_URL}#{params}" + "&sentence=" + URI.encode("#{text}")
  response = open(url)
  doc = REXML::Document.new(response).elements['ResultSet/']
  doc.elements.each('Result') do |element|
    text = element.elements["Keyphrase"][0]
    score = element.elements["Score"][0]
    $word_list["#{text}"] =
      $word_list["#{text}"].nil? ? 1 : $word_list["#{text}"] + 1
  end
end

def get_urls(page_url)
  urls = Array.new()
  uri = URI.parse(page_url)
  doc = Nokogiri::HTML(open(page_url))
  doc.xpath("//*[@id='main']//ul[@class='list']//a").each do |anchor|
    url = anchor[:href]
    url = uri.merge(url) unless uri =~ /^http/
    urls << url
  end
  urls
end

def get_headline_text(page_url)
  text = ""
  doc = Nokogiri::HTML(open(page_url))
  if page_url.to_s.match(/dailynew/)
    text = doc.xpath("//*[@id='detailHeadline']").text
  else
    text = doc.xpath("//*[@id='main']//p[@class='hbody']").text
  end
  text.gsub(/\n/, "")
end

def get(page_url)
  urls = get_urls(page_url)
  urls.each do |url|
    text = get_headline_text(url)
    request(text)
  end
end

page_url = 'http://news.yahoo.co.jp/list/?c=economy'
get(page_url)
$word_list.each do |key, value|
  p "#{key}=#{value}"
end
