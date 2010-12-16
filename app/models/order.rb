# encoding: utf-8
# TODO:带有时间限制的优惠折扣可能会造成商品价格混乱，因此超过一定时间(24小时?)未付款的订单将自动删除
class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Transitions
  include AddressHelper
  include SimpleEnum

  referenced_in :store
  referenced_in :member
  referenced_in :payment
  embeds_many :items, :class_name => "OrderItem"

  field :delivery_id, :type => Integer
  has_enum :delivery, :enums => [[:normal, 0, "普通快递送货上门"],[:ems, 1, "邮政特快专递EMS"]]

  field :receive_id, :type => Integer
  has_enum :receive, :enums => [[:all, 0, "工作日、双休日与假日均可送货"],[:holiday, 1, "只有双休日、假日送货（工作日不用送货）"], [:weekday, 2, "只有工作日送货（双休日、假日不用送）"], [:school, 3, "学校地址（该地址白天没人，请尽量安排其他时间送货）"]]

  field :number
  field :state

  field :description

  # 商品数量、总额
  field :quantity, :type => Integer
  field :price_sum, :type => Float

  # 收货人信息
  ADDRESS_EXCLUDE_ATTRIBUTES = ['created_at', 'updated_at', 'default']
  ADDRESS_ATTRIBUTES = Address.fields.keys - ADDRESS_EXCLUDE_ATTRIBUTES
  ADDRESS_ATTRIBUTES.each do |attr|
    field attr
  end

  # 状态
  state_machine do
    #@see cn.yml(state)
    state :unpay
    state :cancelled
    state :pay_wait
    state :pay_unknown_error
    state :payed_wait_send
    state :payed

    # 订单事件
    event :cancel do
      transitions :to => :cancelled, :from => :unpay
    end

    event :pend_payment do
      transitions :to => :pay_wait, :from => :unpay
    end

    event :pend_shipment do
      transitions :to => :payed_wait_send, :from => :unpay
    end

    event :fail_payment do
      transitions :to => :pay_unknown_error, :from => :unpay
    end

    event :pay do
      transitions :to => :payed, :from => :unpay
    end
  end

  # 会员收货地址ID
  attr_accessor :address_id

  validates_presence_of :store
  #TODO: 会员可能会删除收货地址
  validates_presence_of :address_id, :on => :create, :message => I18n.t('activemodel.errors.messages.select')
  validates_presence_of :payment_id, :message => I18n.t('activemodel.errors.messages.select')
  validates_presence_of :items
  validates_length_of :description, :maximum => 100

  before_validation :set_store
  before_create :set_address

  def set_store
    self.store ||= member.store
  end

  def set_address
    address = member.addresses.find(address_id)
    ADDRESS_ATTRIBUTES.each do |attr|
      send("#{attr}=", address.send(attr))
    end
  end

  def state_name
    I18n.t("state.#{state}")
  end
end

class OrderItem
  include Mongoid::Document
  embedded_in :order, :inverse_of => :items

  referenced_in :product

  # 价钱、数量、小计
  field :price, :type => Float
  field :quantity, :type => Integer
  field :sum, :type => Float
end
