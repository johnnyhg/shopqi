# encoding:utf-8
require 'spec_helper'

describe Menu do
  it "should create the sprite image" do
    @saberma = Factory(:user_saberma)
    @saberma.make_current
    
    %w( 首页 女包 男包 真皮 数码包 旅行包 ).map do |menu|
      Menu.create :name => menu
    end
    store = @saberma.store
    Menu.sprite(store)
    path = "#{Rails.root}/public/images/menu/#{store.id}.png"
    File.exist?(path).should eql true
    FileUtils.rm_f(path) 
  end
end
