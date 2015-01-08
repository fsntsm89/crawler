# coding: utf-8
require 'open-uri'
require 'rexml/document'

# configファイルの読み込み
require 'yaml'
@@config = YAML.load_file("../config.yml")

APPLICATION_ID = @@config["yahoo"]["api_key"]
BASE_URL = 'http://jlp.yahooapis.jp/MAService/V1/parse'

def request(text)
  app_id = APPLICATION_ID
  params = "?appid=#{app_id}&results=uniq&filter=9&uniq_filter=9"
  url = "#{BASE_URL}#{params}" + "&sentence=" + URI.encode("#{text}")
  response = open(url)
  doc = REXML::Document.new(response).elements[
    'ResultSet/uniq_result/word_list/']
  doc.elements.each('word') do |element|
    text = element.elements["surface"][0]
    count = element.elements["count"][0]
    p "#{text}=#{count}"
  end
end

text = "隣の客はよく柿食う客だ"
request(text)
