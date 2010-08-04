# encoding: utf-8
require 'spec_helper'

describe CategoriesController do
  before :each do
    %w( 男装 女装 ).each do |label|
      Factory(:category_with_son, :name => label)
    end
  end

  it 'should be index' do
    xhr :get, :index, :id => ''
    response.should be_success
    json = ActiveSupport::JSON.decode(response.body)
    json.size.should eql 2
    json.map{|h| h['data']}.should eql %w( 男装 女装 )
    json.last['children'].size.should eql 1
  end

  it 'should show children' do
    category = Category.roots.first
    xhr :get, :index, :id => category.id
    response.should be_success
    json = ActiveSupport::JSON.decode(response.body)
    json.size.should eql 1
    json.map{|h| h['data']}.should eql category.children.map(&:name)
  end
end
