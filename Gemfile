source 'http://rubygems.org'

gem 'rails', '3.0.0.beta4'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mongoid', '2.0.0.beta9'
gem 'bson_ext', '1.0.1'
gem 'devise', '1.1.rc2'
#排序，注意:保存后要调用todo_list.items.init_list! 初始化序号
# lib/mongoid/acts_as_list.rb第417存在问题，需要加other.respond_to?('_id')判断
# 其依赖的mongoid_embedded_helper的mongoid/embedded_helper.rb的presend?方法与activesupport中的重名，需要删除
gem 'mongoid_embedded_helper', :git => 'git://github.com/saberma/mongoid_embedded_helper.git'
gem 'acts_as_list_mongoid', :git => 'git://github.com/saberma/acts_as_list_mongoid.git'
gem 'haml'

# 注意页面的html元素要有xmlns属性，否则fieldset会挤在一起 http://bit.ly/bbcxU3
gem "formtastic", :git => "git://github.com/justinfrench/formtastic.git", :branch => "rails3" 
# 用于formtastic读取实体校验规则，页面可直接展示属性是否必填
gem "validation_reflection", '1.0.0.beta4'
gem "inherited_resources"

gem "mini_magick"

# Use unicorn as the web server
gem 'unicorn'

# 类似37signal的Basecamp产品界面，简洁
# http://pilu.github.com/web-app-theme/
gem 'web-app-theme', :git => "git://github.com/libo/web-app-theme.git"

gem "awesome_print", :require => 'ap'

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
end

group :test do
  gem 'webrat'
  gem "rspec-rails"
  gem "factory_girl"
  gem "factory_girl_rails"

  gem 'capybara'
  #保持数据库处理干净状态
  gem 'database_cleaner'
  gem 'cucumber'
  gem 'cucumber-rails'
  #为测试加速的drb server(sport cuc &)
  # 不要使用rspec2.0.0.beta.16版本，执行rspec -X
  # Exception encountered: #<NoMethodError: undefined method `configure' for ["--color", "spec/models/nav_spec.rb"]:Array>
  gem 'spork'
  #跨平台执行程序(如打开浏览器)
  gem 'launchy'
end
