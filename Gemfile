source 'http://rubygems.org'

# need gem install bundler -v 1.0.0.rc.1
gem 'rails'

#gem 'mongoid', '2.0.0.beta.16'
# beta.16存在bug，导致嵌套文档where查询失败，已提交补丁
gem 'mongoid', '2.0.0.beta.19'
gem 'bson_ext'
gem 'devise'

# mongoid
# 排序，注意:保存后要调用todo_list.items.init_list! 初始化序号
gem 'acts_as_list_mongoid'
# 修正Bug，已提交补丁，已合并至官方版本
# 2010.10.20 BSON::ObjectID改名为BSON::ObjectId，已提交补丁，未合并至官方版本
gem 'mongoid_acts_as_tree', :git => 'git://github.com/saberma/mongoid_acts_as_tree.git'
#gem 'mongoid_acts_as_tree', :git => 'git://github.com/saks/mongoid_acts_as_tree.git'

# 将current_user设置至线程中
gem 'sentient_user'

gem 'haml'

# 注意页面的html元素要有xmlns属性，否则fieldset会挤在一起 http://bit.ly/bbcxU3
gem "formtastic"
# 用于formtastic读取实体校验规则，页面可直接展示属性是否必填
gem "validation_reflection"
gem "inherited_resources"

# 文件上传
# 源版本不支持mongoid校验，已提交补丁，已合并至官方版本
#gem "carrierwave", :git => 'git://github.com/saberma/carrierwave.git', :branch => 'master'
gem "carrierwave", :git => 'git://github.com/jnicklas/carrierwave.git'
# 调用参数说明:http://www.imagemagick.org/Usage/
gem "mini_magick"

# Use unicorn as the web server
gem 'unicorn'

# 类似37signal的Basecamp产品界面，简洁
# http://pilu.github.com/web-app-theme/
gem 'web-app-theme'

##### 样式相关 #####
gem 'compass'
# css sprite generator
gem 'lemonade'
# 使用960.gs css框架
gem 'compass-960-plugin'

gem "awesome_print", :require => 'ap'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger(set autoeval; set autolist)
#gem 'ruby-debug19'
# 需要手动安装(/path/to/ruby为ruby所在路径，如:home/saberma/.rvm/src/ruby-1.9.2-head)
# gem install ruby-debug19 --no-ri --no-rdoc -- --with-ruby-include=/path/to/ruby

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri', '1.4.1'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

group :development do
  gem 'rails3-generators'
  gem "hpricot"
  # 修改后台文件后，safari或chrome浏览器会自动刷新
  gem "livereload"
  gem "rb-inotify"
end

group :test do
  gem 'webrat'
  gem "rspec-rails"
  gem "factory_girl"
  gem "factory_girl_rails"

  gem 'capybara'
  # 保持数据库处理干净状态
  # 留意:步骤完成后就会清除数据，此时浏览器中部分ajax可能还没有操作完，会导致ajax请求时找不到相应数据
  gem 'database_cleaner'
  # 0.9.2版本集成spork的情况下会报undefined method `visit' for #<Object:
  gem 'cucumber', :git => 'git://github.com/aslakhellesoy/cucumber.git'
  gem 'cucumber-rails'
  # 为测试加速的drb server(sport cuc &)
  # 不要使用rspec2.0.0.beta.16版本，执行rspec -X
  # Exception encountered: #<NoMethodError: undefined method `configure' for ["--color", "spec/models/nav_spec.rb"]:Array>
  gem 'spork'
  # 跨平台执行程序(如打开浏览器)
  gem 'launchy'
end
