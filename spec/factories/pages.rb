# encoding:utf-8
Factory.define 'page_mbaobao', :class => :page do |p|
  p.name :mbaobao
  p.menus do |page|
    %w( 首页 女包 男包 真皮 数码包 旅行包 ).map do |menu|
      Factory.build(:menu, :name => menu)
    end
  end

  p.navs do |page| 
    %w( 会员中心 订单查询 网站导航 帮助 ).map do |nav|
      Factory.build(:nav, :name => nav)
    end
  end
end
