# coding: utf-8
假如 /^系统有以下菜单:$/ do |table|
  page = Page.create :name => :mbaobao
  table.raw.flatten.each do |label|
    page.menus << Menu.new(:name => label, :url => "/#{label}")
  end
  page.menus.init_list!
  Menu.sprite(page)
end

