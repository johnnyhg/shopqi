# encoding: utf-8
class PaymentType < ActiveHash::Base
  self.data = [
    {:id => 1, :name => '在线支付-支付宝'},
    {:id => 2, :name => '在线支付-财付通'},
    {:id => 3, :name => '在线支付-快钱'}
  ]
  attr_accessor :payment
  delegate :is_show, :account, :partnerid, :verifycode, :remark, :to => :payment, :allow_nil => true

  def self.all_in(store)
    all.each do |payment_type|
      payment_type.payment = store.payments.where(:payment_type_id => payment_type.id).first
    end
  end
end
