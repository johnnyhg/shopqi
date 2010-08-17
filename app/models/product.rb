# encoding: utf-8
class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Formtastic::I18n::Naming
  include Mongoid::BelongToStore

  belong_to_store
  referenced_in :category

  field :name
  field :price, :type => Float
  field :market_price, :type => Float
  embeds_many :photos

  # validates_presence_of :name, :price
  validates_numericality_of :price, :allow_blank => true

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
