require 'spec_helper'

describe Container do
  before :each do
    @saberma = Factory(:user_saberma)
    @saberma.make_current

    @page = @saberma.store.pages.homepage
  end

  it 'should save item' do
    root = @page.containers.roots.first
    root.item.should be_nil

    root.children << Container.create(:type => :focuses)
    container = root.children.first.reload
    container.item.should_not be_nil
    container.item.type.should eql 'focuses'
    container.grids.should eql 18

    container.item.focuses.size.should eql 3
  end

  it 'should save page_id' do
    root = @page.containers.roots.first
    root.page_id.should eql @page.id
    root.store_id.should eql @saberma.store.id
  end

  it 'should save categories' do
    @container = @page.containers.create

    category = Factory(:category_man)
    @container.category_ids = [ category.id.to_s ]
    @container.save.should be_true
    @container.reload.categories.size.should eql 1
  end
end
