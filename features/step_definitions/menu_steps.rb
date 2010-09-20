# encoding: utf-8
假如 /^系统有以下菜单:$/ do |table|
  store = User.current.store
  table.raw.flatten.each do |label|
    store.menus << Menu.new(:name => label, :url => "/#{label}")
  end
  store.menus.init_list!
  Menu.sprite(store)
end

