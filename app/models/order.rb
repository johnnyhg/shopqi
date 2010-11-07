# encoding: utf-8
# TODO:带有时间限制的优惠折扣可能会造成商品价格混乱，因此超过一定时间(24小时?)未付款的订单将自动删除
class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Transitions
  include SimpleEnum

  referenced_in :member
  embeds_many :items, :class_name => "OrderItem"

  field :delivery_id
  has_enum :delivery, :enums => [[:normal, 0, "普通快递送货上门"],[:ems, 1, "邮政特快专递EMS"]]

  field :pay_id
  has_enum :pay, :enums => [[:online, 0, "网上支付"],[:onsee, 1, "货到付款"], [:post, 2, "邮局汇款"], [:bank, 3, "银行转帐"]]

  field :receive_id
  has_enum :receive, :enums => [[:all, 0, "工作日、双休日与假日均可送货"],[:holiday, 1, "只有双休日、假日送货（工作日不用送货）"], [:weekday, 2, "只有工作日送货（双休日、假日不用送）"], [:school, 3, "学校地址（该地址白天没人，请尽量安排其他时间送货）"]]

  field :number
  field :price_sum, :type => Float
  field :state

  field :description

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
  validates_length_of :description, :maximum => 100

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
