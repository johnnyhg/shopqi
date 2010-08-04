# encoding: utf-8
# 商品分类
class Category
  include Mongoid::Document
  include Mongoid::Acts::Tree

  field :name

  acts_as_tree
end
