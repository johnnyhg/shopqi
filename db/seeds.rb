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
store.members.create(:email => 'saberma@shopqi.com', :password => '666666', :login => :saberma)

#logo
store.reload          #fixed:undefined method `id_criteria' for #<Array:0xb21a18c>
logo = store.logo_image
logo.words << Word.new(:x => 0, :y => 2, :font => :yahei_bold, 'font-size' => '36px', :color => '#000000', :text => :VANCL)
logo.words << Word.new(:x => 143, :y => 0, :font => :yahei_bold, 'font-size' => '36px', :color => '#89060C', :text => '凡客诚品')
logo.save

#telephone
telephone = store.telephone_image
telephone.words << Word.new(:x => 80, :y => 5, :font => :yahei, 'font-size' => '12px', :color => '#000000', :text => '订购热线(免长途费)')
telephone.words << Word.new(:x => 20, :y => 22, :font => :yahei_bold, 'font-size' => '24px', :color => '#89060C', :text => '400 600 6888')
telephone.save

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

#虚拟单根节点，方便实际根节点排序
category_root = store.categories.roots.first
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
  category = store.categories.build(:name => key)
  category_root.children << category
  if values.is_a? Hash
    values.each_pair do |value_key, value_values|
      child = store.categories.create(:name => value_key)
      value_values.each do |c|
        child.children << store.categories.create(:name => c)
      end
      child.children.init_list!
      category.children << child
    end
  elsif values.is_a? Array
    category.children = values.map{|v| store.categories.build(:name => v)}
  end
  category.children.init_list!
end
category_root.children.init_list!

#商品
[
  {
    :category => store.categories.where(:name => '男装').first, 
    :name => '个性背带格子衬衫',
    :market_price => 298,
    :price => 59
  },
  {
    :category => store.categories.where(:name => '衬衫').first, 
    :name => '自由舒爽棉麻衬衫',
    :market_price => 388,
    :price => 59
  },
  {
    :category => store.categories.where(:name => '男鞋').first, 
    :name => '轻便运动生活休闲鞋',
    :market_price => 499,
    :price => 99
  },
  {
    :category => store.categories.where(:name => '裙子').first, 
    :name => '白色剪花抹胸裙',
    :market_price => 599,
    :price => 199
  },
  {
    :category => store.categories.where(:name => '女装').first, 
    :name => '甜美荷叶边丝带衬衫',
    :market_price => 299,
    :price => 99
  }
].each do |attrs|
  store.products.create attrs
end

#导航
[ { :name => '我的帐户', :url => '/user' },
  { :name => '断码专区', :url => '/discount' },
  { :name => '积分回馈', :url => '/score' },
  { :name => '凡客论坛', :url => '/bbs' },
  { :name => '网站联盟', :url => '/union' },
  { :name => '帮助中心', :url => '/help' }
].each do |attributes|
  store.navs << store.navs.build(attributes)
end
store.navs.init_list!
store.save

#菜单
%w( 首页 男装 女装 童装 鞋 配饰 家居 ).each do |label|
  store.menus << store.menus.build(:name => label, :url => '/')
end
store.menus.init_list!
store.save
Menu.sprite store

page = store.pages.homepage
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
