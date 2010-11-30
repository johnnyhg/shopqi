# encoding: utf-8
# 网店
class Store
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BelongToStore
  include Mongoid::Sortable

  references_many :pages, :dependent => :destroy

  store_has_many :users, :categories, :products, :hots, :containers, :focuses, :payments
  has_many_sortable :navs, :menus

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
  field :desc
  field :keywords
  field :province
  field :city
  field :district
  field :detail

  # 回调方法
  before_create :init_image
  before_create :init_subdomain
  after_create :init_child

  def init_image
    self.logo_image_id = Image.create(:width => 300, :height => 40).id
    self.telephone_image_id = Image.create(:width => 190, :height => 50).id
  end

  def init_subdomain
    self.subdomain = self.id.to_s if self.subdomain.blank?
  end

  # 初始化部分分类
  def init_child
    self.pages << Page.create(:name => :homepage)
    # 设置虚拟root节点是为了方便子记录调用parent.children.init_list!
    self.categories << Category.root
  end

  def telephone_image
    Image.find(self.telephone_image_id)
  end

  def logo_image
    Image.find(self.logo_image_id)
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
