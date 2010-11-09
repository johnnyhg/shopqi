require 'spec_helper'

describe Store do
  it 'should be create while user created' do
    lambda do
      @user = Factory(:user_saberma)
      @user.store.should_not be_nil
    end.should change(Store, :count).by(1)
  end

  it 'should create logo' do
    @user = Factory(:user_saberma)
    @user.store.logo_image.should_not be_nil
  end

  it 'should create root category' do
    @user = Factory(:user_saberma)
    @user.store.categories.size.should eql 1
  end

  it 'should get order number' do
    @user = Factory(:user_saberma)
    day = Date.today.to_s(:serial)
    @user.store.next_order_sequence.should eql "#{day}00001"
  end
end
