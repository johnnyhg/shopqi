require 'spec_helper'

describe PagesController do
  include Devise::TestHelpers
  before :each do
    with_resque{ @saberma = Factory(:user_saberma) }
    request.host = "#{@saberma.store.subdomain}.shopqi.com"
  end

  describe "user doesn't login" do
    it 'should not be config' do
      get :show, :config => true
      response.should be_redirect
    end
  end
end
