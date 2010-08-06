# encoding: utf-8
# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :category do |f|
end

Factory.define :category_root, :parent => :category do |f|
  f.name '不显示的根节点'
end

Factory.define :category_man, :parent => :category do |f|
  f.name '男装'
  f.after_create {|category|
    %w( 衬衫 POLO衫 针织衫 外套 ).each do |label| 
      category.children << Factory(:category, :name => label)
    end
    category.children.init_list!
  }
end

Factory.define :category_woman, :parent => :category do |f|
  f.name '女装'
  f.after_create {|category|
    %w( 百变衫 BRA-T 打底裤 裙子 ).each do |label| 
      category.children << Factory(:category, :name => label)
    end
    category.children.init_list!
  }
end
