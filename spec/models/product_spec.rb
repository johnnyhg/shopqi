require 'spec_helper'

describe Product do
  before :each do
    @saberma = Factory(:user_saberma)
    @root = @saberma.store.categories.roots.first
    @category_man = Factory(:category_man)
    @root.children << @category_man
    @root.children.init_list!
  end

  describe :category_path do
    before :each do
      @product = Factory(:product, :category => @category_man)
    end

    it 'should save' do
      @product.category_path.should eql @category_man.full_path
    end

    it 'should find by category_id' do
      Product.where(:category_id.in => [@category_man.id]).to_a.should eql [@product]
    end

    it 'should find by category_path' do
      Product.any_in(:category_path => [@category_man.id]).to_a.should eql [@product]
    end

  end
end
