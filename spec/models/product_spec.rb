require 'spec_helper'

describe Product do
  before :each do
    @store = Store.create
    @root = @store.categories.create
    @category_man = @store.categories.create(Factory.attributes_for(:category_man, :parent => @root))
  end

  describe :category_parent_ids do
    before :each do
      @product = @store.products.create(Factory.attributes_for(:product, :category => @category_man))
    end

    it 'should save' do
      @product.category_parent_ids.should eql @category_man.full_parent_ids
    end

    it 'should find by category_id' do
      Product.where(:category_id.in => [@category_man.id]).to_a.should eql [@product]
    end

    it 'should find by category_parent_ids' do
      Product.any_in(:category_parent_ids => [@category_man.id]).to_a.should eql [@product]
    end

  end
end
