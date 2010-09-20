# encoding:utf-8
require 'spec_helper'

describe Nav do
  before(:each) do
    @saberma = Factory(:user_saberma)
    @saberma.make_current

    @store = @saberma.store
    @store.navs = []
    %w( 会员中心 订单查询 网站导航 帮助 ).each do |nav|
      @store.navs << Nav.new(:name => nav)
    end
    @store.navs.init_list!
    @store.reload

    @customer = @store.navs.where(:name => '会员中心').first
    @order = @store.navs.where(:name => '订单查询').first
  end

  it "should be sort" do
    @store.sorted_navs.map(&:name).should == ['会员中心', '订单查询', '网站导航', '帮助']
  end
    
  it "should be move below" do
    @customer.move_below(@order)
    @store.navs.init_list!
    @store.reload.sorted_navs.map(&:name).should == ['订单查询', '会员中心', '网站导航', '帮助']
  end
    
  it "should be move above" do
    @order.move_above(@customer)
    @store.navs.init_list!
    @store.reload.sorted_navs.map(&:name).should == ['订单查询', '会员中心', '网站导航', '帮助']
  end

  #在会员中心之前添加导航
  it "should insert above nav" do
    complain = @store.navs.create :name => '建议', :url => '/complain'
    @store.navs.init_list!
    complain.reload.move(:above => @order)
    @store.sorted_navs.map(&:name).should == ['会员中心', '建议', '订单查询', '网站导航', '帮助']
  end

  #在会员中心之后添加导航
  it "should insert below nav" do
    complain = @store.navs.new(:name => '投诉', :url => '/complain')
    @store.navs << complain
    @store.navs.init_list!
    complain.reload.move(:below => @order)

    @store.sorted_navs.map(&:name).should == ['会员中心', '订单查询', '投诉', '网站导航', '帮助']
  end
end
