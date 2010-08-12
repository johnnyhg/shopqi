# encoding: utf-8
# 首页热门分类，不同于商品分类，此分类只作为普通的链接
class Hot
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Acts::Tree
  include ActsAsList::Mongoid

  referenced_in :store

  field :name
  field :url
  #排序
  field :pos, :type => Integer

  acts_as_list :column => :pos
  acts_as_tree :order => [:pos, :asc]

  # 回调方法
  before_create :init_store

  def init_store
    self.store = User.current.store
  end

  # 配合acts_as_list，限定子记录排序范围
  def scope_condition
    {:parent_id => parent.id, :pos.ne => nil}
  end

  # 虚拟根节点
  def self.root
    self.create(:name => :invisible)
  end
end
