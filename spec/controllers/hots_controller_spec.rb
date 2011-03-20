# encoding: utf-8
require 'spec_helper'

describe HotsController do
  include Devise::TestHelpers

  before :each do
    with_resque{ @saberma = Factory(:user_saberma) }
    @store = @saberma.store
    sign_in @saberma

    @page = @store.pages.homepage
    @root = @page.containers.roots.first
    # 新增三个容器，包括两个父容器和最后一个实际容器(中间的父容器是为了能够不断的向下方新增子容器)
    @root_container = @store.containers.create(:type => :hots, :parent_id => @root.id)
    @container = @root_container.children.first.children.first

    @root_hot = @container.hot
    @root_hot.children << @store.hots.build(:name => '男装')
  end

  describe 'root' do
    it "should be add" do
      xhr :get, :new, :neighbor => @root_hot.id, :direct => :above, :hot => {
        :parent_id => ''
      }
      response.should be_success
    end

    it "should be create" do
      lambda do
        xhr :post, :create, :hot => {
          :name => '男士衬衫',
          :parent_id => @root_hot.id
        }
        response.should be_success
      end.should change(Hot, :count).by(1)
    end

    it "should be update" do
      lambda do
        xhr :post, :update, :id => @root_hot.id, :hot => {
          :name => '男士衬衫', :parent_id => ''
        }
        response.should be_success
        assigns[:hot].name.should eql '男士衬衫'
      end.should_not change(Hot, :count)
    end
  end

  describe 'child' do
    before :each do

      @child = @store.hots.build :name => '衬衫'
      @root_hot.children << @child
      @root_hot.save
      @child.reload
    end

    it "should be create" do
      lambda do
        xhr :post, :create, :hot => {
          :name => '男士衬衫',
          :parent_id => @root_hot.id
        }
        response.should be_success
      end.should change(Hot, :count).by(1)
    end

    it "should be update" do
      lambda do
        xhr :post, :update, :id => @child.id, :hot => {
          :name => '男士衬衫', :parent_id => @root_hot.id
        }
        response.should be_success
        assigns[:hot].name.should eql '男士衬衫'
      end.should_not change(Hot, :count)
    end

    it "should be create neighbor" do
      @child = @store.hots.build :name => '衬衫'
      @root_hot.children << @child
      @root_hot.save
      @child.reload
      lambda do
        xhr :post, :create, :neighbor => @child.id, :direct => :above, :hot => {
          :name => '西装',
          :parent_id => @child.parent.id
        }
        response.should be_success
        assigns[:hot].parent.should eql @root_hot
      end.should change(Hot, :count).by(1)
    end
  end

end
