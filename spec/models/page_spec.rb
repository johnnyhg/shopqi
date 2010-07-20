require 'spec_helper'

describe Page do
  it "should have logo" do
    page = Page.create :name => :ShopQi
    page.logo.should_not be_nil
  end
end
