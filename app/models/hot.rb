# encoding: utf-8
# 首页热门分类，不同于商品分类，此分类只作为普通的链接
class Hot
  include Extensions::Base
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::ActsAsSortableTree

  referenced_in :store
  references_one :container

  field :name
  field :url

  # 重载根节点的判断方法
  def root?
    self.depth == 1
  end
end
