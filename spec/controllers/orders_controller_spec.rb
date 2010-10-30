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
        get :confirm
        response.should redirect_to(new_member_session_path)
      end
    end

    describe 'login' do
      it 'should redirect to order confirm page' do
        @ben = Factory(:member_ben)
        sign_in @ben

        get :confirm
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

    lambda do
      post :create, :format => :js
      assigns[:order].price_count.should eql 30.0
    end.should change(Order, :count).by(1)
  end
end
