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

  it 'should save via type' do
    lambda do
      xhr :post, :create, :container => {
        :parent_id => @container.id.to_s,
        :type => :focuses
      }
      response.should be_success
    end.should change(Container, :count).by(2)
  end
end
