# encoding: utf-8
# 网店
class Store
  include Mongoid::Document
  include Mongoid::Timestamps

  references_many :users, :dependent => :destroy
  references_many :categories, :dependent => :destroy
  references_many :hots, :dependent => :destroy
  references_many :pages, :dependent => :destroy

  # 二级域名
  field :subdomain

  # 回调方法
  after_create :init_child

  # 初始化部分分类
  def init_child
    # 设置虚拟root节点是为了方便子记录调用parent.children.init_list!
    self.categories << Category.root
    self.hots << Hot.root
    self.pages << Page.create(:name => :homepage)
  end
end
