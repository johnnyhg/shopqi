require 'spec_helper'

describe PagesController do
  include Devise::TestHelpers

  describe "user doesn't login" do
    it 'should not be config' do
      get :show
      response.should be_redirect
    end
  end
end
