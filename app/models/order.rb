# encoding: utf-8
# TODO:带有时间限制的优惠折扣可能会造成商品价格混乱，因此超过24小时未付款的订单将自动删除(京东做法)
class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  referenced_in :member
  embeds_many :items, :class_name => "OrderItem"

  field :number, :type => Integer
  field :price_sum, :type => Float
  field :state, :type => Integer
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
