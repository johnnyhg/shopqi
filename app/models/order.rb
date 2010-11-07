# encoding: utf-8
# TODO:带有时间限制的优惠折扣可能会造成商品价格混乱，因此超过一定时间(24小时?)未付款的订单将自动删除
class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Transitions
  referenced_in :member
  embeds_many :items, :class_name => "OrderItem"

  field :number
  field :price_sum, :type => Float
  field :state

  # 收货人信息
  ADDRESS_EXCLUDE_ATTRIBUTES = ['created_at', 'updated_at', 'default']
  ADDRESS_ATTRIBUTES = Address.fields.keys - ADDRESS_EXCLUDE_ATTRIBUTES
  ADDRESS_ATTRIBUTES.each do |attr|
    field attr
  end

  # 状态
  state_machine do
    state :start
  end

  # 会员收货地址ID
  attr_accessor :address_id

  validates_presence_of :address_id, :on => :create, :message => I18n.t('activemodel.errors.messages.select')

  before_create :set_address

  def set_address
    address = Member.current.addresses.find(address_id)
    ADDRESS_ATTRIBUTES.each do |attr|
      send("#{attr}=", address.send(attr))
    end
  end

end

class OrderItem
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :order, :inverse_of => :items

  referenced_in :product

  # 价钱、数量、小计
  field :price, :type => Float
  field :quantity, :type => Integer
  field :sum, :type => Float
end
