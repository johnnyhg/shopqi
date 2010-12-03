# encoding: utf-8
# 网店的支付方式
class Payment
  include Mongoid::Document
  include Mongoid::BelongToStore
  belong_to_store

  field :payment_type_id
  field :is_show, :type => Boolean, :default => false
  field :account
  field :partnerid
  field :verifycode
  field :remark

  # 页面显示是否
  def is_show
    I18n.t("helper.common.#{read_attribute(:is_show)}")
  end
end
