# encoding:utf-8
require 'spec_helper'

describe Image do

  it "should render a image" do
    image = Image.new :width => 251, :height => 44
    image.words.build :x => 5, :y => 0, :font => :fzsn, :size => 28, :color => '#E60012', :text => '麦包包', :background => :roundrectangle
    image.words.build :x => 110, :y => 5, :font => :haibao, :size => 20, :color => '#E60012', :text => '买包包? 麦包包!'
    image.save
    File.exist?("#{Rails.root}/public/images/logo/#{image.id}.png").should == true
    FileUtils.rm_f("#{Rails.root}/public/images/logo/#{image.id}.png")
  end

  #更新原有子记录的同时，新增新的子记录，不能抛出异常: #<Mongo::OperationFailure: have conflict mod>
  #由于mongo无法在一个update方法中同时使用set和push，所以此测试暂时无法通过
  #mongo语句:db.images.update({_id:"4c3ddc598e0dee0ab0000001"}, {$set:{ 'words.1.x': 10 }, $push:{ words:{x: 15} } });
  it "should be update" do
    lambda do
      image = Factory(:image_with_words)
      image.words.second.text = :saberma
      image.words.build Factory.attributes_for(:word)
      image.save!
    end.should_not raise_error
  end
end
