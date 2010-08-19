require 'spec_helper'

describe Product do
  before :each do
    @saberma = Factory(:user_saberma)
    @root = @saberma.store.categories.roots.first
    @category_man = Factory(:category_man)
    @root.children << @category_man
    @root.children.init_list!
  end

  it 'should find by categories' do
    product = Factory(:product, :category => @category_man)
    product.category_path.should eql @category_man.path
    Product.where(:category_id.in => [@category_man.id]).to_a.should eql [product]
  end

end
