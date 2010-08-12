# encoding: utf-8
假如 /^系统有以下菜单:$/ do |table|
  page = User.current.store.pages.homepage
  table.raw.flatten.each do |label|
    page.menus << Menu.new(:name => label, :url => "/#{label}")
  end
  page.menus.init_list!
  Menu.sprite(page)
end

