# encoding: utf-8
# 商品分类
class Category
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Acts::Tree
  include ActsAsList::Mongoid

  referenced_in :store
  references_many :products
  
  field :name
  #排序
  field :pos, :type => Integer

  acts_as_list :column => :pos
  acts_as_tree :order => [:pos, :asc]

  # 校验
  #validates_presence_of :store_id

  # 回调方法
  before_create :init_store

  def init_store
    self.store = User.current.store
    raise 'security prevent' if parent and parent.store != self.store
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
