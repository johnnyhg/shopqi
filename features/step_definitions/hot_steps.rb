# encoding: utf-8
假如 /^系统有以下热门分类:$/ do |table|
  root_container = @store.root_container
  root_container.children << @store.containers.create
  parent_container = @store.containers.create(:type => :hots, :parent_id => root_container.children.first.id)
  root = parent_container.children.first.hot
  root.children.clear
  table.raw.each do |row|
    labels = row.clone
    label = labels.shift
    hot = @store.hots.build(:name => label, :url => "/#{label}")
    root.children << hot
    labels.each do |label|
      hot.children << @store.hots.build(:name => label, :url => "/#{label}")
    end
  end
end
