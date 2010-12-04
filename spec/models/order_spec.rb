require 'spec_helper'

describe Order do
  before :each do
    @member = Factory(:member_saberma)
    @address = @member.addresses.create(Factory.attributes_for(:address))
    @store = @member.store
    @payment = Factory(:payment, :store => @store)
  end

  describe :invalid do
    it 'should check address_id' do
      lambda do
        @member.orders.create(:payment => @payment).errors[:address_id].should_not be_nil
      end.should_not change(Order, :count)
    end

    it 'should check payment_id' do
      lambda do
        @member.orders.create(:address_id => @address.id.to_s).errors[:payment_id].should_not be_nil
      end.should_not change(Order, :count)
    end
  end

  describe :valid do
    before :each do
     @order = @member.orders.create(:address_id => @address.id.to_s, :payment => @payment)
    end

    it 'should be save' do
     @order.state.should eql 'unpay'
     @order.store.should eql @store
    end

    it 'should set address' do
      @order.name.should eql @address.name
      @order.province.should eql @address.province
    end

    it 'should be cancel' do
      @order.cancel!
      @order.state.should eql 'cancelled'
    end
  end
end
