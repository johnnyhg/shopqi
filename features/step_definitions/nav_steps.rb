# coding: utf-8
假如 /^系统有以下导航:$/ do |table|
  table.raw.flatten.each do |label|
    @store.navs.create :name => label, :url => "/#{label}"
  end
  @store.navs.init_list!
end
