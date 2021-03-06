source 'https://rubygems.org'
ruby '2.6.3'

# railsが使えるようになる。
gem 'rails', '~> 5.2.3'
# postgresqlが使えるようになる。
gem 'pg', '0.20.0'
# appサーバーpumaが使えるようになる。
gem 'puma', '~> 3.11'
#普通は設定できないエラーメッセージを日本語化できる
gem 'i18n-js',                 '3.0.11'
# スクレイピングに必要になる
gem 'nokogiri'
gem 'mechanize'
# API利用
gem 'google-api-client', '<0.9'
gem 'optimist'
# SCSSが使えるようになる
gem 'sass-rails', '~> 5.0'
# UJavaScriptのコードの改行や空白を削除して軽量化します。
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# railsでCoffeeScriptを使うためのgemです。
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
gem 'faker'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # 新規追加
  gem "better_errors"
  gem "binding_of_caller"
  gem 'rspec-rails'
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
 gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# 新規追加
gem 'dotenv-rails'
#バルクインポートに使用
gem "activerecord-import"
#パスワードの暗号化で便利
gem "bcrypt", "~> 3.1.7"
#bootstrapが使えるようになる。
gem "bootstrap-sass", "3.4.1"
#上記のページネーションにbootstrapを適用する
gem "bootstrap-will_paginate", "1.0.0"
#ダミーデータ生成
gem "faker"
#iQueryが使用できるようになる
gem "jquery-rails", "4.3.1"
#スクレイピング に使用
gem "mechanize"
#locale設定
gem "rails-i18n"
#ページネーションが使えるようになる。
gem "will_paginate", "3.1.7"
