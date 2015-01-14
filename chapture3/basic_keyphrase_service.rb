# coding: utf-8
require 'open-uri'
require 'rexml/document'

# configファイルの読み込み
require 'yaml'
@@config = YAML.load_file("../config.yml")

APPLICATION_ID = @@config["yahoo"]["api_key"]
BASE_URL = 'http://jlp.yahooapis.jp/KeyphraseService/V1/extract'

def request(text)
  app_id = APPLICATION_ID
  params = "?appid=#{app_id}&output=xml"
  url = "#{BASE_URL}#{params}" + "&sentence=" + URI.encode("#{text}")
  response = open(url)
  doc = REXML::Document.new(response).elements['ResultSet/']
  doc.elements.each('Result') do |element|
    text = element.elements["Keyphrase"][0]
    score = element.elements["Score"][0]
    p "#{text}=#{score}"
  end
end

text = "隣の客はよく柿食う客だ"
request(text)
