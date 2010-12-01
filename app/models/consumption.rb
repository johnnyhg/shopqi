# encoding: utf-8
# 服务年费支付记录
class Consumption
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BelongToStore
  include SimpleEnum
  belong_to_store

  # 购买年次、总额
  field :years, :type => Integer, :default => 1
  field :price_sum, :type => Integer, :default => 3998

  # 支付状态
  field :state_id, :type => Integer
  has_enum :state, :enums => [[:unpay, 0, "待付款"], [:payed, 1, "已付款"]]

  # 未付款记录
  def self.unpay
    where(:state_id => 0).first
  end
end
