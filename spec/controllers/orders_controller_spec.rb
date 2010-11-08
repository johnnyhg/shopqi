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

  it 'should be create' do
    @ben = Factory(:member_ben)
    sign_in @ben

    cookies = mock('cookies')
    cookies.stub!(:[]=)
    controller.stub!(:cookies).and_return(cookies)
    # 格式: product_id|quantity;product_id|quantity
    cookie_order = "#{@product.id.to_s}|2"
    cookies.should_receive(:[]).with('order').at_least(:once).and_return(cookie_order)

    address = @ben.addresses.create(Factory.attributes_for(:address))

    lambda do
      post :create, :order => { :address_id => address.id.to_s, :delivery => 1, :pay => 1, :receive => 1 }, :format => :js
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
end
