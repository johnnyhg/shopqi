# encoding: utf-8
require 'spec_helper'

describe Category do
  before :each do
    @saberma = Factory(:user_saberma)
    @root = @saberma.store.categories.roots.first
    @root.children << Factory(:category_man)
    @root.children.init_list!
  end

  it 'should be move' do
    parent = @root.children.first
    parent.children.map(&:name).should eql %w( 衬衫 POLO衫 针织衫 外套 )

    node = Category.where(:name => '衬衫').first
    neighbor = Category.where(:name => '针织衫').first

    node.move :above => neighbor
    parent.children.map(&:name).should eql %w( POLO衫 衬衫 针织衫 外套 )
  end

  it 'should reset products category_path' do
    node = Category.where(:name => '衬衫').first
    category = Category.create :name => '男士衬衫'
    node.children << category
    node.children.init_list!
    category.path.should eql node.full_path

    category.products << Product.new(:name => '博士衬衫1')
    category.save
    category.products.first.category_path.should eql category.full_path

    category.parent_id = node.parent.id
    category.save
    category.path.should eql node.path

    category.products.first.reload.category_path.should eql category.full_path
  end
end
