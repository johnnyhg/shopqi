# coding: utf-8
假如 /^系统有以下导航:$/ do |table|
  nav_root = @store.navs.root
  nav_root.children.clear
  table.raw.flatten.each do |label|
    @store.navs.create :name => label, :url => "/#{label}", :parent => nav_root
  end
end
