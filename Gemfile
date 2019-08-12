source 'https://rubygems.org'
ruby '2.6.3'

# railsが使えるようになる。
gem 'rails', '~> 5.2.3'
# appサーバーpumaが使えるようになる。
gem 'puma', '~> 3.11'
# スクレイピングに必要になる
gem 'nokogiri'
gem 'mechanize'
# API利用
gem 'google-api-client', '<0.9'
gem 'trollop', '~> 2.1'
# BULK INSERT
gem 'activerecord-import'
# bootstrapが使えるようになる
gem 'bootstrap-sass', '3.3.7'
# SCSSが使えるようになる
gem 'sass-rails', '~> 5.0'
# UJavaScriptのコードの改行や空白を削除して軽量化します。
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby
gem 'jquery-rails'
# railsでCoffeeScriptを使うためのgemです。
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModelのhas_seccure_password
gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
#ページネーションが使えるようになる。
gem 'will_paginate',           '3.1.6'
#上記のページネーションにbootstrapを適用する
gem 'bootstrap-will_paginate', '1.0.0'
#bootstrapが使えるようになる。
gem 'bootstrap-sass', '3.3.7'

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
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
