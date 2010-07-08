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
