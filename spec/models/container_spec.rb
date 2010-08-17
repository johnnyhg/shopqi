require 'spec_helper'

describe Container do
  before :each do
    @saberma = Factory(:user_saberma)
    @saberma.make_current

    @page = @saberma.store.pages.homepage
    @container = @page.containers.create
  end

  it 'should save categories' do
    category = Factory(:category_man)
    @container.category_ids = [ category.id.to_s ]
    @container.save.should be_true
    @container.reload.categories.size.should eql 1
  end
end
