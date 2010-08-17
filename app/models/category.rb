# encoding: utf-8
# 商品分类
class Category
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::ActsAsSortableTree
  include Mongoid::BelongToStore

  belong_to_store
  acts_as_sortable_tree
  references_many :products
  
  field :name
end
