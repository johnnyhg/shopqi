# coding: utf-8
假如 /^系统有以下导航:$/ do |table|
  page = Page.create :name => :mbaobao
  table.raw.flatten.each do |label|
    page.navs << Nav.new(:name => label, :url => "/#{label}")
  end
  page.navs.init_list!
end
