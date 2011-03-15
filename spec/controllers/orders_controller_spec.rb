# encoding: utf-8
require 'spec_helper'

describe OrdersController do
  include Devise::TestHelpers
  before :each do
    with_resque{ @saberma = Factory(:user_saberma) }
    @store = @saberma.store
    @payment = @store.payments.create(Factory.attributes_for(:payment))
    request.host = "#{@saberma.store.subdomain}.shopqi.com"

    @root = @store.categories.roots.first
    @category = @store.categories.create(Factory.attributes_for(:category_man))
    @root.children.push(@category).init_list!
    @product = @store.products.create(Factory.attributes_for(:product, :category => @category))
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
        @member = @store.members.create(Factory.attributes_for(:member_ben))
        sign_in @member

        get :new
        response.should be_success
      end
    end
  end

  describe :member do
    before :each do
      @member = @store.members.create(Factory.attributes_for(:member_ben))
      sign_in @member

      @address = @member.addresses.create(Factory.attributes_for(:address))
    end

    it 'should be create' do
      cookies = mock('cookies')
      cookies.stub!(:[]=)
      controller.stub!(:cookies).and_return(cookies)
      # 格式: product_id|quantity;product_id|quantity
      cookie_order = "#{@product.id.to_s}|2"
      cookies.should_receive(:[]).with('order').at_least(:once).and_return(cookie_order)

      lambda do
        post :create, :order => { :address_id => @address.id.to_s, :delivery => 1, :payment_id => @payment.id.to_s, :receive => 1 }, :format => :js
        order = assigns[:order]
        order.price_sum.should eql 30.0
        order.quantity.should eql 2

        order.delivery.should eql 1
        order.payment.should eql @payment
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

    describe :pay do
      before :each do
        @order = @member.orders.build(:address_id => @address.id.to_s, :payment => @payment)
        @order.items.build :product => @product, :price => @product.price, :quantity => 1, :sum => @product.price
        @order.save
      end

      it 'should be cancel' do
        post :cancel, :id => @order.id.to_s, :format => :js
        assigns[:order].state.should eql 'cancelled'
      end
      
      it 'should be notify' do
        notification = mock('notification')
        ActiveMerchant::Billing::Integrations::Alipay::Notification.stub!(:new).and_return(notification)
        notification.should_receive(:acknowledge).and_return(true)

        notification.should_receive(:out_trade_no).and_return(@order.id.to_s)
        notification.should_receive(:status).and_return("TRADE_FINISHED")

        post :notify
        assigns[:order].pay_state.should eql 'payed'
      end
      
      it 'should be show pay success' do
        rtn = mock('return')
        ActiveMerchant::Billing::Integrations::Alipay::Return.stub!(:new).and_return(rtn)
        rtn.should_receive(:success?).and_return(true)
        rtn.should_receive(:order).and_return(@order.id.to_s)
        get :done
        assigns[:order].should eql @order
      end

      describe 'user' do
        it 'should change order state' do
          sign_in @saberma
          post :ship, :id => @order.id.to_s, :format => :js
          assigns[:order].ship_state.should eql 'shipped'
          response.should be_success
        end
      end

    end
  end

end
