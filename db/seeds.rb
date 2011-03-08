# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
saberma = User.where(:email => 'saberma@shopqi.com').first
saberma.try(:store).try(:destroy)
saberma.try(:destroy)
saberma = User.create(:email => 'saberma@shopqi.com', :password => '666666', :login => :saberma)

store = saberma.store
store.update_attributes :subdomain => 'vancl'
store.payments.create :payment_type_id => PaymentType.first.id, :is_show => true
#member
member = store.members.create(:email => 'saberma@shopqi.com', :password => '666666', :login => :saberma)
member.addresses.create :name => :saberma, :province => '440000', :city => '440300', :district => '440305', :detail => '科技园南区315', :zipcode => '518057', :mobile => '13928xx28xx'

#热门分类
=begin
hot_root = store.hots.roots.first
{
  :女装 => %w( 新品女装 女装季末特惠 吊带/背心29元 短袖T恤39元 短袖衬衫59元 POLO49元 半裙49元 ), 
  :男装 => %w( 新品男装 短袖T恤 棉麻休闲裤 水洗POLO 牛仔裤(34款) 商务衬衫(68款) 香槟领衬衫 ),
  :童装 => %w( 大童(6岁以上) 小童(1-6岁) 婴儿装 亲子装 家居短裤 卡通T恤(140款) 连衣裙  爬爬服套装 ),
  :鞋   => %w( 男鞋 女鞋 童鞋 透气休闲鞋 软底跑步鞋 牛仔鞋 圆头平底鞋 山茶花鞋 人字拖 ),
  :配饰 => %w( 女包(34款) 帽子(38款) 男款皮带 女款皮带 皮质手环 领带 透气棉袜 环保帆布袋 )
}.each_pair do |key, values|
  hot = Hot.new(:name => key, :url => '/hots')
  hot_root.children << hot
  values.each do |value|
    hot.children << Hot.new(:name => value, :url => '/hots')
  end
  hot.children.init_list!
end
hot_root.children.init_list!
hot_root.save
=end

#page = store.pages.homepage
#轮播广告
=begin
%w( 激情世界杯 最爱草包 时尚之夜 冬季暖包 浪美特价 ).each do |label|
  page.focuses << Focus.new(:name => label, :url => '/focus')
end
page.focuses.init_list!
page.save
=end

# 商品列表
#container_root = page.containers.roots.first
#container_root.children << page.containers.create
#container_root.children.init_list!
