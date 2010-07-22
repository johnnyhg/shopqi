# encoding:utf-8
require 'spec_helper'

describe Menu do
  it "should create the sprite image" do
    page = Factory :page_mbaobao
    Menu.sprite(page)
    path = "#{Rails.root}/public/images/menu/#{page.id}.png"
    File.exist?(path).should eql true
    FileUtils.rm_f(path) 
  end
end
