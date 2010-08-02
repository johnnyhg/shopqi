# encoding: utf-8
假如 /^系统有以下热门分类:$/ do |table|
  page = Page.create :name => :mbaobao
  table.raw.each do |row|
    labels = row.clone
    label = labels.shift
    hot = Hot.new(:name => label, :url => "/#{label}")
    page.hots << hot
    labels.each do |label|
      hot.children << Hot.new(:name => label, :url => "/#{label}")
    end
    hot.children.init_list!
  end
  page.hots.init_list!
end
