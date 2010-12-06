# encoding: utf-8
class ConsumptionsController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update
  respond_to :js, :only => [:new, :create, :edit, :update]
  prepend_before_filter :authenticate_user!, :except => :notify

  # 完成支付后由支付网关调用
  def notify
    notification = ActiveMerchant::Billing::Integrations::Alipay::Notification.new(request.raw_post)
    if notification.acknowledge && valid?(notification)
      @consumption = end_of_association_chain.find(notification.out_trade_no)
      @consumption.pay! if notification.status == "TRADE_FINISHED"
      render :text => "success"
    else
      render :text => "fail"
    end
  end

  protected
  def begin_of_association_chain
    store
  end

  private
  # 确认验证请求是从支付宝发出的
  def valid?(notification)
    url = "http://notify.alipay.com/trade/notify_query.do"
    result = HTTParty.get(url, :query => {:partner => ActiveMerchant::Billing::Integrations::Alipay::ACCOUNT, :notify_id => notification.notify_id}).body
    result == 'true'
  end
end
