# encoding: utf-8
class PaymentType < ActiveHash::Base
  self.data = [
    {:id => '4cf4b4a00000000000000000', :name => '在线支付-支付宝'},
    {:id => '4cf4b4b00000000000000000', :name => '在线支付-财付通'},
    {:id => '4cf4b4c00000000000000000', :name => '在线支付-快钱'}
  ]

  attr_reader :account

  def account_in(store)
    payment = store.payments.where(:payment_type_id => self.id).first
    @account = payment.account if payment
  end
end
