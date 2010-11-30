# encoding: utf-8
require 'spec_helper'

describe PaymentsController do
  include Devise::TestHelpers

  before :each do
    @saberma = Factory(:user_saberma)
    request.host = "#{@saberma.store.subdomain}.shopqi.com"

    sign_in @saberma
  end

  it 'should be index' do
    get :index, :format => :js
    response.should be_success
  end

  it 'should be create or update' do
    lambda do
      post :post_data, :id => '4cf4b4a00000000000000000', :acount => '1111', :format => :js
    end.should change(Payment, :count).by(1)
    lambda do
      post :post_data, :id => '4cf4b4a00000000000000000', :acount => '2222', :format => :js
    end.should_not change(Payment, :count)
  end
end
