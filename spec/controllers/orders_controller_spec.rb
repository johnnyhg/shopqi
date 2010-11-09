# encoding: utf-8
require 'spec_helper'

describe OrdersController do
  include Devise::TestHelpers
  before :each do
    @saberma = Factory(:user_saberma)
    request.host = "#{@saberma.store.subdomain}.shopqi.com"

    @root = @saberma.store.categories.roots.first
    @category = Factory(:category_man)
    @root.children << @category
    @product = Factory(:product, :category => @category)
  end

  describe 'confirm' do
    describe 'not login' do
      it 'should redirect to login page' do
        get :new
        response.should redirect_to(new_member_session_path)
      end
    end

    describe 'login' do
      it 'should redirect to order new page' do
        @ben = Factory(:member_ben)
        sign_in @ben

        get :new
        response.should be_success
      end
    end
  end

  describe :member do
    before :each do
      @ben = Factory(:member_ben)
      sign_in @ben

      @address = @ben.addresses.create(Factory.attributes_for(:address))
    end

    it 'should be create' do
      cookies = mock('cookies')
      cookies.stub!(:[]=)
      controller.stub!(:cookies).and_return(cookies)
      # 格式: product_id|quantity;product_id|quantity
      cookie_order = "#{@product.id.to_s}|2"
      cookies.should_receive(:[]).with('order').at_least(:once).and_return(cookie_order)

      lambda do
        post :create, :order => { :address_id => @address.id.to_s, :delivery => 1, :pay => 1, :receive => 1 }, :format => :js
        order = assigns[:order]
        order.price_sum.should eql 30.0
        order.quantity.should eql 2

        order.delivery.should eql 1
        order.pay.should eql 1
        order.receive.should eql 1

        # 保存商品购买清单
        order.items.size.should eql 1
        item = order.items.first
        item.product.should eql @product
        item.price.should eql @product.price
        item.quantity.should eql 2
        item.sum.should eql @product.price*2
      end.should change(Order, :count).by(1)
    end

    it 'should be cancel' do
      post :create, :order => { :address_id => @address.id.to_s}, :format => :js
      order = assigns[:order]
      post :cancel, :id => order.id.to_s, :format => :js
      order.state.should eql 'cancelled'
    end

    describe :pay do
      before :each do
        post :create, :order => { :address_id => @address.id.to_s}, :format => :js
        @order = assigns[:order]
      end
      
      it 'should be notify' do
        notification = mock('notification')
        ActiveMerchant::Billing::Integrations::Alipay::Notification.stub!(:new).and_return(notification)
        notification.should_receive(:acknowledge).and_return(true)

        notification.should_receive(:trade_no).and_return(@order.id.to_s)
        notification.should_receive(:status).and_return("TRADE_FINISHED")

        post :notify
        assigns[:order].state.should eql 'payed'
      end
      
      it 'should be show pay success' do
        rtn = mock('return')
        ActiveMerchant::Billing::Integrations::Alipay::Return.stub!(:new).and_return(rtn)
        rtn.should_receive(:success?).and_return(true)
        rtn.should_receive(:order).and_return(@order.id.to_s)
        get :done
        assigns[:order].should eql @order
      end

    end
  end

end
