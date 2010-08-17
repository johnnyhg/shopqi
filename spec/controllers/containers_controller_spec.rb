require 'spec_helper'

describe ContainersController do
  include Devise::TestHelpers

  before :each do
    @saberma = Factory(:user_saberma)
    sign_in @saberma

    @page = @saberma.store.pages.homepage
    @container = @page.containers.create
  end

  it 'should save categories' do
    category = Factory(:category_man)
    xhr :put, :update, :id => @container.id.to_s, :container => {
      :category_ids => [ category.id.to_s ]
    }
    response.should be_success
    @container.reload.categories.size.should eql 1
  end
end
