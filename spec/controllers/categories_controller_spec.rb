# encoding: utf-8
require 'spec_helper'

describe CategoriesController do
  before :each do
    @root = Factory(:category_root)
    @root.children << Factory(:category_man) << Factory(:category_woman)
    @root.children.init_list!
  end

  it 'should be index' do
    xhr :get, :index, :id => ''
    response.should be_success
    json = ActiveSupport::JSON.decode(response.body)
    json.size.should eql 2
    json.map{|h| h['data']}.should eql %w( 男装 女装 )
    json.last['children'].size.should eql @root.children.last.children.size
  end

  it 'should show children' do
    category = @root.children.first
    xhr :get, :index, :id => category.id
    response.should be_success
    json = ActiveSupport::JSON.decode(response.body)
    json.size.should eql category.children.size
    json.map{|h| h['data']}.should eql category.children.map(&:name)
  end

  it 'should be move' do
    parent = @root.children.first
    parent.children.map(&:name).should eql %w( 衬衫 POLO衫 针织衫 外套 )

    node = Category.where(:name => '衬衫').first
    neighbor = Category.where(:name => '针织衫').first

    xhr :post, :update, :id => node.id, :category => { 
      :parent_id => parent.id,
      :neighbor => neighbor.id
    }
    response.should be_success
    
    parent.children.map(&:name).should eql %w( POLO衫 衬衫 针织衫 外套 )
  end
end
