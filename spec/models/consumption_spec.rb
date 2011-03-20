require 'spec_helper'

describe Consumption do
  before :each do
    with_resque{ @user = Factory(:user_saberma) }
    @store = @user.store
    @consumption = @store.consumptions.create
  end

  describe :pay do
    it 'deadline not past' do
      @consumption.pay!
      @consumption.state_key.should eql :payed
      @store.deadline.should eql Date.today.next_day(10).next_year
    end

    it 'deadline past' do
      @store.update_attributes :deadline => Date.yesterday
      @consumption.pay!
      @store.deadline.should eql Date.today.next_year
    end
  end
end
