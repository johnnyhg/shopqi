# encoding: utf-8
require 'spec_helper'

describe PaymentsController do
  include Devise::TestHelpers

  before :each do
    with_resque{ @saberma = Factory(:user_saberma) }
    request.host = "#{@saberma.store.subdomain}.shopqi.com"

    sign_in @saberma
  end

  it 'should be index' do
    get :index, :format => :js
    response.should be_success
  end

  it 'should be create or update' do
    lambda do
      post :update_attribute_on_the_spot, :id => 'payment__account__1', :value => '1111', :format => :js
    end.should change(Payment, :count).by(1)
    lambda do
      post :update_attribute_on_the_spot, :id => 'payment__account__1', :value => '2222', :format => :js
    end.should_not change(Payment, :count)
  end
end
