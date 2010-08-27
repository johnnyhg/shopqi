# encoding: utf-8
# 网店首页、分类商品列表页等
class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Sortable
  include Mongoid::BelongToStore
  belong_to_store

  has_many_sortable :navs, :menus
  references_many :containers, :dependent => :destroy

  field :name

  embeds_one :logo


  # 回调方法
  before_create :create_logo
  after_create :init_child

  #必需有Logo
  def create_logo
    self.logo = Logo.new
  end

  # 初始化部分分类
  def init_child
    # 设置虚拟root节点是为了方便子记录调用parent.children.init_list!
    self.containers << Container.root(:page => self)
  end

  # 首页
  def self.homepage
    where(:name => :homepage).first
  end

  #网店菜单背景图路径
  def menu_sprite_path
    "#{Rails.root}/public" + menu_sprite_url
  end

  def menu_sprite_url
    "/images/menu/#{id}.png"
  end
end

#首页Logo
class Logo
  include Mongoid::Document
  embedded_in :page, :inverse_of => :logo

  field :url, :default => '/images/logo/default.gif'

  #在线文字合成ID
  field :image_id
  #mount_uploader :image, ImageUploader
end
