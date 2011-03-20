# encoding: utf-8
require 'spec_helper'

describe ImagesController do
  include Devise::TestHelpers

  it "should be create" do
    lambda do
      xhr :post, :create, :image => { 
        :width => 300,
        :height => 200,
        :words => [{
          :x => 10,
          :y => 10,
          :font => :yahei,
          :color => '#618d5e',
          'font-size' => '12px',
          :text => :ShopQi
        }]
      }
    end.should change(Image, :count).by(1)
  end

  it "should be update" do
    #提交时带子项记录，则子项记录集合应为hash类型，其键值为对象所在序号(rails2是数组类型)
    #words => { "0" => { :x => ... }, "1" => { ... } }，而不是rails2时的: words => [ {:x => ...}, { ... } ]，这种写法会导致控制器忽略子项
    image = Factory(:image_with_words)
    image_attr = image.attributes
    image_attr[:words] = {}
    image.words.each_with_index do |word, index|
      image_attr[:words][index.to_s] = word.attributes.except(:_id)
      #https://github.com/mongoid/mongoid/blob/master/lib/mongoid/relations/builders/nested_attributes/many.rb#L115
      image_attr[:words][index.to_s][:id] = word.id
    end
    image_attr[:words][image.words.size.to_s] = Factory.attributes_for(:word, :text => :saberma)
    image_attr[:width] = 400

    xhr :put, :update, :id => image.id, :image => image_attr
    response.should be_success

    image.reload.words.size.should == image_attr[:words].size
  end

  it "should upload a background image" do
    image_attr = Factory.attributes_for(:image)
    image_attr[:backgrounds] = { '0' => { :file => File.open("#{Rails.root}/public/images/logo.jpg") } }
    xhr :post, :create, :image => image_attr
    response.should be_success

    image = assigns[:image].reload
    image.backgrounds.size.should eql 1
    bg = image.backgrounds.first
    File.exist?(bg.file.path).should eql true
    FileUtils.rm_f(bg.file.path)
  end
end
