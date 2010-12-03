# encoding: utf-8
class PaymentType < ActiveHash::Base
  self.data = [
    {:id => '4cf4b4a00000000000000000', :name => '在线支付-支付宝'},
    {:id => '4cf4b4b00000000000000000', :name => '在线支付-财付通'},
    {:id => '4cf4b4c00000000000000000', :name => '在线支付-快钱'}
  ]
  attr_accessor :payment
  delegate :is_show, :account, :partnerid, :verifycode, :to => :payment, :allow_nil => true

  def self.all_in(store)
    all.each do |payment_type|
      payment_type.payment = store.payments.where(:payment_type_id => payment_type.id).first
    end
  end
end
