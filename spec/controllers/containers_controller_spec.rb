require 'spec_helper'

describe ContainersController do
  include Devise::TestHelpers

  before :each do
    @saberma = Factory(:user_saberma)
    @store = @saberma.store
    sign_in @saberma

    @page = @store.pages.homepage
    @root = @page.containers.roots.first
    @root_container = @store.containers.create(:type => :products, :parent_id => @root.id)
    @container = @root_container.children.first
  end

  it 'should save categories' do
    @root = @store.categories.roots.first
    @category = @store.categories.create(Factory.attributes_for(:category_man))
    @root.children << @category
    @root.children.init_list!

    xhr :put, :update, :id => @container.id.to_s, :container => {
      :category_ids => [ @category.id.to_s ]
    }
    response.should be_success
    @container.reload.categories.size.should eql 1
  end

  it 'should save via type' do
    lambda do
      xhr :post, :create, :container => {
        :parent_id => @root.id.to_s,
        :type => :focuses
      }
      response.should be_success
    end.should change(Container, :count).by(3)
  end
end
