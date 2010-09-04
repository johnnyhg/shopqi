# encoding: utf-8
# 网店
class Store
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BelongToStore

  references_many :pages, :dependent => :destroy

  store_has_many :users, :categories, :products, :hots, :containers, :focuses

  # 模板
  field :template, :default => 'vancl'

  # 二级域名
  field :subdomain

  # Logo
  field :logo_image_id

  # 回调方法
  before_create :init_logo_image
  after_create :init_child

  def init_logo_image
    self.logo_image_id = Image.create(:width => 310, :height => 30).id
  end

  # 初始化部分分类
  def init_child
    self.pages << Page.create(:name => :homepage)
    # 设置虚拟root节点是为了方便子记录调用parent.children.init_list!
    self.categories << Category.root
    self.hots << Hot.root
  end

  def logo_image
    Image.find(self.logo_image_id)
  end
end
