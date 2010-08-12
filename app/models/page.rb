# encoding: utf-8
# 网店首页、分类商品列表页等
class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Sortable
  referenced_in :store

  has_many_sortable :navs, :menus, :focuses

  field :name
  validates_uniqueness_of :name

  embeds_one :logo

  before_create :create_logo

  #必需有Logo
  def create_logo
    self.logo = Logo.new
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
