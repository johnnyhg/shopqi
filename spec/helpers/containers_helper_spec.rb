require 'spec_helper'

describe ContainersHelper do
  include ApplicationHelper

  before :each do
    with_resque{ @saberma = Factory(:user_saberma) }
    @store = @saberma.store

    @root = @store.root_container
    @root_container = @store.containers.create(:parent_id => @root.id, :type => :focuses)
  end

  it 'should get root container class' do
    css_class = grid_class(@root.children, @root_container)
    css_class.should eql "container grid_24 root"
  end

  it 'should get grid parent container class' do
    containers = @root_container.children
    css_class = grid_class(containers, containers.first)
    css_class.should eql "container grid_18 alpha"
  end

  it 'should get container class' do
    containers = @root_container.children.first.children
    css_class = grid_class(containers, containers.first)
    css_class.should eql "container grid_18 alpha omega"
  end
end
