#rails new . -d postgresql -T -J
source 'http://rubygems.org'

gem 'rails', '3.0.6'

##### 实体相关 #####
gem 'pg'
gem 'auto_migrations'
gem 'devise'

# 用于保存配置型(枚举)记录
gem 'active_hash'
# 分页
gem 'kaminari'
#用于处理图片(缩略图)
gem 'dragonfly'
gem 'rack-cache', :require => 'rack/cache'
#模板语言
gem 'liquid'
gem "carrierwave"
#查询
gem 'meta_where'
gem 'meta_search'

##### 控制器相关 #####
gem 'decent_exposure'
# 将current_user设置至线程中
gem 'sentient_user'
# 调用参数说明:http://www.imagemagick.org/Usage/
gem "mini_magick"

##### 视图相关 #####
gem 'haml'
# 编译coffee-script
gem 'therubyracer', :require => nil
gem 'barista'
#用于显示错误信息
gem 'message_block'
#客户端校验
gem 'client_side_validations'

##### 其他 #####
# 支付
gem "activemerchant"
# 支付指定sign key参数
gem "activemerchant_patch_for_china", :git => 'git://github.com/saberma/activemerchant_patch_for_china.git'
gem "httparty"
# 后台任务
gem "resque"

group :development, :test do
  # 调试
  gem "awesome_print", :require => 'ap'
  # 加快开发时的响应速度
  gem 'rails-dev-boost', :git => 'git://github.com/thedarkone/rails-dev-boost.git', :require => 'rails_development_boost'
end

group :development do
  gem 'rails3-generators'
  # jquery,haml已经独立出来
  gem "jquery-rails"
  gem "haml-rails"
  # 修改后台文件后，safari或chrome浏览器会自动刷新
  # use the guard-livereload instead
  #gem "livereload"
  gem 'guard'
  #only on the linux platform install the gem
  #if语句无法做到兼容linux和mac环境，导致Gemfile.lock不断变化，先去掉提示功能
  #if RUBY_PLATFORM =~ /linux/
  #  #vagrant虚拟机没有安装桌面
  #  #gem "rb-inotify"
  #  #notification support
  #  #gem 'libnotify'
  #elsif RUBY_PLATFORM =~ /darwin/
  #  gem 'rb-fsevent'
  #  gem 'growl'
  #end
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-spork'

  # To use debugger(add 'debugger' in code, then set autoeval; set autolist in console)
  gem 'ruby-debug19'
end

group :test do
  gem "rspec-rails"
  gem "factory_girl"
  gem "factory_girl_rails"
  # 集成测试，最新版才支持:js=>true参数
  gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git'
  # resque测试
  gem 'resque_spec'

  # 保持数据库处理干净状态
  # 留意:步骤完成后就会清除数据，此时浏览器中部分ajax可能还没有操作完，会导致ajax请求时找不到相应数据
  gem 'database_cleaner'
  # 为测试加速的drb server(spork spec &)
  gem 'spork'
end
