require 'spec_helper'

describe Store do
  describe :created do
    before :each do
      @user = Factory(:user_saberma)
      @store = @user.store
    end

    it 'should create logo' do
      @store.logo_image.should_not be_nil
    end

    it 'should create root category' do
      @store.categories.size.should eql 1
    end

    it 'should get order number' do
      day = Date.today.to_s(:serial)
      @store.next_order_sequence.should eql "#{day}00001"
    end

    it 'should get deadline' do
      today = Date.today
      @store.deadline.should eql today.next_day(10)
      @store.deadline_warning?.should be_true

      @store.update_attributes :deadline => today
      @store.deadline_warning?.should be_true

      @store.update_attributes :deadline => today.yesterday
      @store.deadline_warning?.should be_true
    end
  end

  it 'should be create while user created' do
    lambda do
      @user = Factory(:user_saberma)
      @store = @user.store
      @store.should_not be_nil
    end.should change(Store, :count).by(1)
  end
end
