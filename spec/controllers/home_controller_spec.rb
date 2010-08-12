require 'spec_helper'

describe HomeController do
  # devise测试辅助类，否则会报错误:undefined method `authenticate!' for nil:NilClass
  include Devise::TestHelpers

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "dashboard" do
    it "require user to login" do
      get 'show'
      response.should redirect_to(new_user_session_path)
    end

    it "should be show" do
      sign_in(Factory(:user))
      get 'show'
      response.should be_success
    end
  end
end
