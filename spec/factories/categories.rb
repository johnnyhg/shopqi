# encoding: utf-8
# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :category do |f|
end

Factory.define :category_with_son, :parent => :category do |f|
  f.name '男装'
  f.children { [Factory(:category, :name => '衬衫')] }
end
