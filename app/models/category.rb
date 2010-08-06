# encoding: utf-8
# 商品分类
class Category
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Acts::Tree
  include ActsAsList::Mongoid
  
  field :name
  #排序
  field :pos, :type => Integer

  acts_as_list :column => :pos
  acts_as_tree :order => [:pos, :asc]

  # 配合acts_as_list，限定子记录排序范围
  def scope_condition
    {:parent_id => parent.id, :pos.ne => nil}
  end
end
