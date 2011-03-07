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
    store.categories.create :name => :invisible
    #导航
    [ { :name => '我的帐户', :url => '/user' },
      { :name => '帮助中心', :url => '/help' }
    ].each do |attributes|
      store.navs.build(attributes)
    end
    store.navs.init_list!
    store.save
    #菜单
    %w( 首页 菜单1 菜单2 ).each do |label|
      store.menus << store.menus.build(:name => label, :url => '/')
    end
    store.menus.init_list!
    store.save
    Menu.sprite store
  end

end
