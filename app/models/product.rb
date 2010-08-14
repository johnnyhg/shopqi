# encoding: utf-8
class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Formtastic::I18n::Naming

  referenced_in :store
  referenced_in :category

  field :name
  field :price, :type => Float
  field :market_price, :type => Float
  embeds_many :photos

  # validates_presence_of :name, :price
  validates_numericality_of :price, :allow_blank => true

  # 回调方法
  before_create :init_store

  def init_store
    self.store = User.current.store
  end
end

#商品图片
class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  mount_uploader :file, PhotoUploader
  embedded_in :product, :inverse_of => :photos
end
