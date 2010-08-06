# encoding: utf-8
require 'spec_helper'

describe Category do
  before :each do
    @root = Factory(:category_root)
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
end
