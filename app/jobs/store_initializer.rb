# encoding: utf-8
module StoreInitializer

  @queue = "store_initializer"
  
  def self.perform(id)
    store = Store.find(id)
    #image
    store.logo_image_id = store.images.create(:width => 300, :height => 40).id
    store.telephone_image_id = store.images.create(:width => 190, :height => 50).id
    store.save
    #child
    store.pages.create :name => :homepage
    # 设置虚拟root节点是为了方便子记录调用parent.children.init_list!
    category_root = store.categories.create :name => :invisible

    #虚拟单根节点，方便实际根节点排序
    #分类
    { '男装' => { '衬衫' => %w() },
      '女装' => %w()
    }.each_pair do |key, values|
      category = store.categories.create(:name => key)
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
        category.children = values.map{|v| store.categories.create(:name => v)}
      end
      category.children.init_list!
    end
    category_root.children.init_list!

    #商品
    [ { :category => store.categories.where(:name => '男装').first, :name => '男装衬衫1', :market_price => 98, :price => 59 },
      { :category => store.categories.where(:name => '男装').first, :name => '男装衬衫2', :market_price => 198, :price => 59 },
      { :category => store.categories.where(:name => '女装').first, :name => '女装衬衫1', :market_price => 99, :price => 99 },
      { :category => store.categories.where(:name => '女装').first, :name => '女装衬衫2', :market_price => 199, :price => 99 },
      { :category => store.categories.where(:name => '女装').first, :name => '女装衬衫3', :market_price => 299, :price => 99 }
    ].each do |attrs|
      store.products.create attrs
    end

    #logo
    store.reload          #fixed:undefined method `id_criteria' for #<Array:0xb21a18c>
    logo = store.logo_image
    logo.words.build(:x => 0, :y => 2, :font => :yahei_bold, 'font-size' => '36px', :color => '#000000', :text => :ShopQi)
    logo.words.build(:x => 143, :y => 0, :font => :yahei_bold, 'font-size' => '36px', :color => '#89060C', :text => '在线商店')
    logo.save

    #telephone
    telephone = store.telephone_image
    telephone.words.build(:x => 80, :y => 5, :font => :yahei, 'font-size' => '12px', :color => '#000000', :text => '订购热线(免长途费)')
    telephone.words.build(:x => 20, :y => 22, :font => :yahei_bold, 'font-size' => '24px', :color => '#89060C', :text => '400 800 8888')
    telephone.save

    #导航
    [ { :name => '我的帐户', :url => '/user' },
      { :name => '帮助中心', :url => '/help' }
    ].each do |attributes|
      store.navs << store.navs.build(attributes)
    end
    store.navs.init_list!
    store.save
    #菜单
    %w( 首页 男装 女装 ).each do |label|
      store.menus << store.menus.build(:name => label, :url => '/')
    end
    store.menus.init_list!
    store.save
    Menu.sprite store

    #通栏广告
    page = store.pages.homepage
    root = page.containers.roots.first
    fullad_container = store.containers.create( :parent_id => root.id, :type => :fullad ).children.first
    fullad = fullad_container.image
    fullad.words.build(:x => 250, :y => 10, :font => :yahei_bold, 'font-size' => '36px', :color => '#E60012', :text => '全 场 购 物 N 元 免 运 费')
    fullad.save

    #聚焦广告,边栏广告
    root_container = store.containers.create( :parent_id => root.id, :type => :focuses)
    sidead_container = store.containers.create( :parent_id => root_container.id, :type => :sidead)
    store.containers.create( :parent_id => sidead_container.id, :type => :sidead)
    store.containers.create( :parent_id => sidead_container.id, :type => :sidead)
    root_container.children.init_list!

    #热门分类
    root_container = store.containers.create( :parent_id => root.id, :type => :hots)
    accordion = store.containers.create( :parent_id => root_container.id, :type => :products_accordion).children.first
    accordion.category_ids = store.categories.where(:name => '男装').map(&:id)
    accordion.save
    root_container.children.init_list!

    #商品列表
    store.containers.create( :parent_id => root.id, :type => :products_head)
    store.containers.create( :parent_id => root.id, :type => :products)

  end

end
