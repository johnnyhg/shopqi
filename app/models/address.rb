# encoding: utf-8
# 收货地址
class Address
  include Extensions::Base
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
