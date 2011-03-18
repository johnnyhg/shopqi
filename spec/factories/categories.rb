# encoding: utf-8
# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :category do |f|
end

Factory.define :category_man, :parent => :category do |f|
  f.name '男装'
end

Factory.define :category_woman, :parent => :category do |f|
  f.name '女装'
  #f.after_create do |category|
  #  %w( 百变衫 BRA-T 打底裤 裙子 ).each do |label| 
  #    category.children << category.store.categories.build(Factory.attributes_for(:category, :name => label))
  #  end
  #end
end
