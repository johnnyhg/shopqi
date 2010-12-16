# encoding: utf-8
# 网店
class Store
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Sortable

  [:users, :members, :categories, :products, :pages, :hots, :containers, :focuses, :payments, :consumptions, :orders, :images].each do |children|
    references_many children, :dependent => :destroy
  end
  has_many_sortable :navs, :menus

  # 有效期
  field :deadline, :type => Date

  # 模板
  field :template, :default => 'vancl'

  # 二级域名
  field :subdomain

  # Logo, telephone
  field :logo_image_id
  field :telephone_image_id

  # 网店设置
  field :name
  field :title
  field :description
  field :keywords
  field :province
  field :city
  field :district
  field :detail

  # 回调方法
  before_create :init_image
  before_create :init_subdomain
  before_create :init_valid_date
  after_create :init_child

  def init_image
    self.logo_image_id = images.create(:width => 300, :height => 40).id
    self.telephone_image_id = images.create(:width => 190, :height => 50).id
  end

  def init_valid_date
    self.deadline = Date.today.next_day(10)
  end

  def init_subdomain
    self.subdomain = self.id.to_s if self.subdomain.blank?
  end

  # 初始化部分分类
  def init_child
    self.pages.create :name => :homepage
    # 设置虚拟root节点是为了方便子记录调用parent.children.init_list!
    self.categories.create :name => :invisible
  end

  # 提前一个月提示用户付款
  def deadline_warning?
    self.deadline.months_ago(1).past?
  end

  def available?
    !self.deadline.past?
  end

  def telephone_image
    images.find(self.telephone_image_id)
  end

  def logo_image
    images.find(self.logo_image_id)
  end

  def root_container
    self.pages.homepage.containers.roots.first
  end

  #网店菜单背景图路径
  def menu_sprite_path
    "#{Rails.root}/public" + menu_sprite_url
  end

  def menu_sprite_url
    "/images/menu/#{id}.png"
  end

  def next_order_sequence
    Sequence.next("shop_#{self.id.to_s}")
  end
end
