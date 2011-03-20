require 'spec_helper'

describe ConsumptionsController do
  include Devise::TestHelpers
  before :each do
    with_resque{ @saberma = Factory(:user_saberma) }
    @consumption = @saberma.store.consumptions.create
  end
  
  it 'should be notify' do
    notification = mock('notification')
    ActiveMerchant::Billing::Integrations::Alipay::Notification.stub!(:new).and_return(notification)
    notification.should_receive(:acknowledge).and_return(true)
    controller.should_receive(:valid?).and_return(true)

    notification.should_receive(:out_trade_no).and_return(@consumption.id.to_s)
    notification.should_receive(:status).and_return("TRADE_FINISHED")

    post :notify
    assigns[:consumption].state_key.should eql :payed
  end

end
