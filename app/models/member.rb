# encoding: utf-8
module AddressHelper
  def region
    "#{District.get(province)}#{District.get(city)}#{District.get(district)}"
  end

  def telephone
    [mobile, phone].reject{|n| n.blank?}.join(',')
  end

  def address_info
    "#{name}(#{telephone}) #{region}#{detail} #{zipcode}"
  end
end

class Member
  include Mongoid::Document
  include SentientUser
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  referenced_in :store
  references_many :orders, :dependent => :destroy
  embeds_many :addresses

  field :login

  #@see: https://github.com/bokmann/sentient_user/blob/master/lib/sentient_user.rb
  def self.current
    Thread.current[:member]
  end

  def self.current=(o)
    Thread.current[:member] = o
  end

  def make_current
    Thread.current[:member] = self
  end
end

# 收货地址
class Address
  include Mongoid::Document
  include Mongoid::Timestamps
  include Formtastic::I18n::Naming
  include AddressHelper

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
  validate :at_least_one_telephone

  def at_least_one_telephone
    errors.add(:telephone, I18n.t('activemodel.errors.messages.at_least_one')) if mobile.blank? and phone.blank?
  end

  def self.default
    where(:default => true).first
  end

  def to_s
    address_info
  end
end
