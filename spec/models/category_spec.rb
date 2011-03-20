# encoding: utf-8
require 'spec_helper'

describe Category do
  before :each do
    @store = Store.create
    @root = @store.categories.create
    @category = @store.categories.create(Factory.attributes_for(:category_man))
    @root.children << @category

    %w( 衬衫 POLO衫 针织衫 外套 ).each do |label| 
      @category.children << @store.categories.build(Factory.attributes_for(:category, :name => label))
    end
  end

  it 'should be move' do
    parent = @root.children.first
    parent.children.map(&:name).should eql %w( 衬衫 POLO衫 针织衫 外套 )

    node = @store.categories.where(:name => '衬衫').first
    neighbor = @store.categories.where(:name => '针织衫').first

    node.move_above neighbor
    parent.reload.children.map(&:name).should eql %w( POLO衫 衬衫 针织衫 外套 )
  end

  it 'should reset products category_parent_ids' do
    node = @store.categories.where(:name => '衬衫').first
    category = @store.categories.create :name => '男士衬衫'
    node.children << category
    category.parent_ids.should eql node.full_parent_ids

    category.products << @store.products.build(:name => '博士衬衫1')
    category.save
    category.products.first.category_parent_ids.should eql category.full_parent_ids

    category.parent = node.parent
    category.save
    category.parent_ids.should eql node.parent_ids

    category.products.first.reload.category_parent_ids.should eql category.full_parent_ids
  end
end
