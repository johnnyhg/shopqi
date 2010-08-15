# encoding: utf-8
# 网店
class Store
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BelongToStore

  references_many :pages, :dependent => :destroy

  store_has_many :users, :categories, :products, :hots

  # 二级域名
  field :subdomain

  # 回调方法
  after_create :init_child

  # 初始化部分分类
  def init_child
    self.pages << Page.create(:name => :homepage)
  end
end
