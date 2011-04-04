source 'http://rubygems.org'

# need gem install bundler -v 1.0.0.rc.1
gem 'rails'

# Use unicorn as the web server
#gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

##### 实体相关 #####
#gem 'mongoid', '2.0.0.rc.7'
#2011.03.14 官方版本不支持mongoid 2.0.0.rc.7，已提交补丁，未合并
gem 'mongoid_adjust',           :git => 'git://github.com/saberma/mongoid_adjust.git'
gem 'mongoid_embedded_helper',  :git => 'git://github.com/saberma/mongoid_embedded_helper.git'
#2011.03.14 官方版本2.0.0.rc.7存在bug:调整where查询条件顺序出来的結果不一样。已提交补丁，未合并
gem 'mongoid', :git => 'git://github.com/saberma/mongoid.git'
gem 'bson_ext'
gem 'devise'
# 用于保存配置型记录
gem 'active_hash'
# 分页
gem 'kaminari'
#用于处理图片(缩略图)
gem 'dragonfly'
gem 'rack-cache', :require => 'rack/cache'

# mongoid
# 排序，注意:保存后要调用todo_list.items.init_list! 初始化序号
gem 'acts_as_list_mongoid', :git => 'git://github.com/saberma/acts_as_list_mongoid.git'
# 修正Bug，已提交补丁，已合并至官方版本
# 2010.10.20 BSON::ObjectID改名为BSON::ObjectId，已提交补丁，已合并至官方版本
#gem 'mongoid_acts_as_tree'
gem 'mongoid-tree', :require => 'mongoid/tree', :git => 'git://github.com/benedikt/mongoid-tree.git', :branch => 'mongoid-2.0.0'

# 将current_user设置至线程中
gem 'sentient_user'

# 状态机，官方版本暂不支持mongoid
gem "transitions", :git => 'git://github.com/saberma/transitions.git', :require => ["transitions", "mongoid/transitions"]

# 文件上传
# 2010.08.13 源版本不支持mongoid校验，已提交补丁，已合并至官方版本
gem "carrierwave"
# 调用参数说明:http://www.imagemagick.org/Usage/
gem "mini_magick"


##### 视图相关 #####
gem 'haml'
# 注意页面的html元素要有xmlns属性，否则fieldset会挤在一起 http://bit.ly/bbcxU3
gem "formtastic"
# 用于formtastic读取实体校验规则，页面可直接展示属性是否必填
gem "validation_reflection"
# edit in place plugin for jeditable
gem "on_the_spot"


##### 控制器相关 #####
gem "inherited_resources"


##### 样式相关 #####
gem 'compass'
# css sprite generator
gem 'lemonade'
gem 'css_sprite'
# 使用960.gs css框架
gem 'compass-960-plugin'
# 类似37signal的Basecamp产品界面，简洁
# http://pilu.github.com/web-app-theme/
gem 'web-app-theme'

##### 其他 #####
# 支付
gem "activemerchant"
# 支付指定sign key参数
gem "activemerchant_patch_for_china", :git => 'git://github.com/saberma/activemerchant_patch_for_china.git'
gem "httparty"
# 实时(另外需要安装node.js和redis)
gem "juggernaut"
# 后台任务
gem "resque"

# 调试
gem "awesome_print", :require => 'ap'

group :development do
  gem 'rails3-generators'
  # jquery,haml已经独立出来
  #gem "jquery-rails"
  #gem "haml-rails"
  gem "hpricot"
  # 修改后台文件后，safari或chrome浏览器会自动刷新
  gem "livereload"
#only on the linux platform install the gem
  if RUBY_PLATFORM =~ /linux/
    gem "rb-inotify"
  end

  # To use debugger(add 'debugger' in code, then set autoeval; set autolist in console)
  gem 'ruby-debug19'

  # html-boilerplate
  gem "html5-boilerplate"
end

group :test do
  gem 'webrat'
  gem "rspec-rails"
  gem "factory_girl"
  gem "factory_girl_rails"
  # resque测试
  gem 'resque_spec'

  # 最新版本0.4.0有问题，无法启动测试服务器
  gem 'capybara', '0.3.9'
  # 保持数据库处理干净状态
  # 留意:步骤完成后就会清除数据，此时浏览器中部分ajax可能还没有操作完，会导致ajax请求时找不到相应数据
  gem 'database_cleaner'
  # 0.9.2版本集成spork的情况下会报undefined method `visit' for #<Object:
  gem 'cucumber'
  gem 'cucumber-rails'
  # 为测试加速的drb server(sport cuc &)
  # 不要使用rspec2.0.0.beta.16版本，执行rspec -X
  # Exception encountered: #<NoMethodError: undefined method `configure' for ["--color", "spec/models/nav_spec.rb"]:Array>
  gem 'spork'
  # 跨平台执行程序(如打开浏览器)
  gem 'launchy'
end
