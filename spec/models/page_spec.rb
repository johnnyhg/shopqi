require 'spec_helper'

describe Page do
  it "should have logo" do
    @saberma = Factory(:user_saberma)
    @saberma.make_current

    page = @saberma.store.pages.homepage
    page.logo.should_not be_nil
  end
end
