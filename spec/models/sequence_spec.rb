require 'spec_helper'

describe Sequence do
  it "should get a number" do
    Sequence.get(:vancl, Date.today).should_not be_blank
  end

  it "should get a next number" do
    day = Date.today.to_s(:serial)
    9.times do |i|
      Sequence.next(:vancl).should eql "#{day}0000#{i+1}"
    end
  end
end
