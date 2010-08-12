require 'spec_helper'

describe Store do
  it 'should be create while user created' do
    lambda do
      @user = Factory(:user)
      @user.store.should_not be_nil
    end.should change(Store, :count).by(1)
  end

  it 'should create root category' do
    @user = Factory(:user)
    @user.store.categories.size.should eql 1
  end
end
