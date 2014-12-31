# coding: utf-8
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

# configファイルの読み込み
require 'yaml'
@@config = YAML.load_file("../config.yml")

# Capybaraの初期設定
Capybara.run_server = false
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
Capybara.current_driver = :selenium
Capybara.app_host = "https://affiliate.amazon.co.jp/"
Capybara.default_wait_time = 5

module Crawler
  class Amazon
    include Capybara::DSL

    def login
      visit('/')
      fill_in "username",
              :with => @@config["amazon"]["username"]
      fill_in "password",
              :with => @@config["amazon"]["password"]
      click_button "サインイン"
    end
  end
end

crawler = Crawler::Amazon.new
crawler.login
