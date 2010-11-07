require 'spec_helper'

describe Address do
  before :each do
    @member = Factory(:member_saberma)
    @member.make_current
  end

  it 'should update members addresses' do
    address = @member.addresses.create(Factory.attributes_for(:address))
    @member.addresses.size.should eql 1
    Member.current.addresses.find(address.id).should_not be_nil
  end
end
