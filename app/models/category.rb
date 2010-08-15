# encoding: utf-8
# 商品分类
class Category
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Acts::Tree
  include ActsAsList::Mongoid
  include Mongoid::BelongToStore

  belong_to_store
  references_many :products
  
  field :name
  #排序
  field :pos, :type => Integer

  acts_as_list :column => :pos
  acts_as_tree :order => [:pos, :asc]

  # 校验
  #validates_presence_of :store_id
end
