# encoding: utf-8
class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Formtastic::I18n::Naming
  include Mongoid::BelongToStore

  belong_to_store
  referenced_in :category
  # 保存分类至根节点的ID，方便查询某个分类及所有子类关联的商品
  field :category_path, :type => Array

  field :name
  field :price, :type => Float
  field :market_price, :type => Float
  embeds_many :photos

  # validates_presence_of :name, :price
  validates_numericality_of :price, :allow_blank => true

  before_save :set_category_path

  def set_category_path
    self.category_path = self.category.full_path if category and (self.new_record? or category.changed?)
  end

  # 产品列表缩略图
  def middle_url
    photos.empty? ? '/images/fallback/product/middle.png' : photos.first.file.middle.url
  end
end

#商品图片
class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  mount_uploader :file, PhotoUploader
  embedded_in :product, :inverse_of => :photos
end
