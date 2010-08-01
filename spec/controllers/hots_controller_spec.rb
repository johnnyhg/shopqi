# encoding: utf-8
require 'spec_helper'

describe HotsController do
  it "should be update" do
    page = Page.create :name => :rspec
    hot = Hot.new :name => '男装'
    page.hots << hot
    page.save
    lambda do
      xhr :post, :update, :id => hot.id, :image => {
        :name => '男士衬衫'
      }
      response.should be_success
    end.should_not change(Hot, :count)
  end
end
