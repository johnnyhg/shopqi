# encoding: utf-8
class Payment
  include Mongoid::Document
  include Mongoid::BelongToStore
  belong_to_store

  field :payment_type_id
  field :account
end
