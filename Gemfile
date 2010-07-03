source 'http://rubygems.org'

gem 'rails', '3.0.0.beta4'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mongoid', '2.0.0.beta9'
gem 'bson_ext', '1.0.1'
gem 'devise', '1.1.rc2'

gem 'haml'

gem "formtastic", :git => "git://github.com/justinfrench/formtastic.git", :branch => "rails3" 
gem "validation_reflection", '1.0.0.beta4'
gem "inherited_resources"

gem "mini_magick"

# Use unicorn as the web server
gem 'unicorn'

# 类似37signal的Basecamp产品界面，简洁
# http://pilu.github.com/web-app-theme/
#gem 'web-app-theme', :git => "git://github.com/libo/web-app-theme.git"

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri', '1.4.1'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

group :development do
  gem 'rails3-generators'
  gem "hpricot"
  gem "awesome_print"
end

group :test do
  gem 'webrat'
  gem "rspec-rails", '2.0.0.beta.14.2'
  gem "factory_girl"
  gem "factory_girl_rails"

  gem 'capybara'
  #保持数据库处理干净状态
  gem 'database_cleaner'
  gem 'cucumber'
  gem 'cucumber-rails'
  #为测试加速的drb server(sport cuc &)
  gem 'spork'
  #跨平台执行程序(如打开浏览器)
  gem 'launchy'
end
