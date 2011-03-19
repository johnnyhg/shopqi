require 'spec_helper'

describe StoreInitializer do
  before :each do
    with_resque{ @saberma = Factory(:user_saberma) }
    @store = @saberma.store
  end

  it 'should create menus' do
    @store.menus.root.children.size.should eql 3
  end
end
