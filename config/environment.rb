# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Shopqi::Application.initialize!

# active_merchant支付接口
ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)

ActiveMerchant::Billing::Integrations::Alipay::KEY = 'shopqi'
ActiveMerchant::Billing::Integrations::Alipay::ACCOUNT = 'vancl'
ActiveMerchant::Billing::Integrations::Alipay::EMAIL = 'vancl@shopqi.com'
