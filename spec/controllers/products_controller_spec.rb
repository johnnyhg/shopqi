# encoding: utf-8
require 'spec_helper'

describe ProductsController do
  include Devise::TestHelpers
  before :each do
    with_resque{ @saberma = Factory(:user_saberma) }
    @store = @saberma.store
    sign_in @saberma
    request.host = "#{@store.subdomain}.shopqi.com"
  end

  describe :product do
    before :each do
      @root = @store.categories.root
      @category = @store.categories.create(Factory.attributes_for(:category_man, :parent => @root))
      @product = @store.products.create(Factory.attributes_for(:product, :category => @category))
    end

    it "should be index" do
      get :index, :category_id => @category.id.to_s
      assigns[:products].size.should eql 1
    end

    it "should be update" do
      post :update, :id => @product.id.to_s, :product => { :id => @product.id.to_s, :name => '新男装' }
      @product.reload.name.should eql '新男装'
    end

    it 'should add to car' do
      post :add_to_car, :id => @product.id.to_s, :quantity => 1, :format => :js
      cookies['order'].should eql "#{@product.id.to_s}|1"

      post :add_to_car, :id => @product.id.to_s, :quantity => 1, :format => :js
      cookies['order'].should eql "#{@product.id.to_s}|2"
    end
  end

  describe :photo do
    it "should be upload" do
      lambda do
        xhr :post, :upload, :id => BSON::ObjectId.from_time(Time.now).to_s, :photo => { :file => File.open("#{Rails.root}/public/images/logo.jpg") }
        response.should be_success

        assigns[:product].new_record?.should be_false
        photo = assigns[:photo]
        photo.file.versions.map(&:first).each do |version|
          File.exist?(photo.file.send(version).path).should eql true
          FileUtils.rm_f(photo.file.send(version).path)
        end
      end.should change(Product, :count).by(1)
    end

    it "should be validate" do
      xhr :post, :upload, :id => BSON::ObjectId.from_time(Time.now).to_s, :photo => { :file => File.open("#{Rails.root}/public/robots.txt") }

      assigns[:product].new_record?.should be_false

      photo = assigns[:photo]
      photo.new_record?.should be_true
      if photo.errors.empty?
        photo.file.versions.map(&:first).each do |version|
          File.exist?(photo.file.send(version).path).should eql false
          FileUtils.rm_f(photo.file.send(version).path)
        end
      end
    end
  end
  
end
