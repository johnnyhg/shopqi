require 'spec_helper'

describe Order do
  before :each do
    @member = Factory(:member_saberma)
    @member.make_current
  end

  describe :invalid do
    it 'should check address_id' do
      lambda do
        @member.orders.create.errors[:address_id].should_not be_nil
      end.should_not change(Order, :count)
    end
  end

  describe :valid do
    before :each do
      @address = @member.addresses.create(Factory.attributes_for(:address))
    end

    it 'should init state' do
     @member.orders.create(:address_id => @address.id.to_s).state.should eql 'unpay'
    end

    it 'should set address' do
      order = @member.orders.create(:address_id => @address.id.to_s)
      order.name.should eql @address.name
      order.province.should eql @address.province
    end

    it 'should be cancel' do
      order = @member.orders.create(:address_id => @address.id.to_s)
      order.cancel!
      order.state.should eql 'cancelled'
    end
  end
end
