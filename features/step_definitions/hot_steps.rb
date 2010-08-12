# encoding: utf-8
假如 /^系统有以下热门分类:$/ do |table|
  root = User.current.store.hots.roots.first
  table.raw.each do |row|
    labels = row.clone
    label = labels.shift
    hot = Hot.new(:name => label, :url => "/#{label}")
    root.children << hot
    labels.each do |label|
      hot.children << Hot.new(:name => label, :url => "/#{label}")
    end
    hot.children.init_list!
  end
  root.children.init_list!
end
