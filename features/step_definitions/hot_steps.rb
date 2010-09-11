# encoding: utf-8
假如 /^系统有以下热门分类:$/ do |table|
  root_container = User.current.store.containers.roots.first
  root_container.children << Container.create
  parent_container = Container.create(:type => :hots, :parent_id => root_container.children.first.id)
  root = parent_container.children.first.hot
  root.children.clear
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
