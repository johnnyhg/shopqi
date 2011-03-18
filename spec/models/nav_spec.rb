# encoding:utf-8
require 'spec_helper'

describe Nav do
  before(:each) do
    with_resque{ @saberma = Factory(:user_saberma) }
    @saberma.make_current

    @store = @saberma.store
    @root = @store.navs.root
    @root.children.clear
    %w( 会员中心 订单查询 网站导航 帮助 ).each do |nav|
      @store.navs.create(:name => nav, :parent => @root)
    end

    @customer = @store.navs.where(:name => '会员中心').first
    @order = @store.navs.where(:name => '订单查询').first
  end

  it "should be sort" do
    @root.children.map(&:name).should == ['会员中心', '订单查询', '网站导航', '帮助']
  end
    
  it "should be move below" do
    @customer.move_below(@order)
    @root.reload.children.map(&:name).should == ['订单查询', '会员中心', '网站导航', '帮助']
  end
    
  it "should be move above" do
    @order.move_above(@customer)
    @root.reload.children.map(&:name).should == ['订单查询', '会员中心', '网站导航', '帮助']
  end

  #在会员中心之前添加导航
  it "should insert above nav" do
    complain = @store.navs.create(:name => '建议', :url => '/complain', :parent => @root)
    complain.move(:above => @order)
    @root.reload.children.map(&:name).should == ['会员中心', '建议', '订单查询', '网站导航', '帮助']
  end

  #在会员中心之后添加导航
  it "should insert below nav" do
    complain = @store.navs.create(:name => '投诉', :url => '/complain', :parent => @root)
    complain.move(:below => @order)

    @root.reload.children.map(&:name).should == ['会员中心', '订单查询', '投诉', '网站导航', '帮助']
  end
end
