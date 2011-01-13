# encoding: utf-8
# 网店首页、分类商品列表页等
class Page
  include Extensions::Base
  include Mongoid::Document
  include Mongoid::Timestamps

  referenced_in :store
  references_many :containers, :dependent => :destroy

  field :name

  # 回调方法
  after_create :init_child

  # 初始化部分分类
  def init_child
    # 设置虚拟root节点是为了方便子记录调用parent.children.init_list!
    store.containers.create :name => :invisible, :page => self
  end

  # 首页
  def self.homepage
    where(:name => :homepage).first
  end
end
