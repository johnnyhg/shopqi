# encoding: utf-8
# 网店的支付方式
class Payment
  include Mongoid::Document
  include Mongoid::BelongToStore
  belong_to_store

  field :payment_type_id
  field :account
  field :partnerid
  field :verifycode
  field :is_show, :default => '否'
end
