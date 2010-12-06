# encoding: utf-8
假如 /^系统有以下菜单:$/ do |table|
  table.raw.flatten.each do |label|
    @store.menus.create :name => label, :url => "/#{label}"
  end
  @store.menus.init_list!
  Menu.sprite @store
end

