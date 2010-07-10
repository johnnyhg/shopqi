# encoding:utf-8
require 'spec_helper'

describe Nav do
  before(:each) do
    @page = Factory('page_mbaobao')
    @page.navs.init_list!

    @customer = @page.navs.where(:name => '会员中心').first
    @order = @page.navs.where(:name => '订单查询').first
  end

  it "should be sort" do
    @page.reload.sorted_navs.map(&:name).should == ['会员中心', '订单查询', '网站导航', '帮助']
  end
    
  it "should be move below" do
    @customer.move_below(@order)
    @page.navs.init_list!
    @page.reload.sorted_navs.map(&:name).should == ['订单查询', '会员中心', '网站导航', '帮助']
  end
    
  it "should be move above" do
    @order.move_above(@customer)
    @page.navs.init_list!
    @page.reload.sorted_navs.map(&:name).should == ['订单查询', '会员中心', '网站导航', '帮助']
  end

  #在会员中心之前添加导航
  it "should insert above nav" do
    @page.navs.create :name => '建议', :url => '/complain', :neighbor => @order.id, :direct => :above
    @page.reload.sorted_navs.map(&:name).should == ['会员中心', '建议', '订单查询', '网站导航', '帮助']
  end

  #在会员中心之后添加导航
  it "should insert below nav" do
    @page.navs.create :name => '投诉', :url => '/complain', :neighbor => @order.id, :direct => :below
    @page.reload.sorted_navs.map(&:name).should == ['会员中心', '订单查询', '投诉', '网站导航', '帮助']
  end
end
