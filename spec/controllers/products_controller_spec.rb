# encoding: utf-8
require 'spec_helper'

describe ProductsController do
  include Devise::TestHelpers
  before :each do
    @saberma = Factory(:user_saberma)
    sign_in @saberma
  end

  it "should be index" do
    @root = @saberma.store.categories.roots.first
    @category = Factory(:category_man)
    @root.children << @category
    @product = Factory(:product, :category => @category)
    get :index, :category_id => @category.id.to_s
    assigns[:products].size.should eql 1
  end

  it "should upload a photo" do
    lambda do
      xhr :post, :upload, :id => BSON::ObjectID.from_time(Time.now).to_s, :photo => { :file => File.open("#{Rails.root}/public/images/logo.jpg") }
      response.should be_success

      assigns[:product].new_record?.should be_false
      photo = assigns[:photo]
      photo.file.versions.map(&:first).each do |version|
        File.exist?(photo.file.send(version).path).should eql true
        FileUtils.rm_f(photo.file.send(version).path)
      end
    end.should change(Product, :count).by(1)
  end

  it "should not upload a file(not photo)" do
    xhr :post, :upload, :id => BSON::ObjectID.from_time(Time.now).to_s, :photo => { :file => File.open("#{Rails.root}/public/robots.txt") }

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
