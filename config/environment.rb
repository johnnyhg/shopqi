# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Shopqi::Application.initialize!

# active_merchant支付接口
ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)

# 本地支付信息已经由config/initializers/payment.rb文件定义
unless defined?(ActiveMerchant::Billing::Integrations::Alipay::KEY)
  # 依次为合作者身份ID、安全校验码、签约的支付宝帐号(可能是手机号码)
  ActiveMerchant::Billing::Integrations::Alipay::ACCOUNT = 'vancl'
  ActiveMerchant::Billing::Integrations::Alipay::KEY = 'shopqi'
  ActiveMerchant::Billing::Integrations::Alipay::EMAIL = 'vancl@shopqi.com'
end
