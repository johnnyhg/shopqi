# encoding: utf-8
class Shop < ActiveRecord::Base
  has_many :users
  has_many :products          , dependent: :destroy
  has_many :link_lists        , dependent: :destroy
  has_many :pages             , dependent: :destroy
  has_many :smart_collections , dependent: :destroy
  has_many :custom_collections, dependent: :destroy
  has_many :tags              , dependent: :destroy

  has_many :types             , dependent: :destroy, class_name: 'ShopProductType'
  has_many :vendors           , dependent: :destroy, class_name: 'ShopProductVendor'
  
  #二级域名须为3到20位数字和字母组成的，且唯一
  validates :permanent_domain, presence: true, uniqueness: true, format: {with:  /\A([a-z0-9])*\Z/ }, length: 3..20
  validates_presence_of :name
  
  before_create :init_valid_date
  
  protected
  def init_valid_date
    self.deadline = Date.today.next_day(10)
  end
  
  def available?
    !self.deadline.past?
  end
end

#商品类型
class ShopProductType < ActiveRecord::Base
  belongs_to :shop
end

#商品厂商
class ShopProductVendor < ActiveRecord::Base
  belongs_to :shop
end
