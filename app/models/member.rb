# encoding: utf-8
class Member
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  referenced_in :store
  references_many :orders, :dependent => :destroy
  embeds_many :addresses

  field :login

end

# 收货地址
class Address
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :member, :inverse_of => :addresses

  field :name
  field :province
  field :city
  field :district
  field :detail
  field :zipcode
  field :mobile
  field :phone

  field :default, :type => Boolean, :default => true

  validates_presence_of :name, :province, :city, :district, :detail, :zipcode
  validates_presence_of :mobile, :if => "phone.blank?"
  validates_presence_of :phone, :if => "mobile.blank?"

  def self.default
    where(:default => true).first
  end

  def region
    "#{District.get(province)}#{District.get(city)}#{District.get(district)}"
  end

  def telephone
    [mobile, phone].reject{|n| n.blank?}.join(',')
  end
end
