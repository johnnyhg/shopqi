# encoding: utf-8
class OrderItem
  include Mongoid::Document
  embedded_in :order, :inverse_of => :items

  referenced_in :product

  # 价钱、数量、小计
  field :price, :type => Float
  field :quantity, :type => Integer
  field :sum, :type => Float
end
