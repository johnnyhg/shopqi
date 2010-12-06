# encoding: utf-8
Factory.define :store do |s|
end

Factory.define :store_vancl, :parent => :store do |s|
  s.menus do |store|
    %w( 首页 女包 男包 真皮 数码包 旅行包 ).map do |menu|
      store.menus.build :name => menu
    end
  end

  s.navs do |store| 
    %w( 会员中心 订单查询 网站导航 帮助 ).map do |nav|
      store.navs.build :name => nav
    end
  end
end
