# encoding: utf-8
class PaymentType < ActiveHash::Base
  self.data = [
    {:id => :alipay, :name => '在线支付-支付宝'},
    {:id => :tenpay, :name => '在线支付-财付通'},
    {:id => :kuaiqian, :name => '在线支付-快钱'}
  ]
end
