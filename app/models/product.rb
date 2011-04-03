# encoding: utf-8
class Product
  include Extensions::Base
  include Mongoid::Document
  include Mongoid::Timestamps
  include Formtastic::I18n::Naming

  referenced_in :store
  referenced_in :category
  # 保存分类至根节点的ID，方便查询某个分类及所有子类关联的商品
  field :category_parent_ids, :type => Array

  field :name
  field :price, :type => Float
  field :market_price, :type => Float
  field :number
  field :content
  embeds_many :photos

  # validates_presence_of :name, :price
  validates_numericality_of :price, :allow_blank => true

  before_save :set_category_parent_ids

  def set_category_parent_ids
    self.category_parent_ids = self.category.full_parent_ids if category and (self.new_record? or category.changed?)
  end

  # 产品第一张照片
  def photo
    photos.empty? ? Photo.new : photos.first 
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

  field :file_uid
  image_accessor :file
  
  validates_size_of :file, :maximum =>8000.kilobytes
  validates_property :mime_type, :of => :file, :in => %w(image/jpeg image/jpg image/png image/gif),:message => "请上传正确格式的图片"

 # delegate :url, :accordion, :icon, :small, :middle, :big, :to => :file
 # mount_uploader :file, PhotoUploader
  embedded_in :product, :inverse_of => :photos

  def self.versions(opt={})
    opt.each_pair do |k,v|
      define_method k do
        if file
          file.thumb(v)
        else
          DefVersion.new(k)
        end
      end
    end
  end

  # 显示在产品详情页中的缩略图(icon)
  # 显示在产品列表页中的缩略图(small)
  # 显示在产品详情页中的图片(middle)
  # 显示在产品详情页中的放大镜图片(big)
  versions :icon => '60x60', :small => '175x175', :middle => '418x418',:big => '1024x1024',:accordion=> '220x118'

end

#此类用于获取默认图片
class DefVersion
  def initialize(version)
    @version = version   
  end
  def url
    "/images/fallback/product/#{@version}.png"
  end
end
