# encoding: utf-8
# 网店的支付方式
class Payment
  include Mongoid::Document
  include Mongoid::BelongToStore
  belong_to_store

  field :payment_type_id, :type => Integer
  field :is_show, :type => Boolean, :default => false
  field :account
  field :partnerid
  field :verifycode
  field :remark

  def payment_type
    PaymentType.find(self.payment_type_id)
  end

  # 页面显示是否
  def is_show
    I18n.t("helper.common.#{read_attribute(:is_show)}")
  end

  def self.list
    self.where(:is_show => true)
  end
end
