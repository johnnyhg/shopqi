# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Page.where(:name => :mbaobao).first.try(:destroy)
page = Page.create(:name => :mbaobao)

page.logo = Logo.new

[ { :name => '会员中心', :url => '/user' },
  { :name => '订单查询', :url => '/query' },
  { :name => '网站导航', :url => '/sitemap' },
  { :name => '帮助', :url => '/help' },
  { :name => '包包批发', :url => 'http://www.baobao178.com' },
  { :name => '相似推荐', :url => '/similar' }
].each do |attributes|
  page.navs << Nav.new(attributes)
end
page.navs.init_list!
page.save

%w( 首页 女包 男包 真皮 数码包 旅行包 ).each do |label|
  page.menus << Menu.new(:name => label, :url => '/category')
end
page.menus.init_list!
page.save
Menu.sprite page

%w( 激情世界杯 最爱草包 时尚之夜 冬季暖包 浪美特价 ).each do |label|
  page.focuses << Focus.new(:name => label, :url => '/focus', :img_url => 'http://images.mbaobao.com/activity/201007/02/event_night.jpg')
end
page.focuses.init_list!
page.save
