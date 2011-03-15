# encoding: utf-8
require 'spec_helper'

describe Category do
  before :each do
    with_resque{ @saberma = Factory(:user_saberma) }
    @store = @saberma.store
    @root = @store.categories.roots.first
    @category = @store.categories.create(Factory.attributes_for(:category_man))
    @root.children << @category
    @root.children.init_list!

    %w( 衬衫 POLO衫 针织衫 外套 ).each do |label| 
      @category.children << @store.categories.build(Factory.attributes_for(:category, :name => label))
    end
    @category.children.init_list!
  end

  it 'should be move' do
    parent = @root.children.first
    parent.children.map(&:name).should eql %w( 衬衫 POLO衫 针织衫 外套 )

    node = @store.categories.where(:name => '衬衫').first
    neighbor = @store.categories.where(:name => '针织衫').first

    node.move :above => neighbor
    parent.children.map(&:name).should eql %w( POLO衫 衬衫 针织衫 外套 )
  end

  it 'should reset products category_path' do
    node = @store.categories.where(:name => '衬衫').first
    category = @store.categories.create :name => '男士衬衫'
    node.children << category
    node.children.init_list!
    category.path.should eql node.full_path

    category.products << @store.products.build(:name => '博士衬衫1')
    category.save
    category.products.first.category_path.should eql category.full_path

    category.parent_id = node.parent.id
    category.save
    category.path.should eql node.path

    category.products.first.reload.category_path.should eql category.full_path
  end
end
