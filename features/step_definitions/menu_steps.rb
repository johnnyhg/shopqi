# encoding: utf-8
假如 /^系统有以下菜单:$/ do |table|
  menu_root = @store.menus.root
  table.raw.flatten.each do |label|
    @store.menus.create :name => label, :url => "/#{label}", :parent => menu_root
  end
  Menu.sprite @store
end

