# coding: utf-8
require 'amazon/ecs'
require 'pp'

# configファイルの読み込み
require 'yaml'
@@config = YAML.load_file("../config.yml")


Amazon::Ecs.options = {
  :associate_tag => @@config["amazon_ecs"]["associate_tag"],
  :AWS_access_key_id => @@config["amazon_ecs"]["aws_access_key"],
  :AWS_secret_key => @@config["amazon_ecs"]["aws_secret_key"]
}

opts = {
  :country => 'jp',
  :author => '北方謙三'
}

res = Amazon::Ecs.item_search('三国志', opts)
res.items.each do |item|
  puts item.get('ItemAttributes/Title')
end

res = Amazon::Ecs.item_lookup(
  'BOOJXEFT6Y',
  :response_group => 'Small, ItemAttributes, Images',
  :country => 'jp'
)
pp res
