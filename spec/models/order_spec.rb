require 'spec_helper'

describe Order do
  before :each do
    @saberma = Factory(:user_saberma)
    @store = @saberma.store
    @member = @store.members.create(Factory.attributes_for(:member_saberma))
    @address = @member.addresses.create(Factory.attributes_for(:address))
    @payment = @store.payments.create(Factory.attributes_for(:payment))

    #product
    @root = @store.categories.roots.first
    @category = @store.categories.create(Factory.attributes_for(:category_man))
    @root.children.push(@category).init_list!
    @product = @store.products.create(Factory.attributes_for(:product, :category => @category))
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
     @order = @member.orders.build(:address_id => @address.id.to_s, :payment => @payment)
     @order.items.build :product => @product, :price => @product.price, :quantity => 1, :sum => @product.price
     @order.save
    end

    it 'should set number' do
     @order.number.should_not be_nil
    end

    it 'should be save' do
     @order.pay_state.should eql 'unpay'
     @order.store.should eql @store
    end

    it 'should set address' do
      @order.name.should eql @address.name
      @order.province.should eql @address.province
    end

    it 'should set price sum' do
      @order.price_sum.should eql @product.price
    end

    it 'should be cancel' do
      @order.cancel!
      @order.state.should eql 'cancelled'
    end
  end
end
