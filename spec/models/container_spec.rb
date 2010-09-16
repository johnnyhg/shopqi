require 'spec_helper'

describe Container do
  before :each do
    @saberma = Factory(:user_saberma)
    @saberma.make_current

    @page = @saberma.store.pages.homepage
  end

  describe 'grids less than parents grids' do
    it 'should add a root container' do
      root = @page.containers.roots.first
      lambda do
        root_container = Container.create(
          :parent_id => root.id,
          :type => :focuses
        )
        root_container.children.size.should eql 1
        root_container.type.should be_nil

        container = root_container.children.first
        container.children.size.should eql 1
        container.type.should be_nil

        focuses_container = container.children.first
        container.grids.should eql focuses_container.grids
      end.should change(Container, :count).by(3)
    end

    it 'should add a parent container' do
      root = @page.containers.roots.first
      container = Container.new
      root.children << container

      lambda do
        focuses_container = Container.create(
          :parent_id => container.id,
          :type => :focuses
        )
        focuses_container.children.size.should eql 1
        focuses_container.grids.should eql focuses_container.children.first.grids
      end.should change(Container, :count).by(2)
    end
  end

  it 'should save page_id' do
    root = @page.containers.roots.first
    root.page_id.should eql @page.id
  end

  describe 'item' do
    before :each do
      @root = @page.containers.roots.first
    end

    it 'should save focuses item' do
      lambda do
        @root.children << Container.create(:type => :focuses)
        container = @root.children.first.reload

        container.grids.should eql 18
        container.type.should eql 'focuses'
      end.should change(Focus, :count).by(4)
    end

    it 'should save hot item' do
      @root.children << Container.create(:type => :hots)
      container = @root.children.first.reload

      container.grids.should eql 18
      container.type.should eql 'hots'

      container.hot.children.size.should eql 3
    end

    it 'should save categories' do
      category = Factory(:category_man)

      root_container = Container.create(:type => :products, :parent_id => @root.id)
      container = root_container.children.first
      container.type.should eql 'products'

      container.categories.size.should eql 1
    end
  end
end
