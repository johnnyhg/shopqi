require 'spec_helper'

describe Address do
  before :each do
    with_resque{ @saberma = Factory(:user_saberma) }
    @store = @saberma.store
    @member = @store.members.create(Factory.attributes_for(:member_saberma))
  end

  it 'should update members addresses' do
    address = @member.addresses.create(Factory.attributes_for(:address))
    @member.addresses.size.should eql 1
    @member.addresses.find(address.id).should_not be_nil
  end
end
