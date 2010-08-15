# encoding: utf-8
# 首页热门分类，不同于商品分类，此分类只作为普通的链接
class Hot
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Acts::Tree
  include ActsAsList::Mongoid
  include Mongoid::BelongToStore

  belong_to_store

  field :name
  field :url
  #排序
  field :pos, :type => Integer

  acts_as_list :column => :pos
  acts_as_tree :order => [:pos, :asc]
end
