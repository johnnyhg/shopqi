# encoding: utf-8
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

#导航
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

#菜单
%w( 首页 女包 男包 真皮 数码包 旅行包 ).each do |label|
  page.menus << Menu.new(:name => label, :url => '/category')
end
page.menus.init_list!
page.save
Menu.sprite page

#轮播广告
%w( 激情世界杯 最爱草包 时尚之夜 冬季暖包 浪美特价 ).each do |label|
  page.focuses << Focus.new(:name => label, :url => '/focus')
end
page.focuses.init_list!
page.save

#热门分类
{
  :女装 => %w( 新品女装 女装季末特惠 吊带/背心29元 短袖T恤39元 短袖衬衫59元 POLO49元 半裙49元 ), 
  :男装 => %w( 新品男装 短袖T恤 棉麻休闲裤 水洗POLO 牛仔裤(34款) 商务衬衫(68款) 香槟领衬衫 ),
  :童装 => %w( 大童(6岁以上) 小童(1-6岁) 婴儿装 亲子装 家居短裤 卡通T恤(140款) 连衣裙  爬爬服套装 ),
  :鞋   => %w( 男鞋 女鞋 童鞋 透气休闲鞋 软底跑步鞋 牛仔鞋 圆头平底鞋 山茶花鞋 人字拖 ),
  :配饰 => %w( 女包(34款) 帽子(38款) 男款皮带 女款皮带 皮质手环 领带 透气棉袜 环保帆布袋 )
}.each_pair do |key, values|
  hot = Hot.new(:name => key, :url => '/hots')
  page.hots << hot
  values.each do |value|
    hot.children << Hot.new(:name => value, :url => '/hots')
  end
end
page.hots.init_list!
page.save

Category.delete_all
#虚拟单根节点，方便实际根节点排序
root = Category.create :name => :root
#分类
{
  :男装 => {
    :衬衫 => %w( 牛津纺衬衫 商务衬衫 休闲衬衫 ),
    :POLO衫 => %w(),
    :针织衫 => %w( 针织背心 长袖针织衫 ), 
    :外套 => %w( 夹克 西服 卫衣 风衣 棉服 )
  },
  :女装 => %w( 百变衫 BRA-T 打底裤 裙子 ), 
  :童装 => %w( 婴儿装 ),
  :鞋   => %w( 男鞋 女鞋 童鞋 透气休闲鞋 软底跑步鞋 牛仔鞋 圆头平底鞋 山茶花鞋 人字拖 ),
  :配饰 => %w( 女包 帽子 男款皮带 女款皮带 皮质手环 领带 透气棉袜 环保帆布袋 )
}.each_pair do |key, values|
  category = Category.new(:name => key)
  root.children << category
  if values.is_a? Hash
    values.each_pair do |value_key, value_values|
      child = Category.create(:name => value_key)
      value_values.each do |c|
        child.children << Category.create(:name => c)
      end
      child.children.init_list!
      category.children << child
    end
  elsif values.is_a? Array
    category.children = values.map{|v| Category.new(:name => v)}
  end
  category.children.init_list!
end
root.children.init_list!

#商品
[
  {
    :name => '个性背带格子衬衫',
    :market_price => 298,
    :price => 59
  },
  {
    :name => '自由舒爽棉麻衬衫',
    :market_price => 388,
    :price => 59
  },
  {
    :name => '轻便运动生活休闲鞋',
    :market_price => 499,
    :price => 99
  },
  {
    :name => '白色剪花抹胸裙',
    :market_price => 599,
    :price => 199
  },
  {
    :name => '甜美荷叶边丝带衬衫',
    :market_price => 299,
    :price => 99
  }
].each do |attrs|
  Product.create attrs
end
