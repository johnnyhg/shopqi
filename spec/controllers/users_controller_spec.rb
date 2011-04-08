#encoding: utf-8
require 'spec_helper'

describe Devise::RegistrationsController do
  include Devise::TestHelpers
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "create new user has store" do
    it "should create the new store withe the specified subdomain" do
      post :create, :user=>{:store=>{:subdomain=>"liwh"}, :email=>"liwh@shopqi.com", :password=>"666666", :password_confirmation=>"666666", :login=>"小狼"}
      user =User.where(:email => "liwh@shopqi.com").first
      user.should_not be_nil
      user.store.subdomain.should == "liwh"
    end
  end
end
