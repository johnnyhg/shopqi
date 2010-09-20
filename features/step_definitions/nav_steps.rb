# coding: utf-8
假如 /^系统有以下导航:$/ do |table|
  store = User.current.store
  table.raw.flatten.each do |label|
    store.navs << Nav.new(:name => label, :url => "/#{label}")
  end
  store.navs.init_list!
end
