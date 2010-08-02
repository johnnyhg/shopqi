# encoding: utf-8
require 'spec_helper'

describe HotsController do
  before :each do
    @page = Factory(:page_mbaobao)

    @root = Hot.new :name => '男装'
    @page.hots << @root
    @page.hots.init_list!
    @page.save
    @root.reload
  end

  describe 'root' do
    it "should be add" do
      xhr :get, :new, :hot => {
        :neighbor => @root.id,
        :parent_id => '',
        :direct => :above
      }
      response.should be_success
    end

    it "should be create" do
      lambda do
        xhr :post, :create, :hot => {
          :name => '男士衬衫'
        }
        response.should be_success
      end.should change(Hot, :count).by(1)
    end

    it "should be update" do
      lambda do
        xhr :post, :update, :id => @root.id, :hot => {
          :name => '男士衬衫', :parent_id => ''
        }
        response.should be_success
        assigns[:hot].name.should eql '男士衬衫'
      end.should_not change(Hot, :count)
    end
  end

  describe 'child' do
    before :each do
      @child = Hot.new :name => '衬衫'
      @root.children << @child
      @root.children.init_list!
      @root.save
      @child.reload
    end

    it "should be create" do
      lambda do
        xhr :post, :create, :hot => {
          :name => '男士衬衫',
          :parent_id => @root.id
        }
        response.should be_success
      end.should change(Hot, :count).by(1)
    end

    it "should be update" do
      lambda do
        xhr :post, :update, :id => @child.id, :hot => {
          :name => '男士衬衫', :parent_id => @root.id
        }
        response.should be_success
        assigns[:hot].name.should eql '男士衬衫'
      end.should_not change(Hot, :count)
    end

    it "should be create neighbor" do
      @child = Hot.new :name => '衬衫'
      @root.children << @child
      @root.children.init_list!
      @root.save
      @child.reload
      lambda do
        xhr :post, :create, :hot => {
          :name => '西装',
          :neighbor => @child.id,
          :direct => :above,
          :parent_id => @child.parent.id
        }
        response.should be_success
        assigns[:hot].parent.should eql @root
      end.should change(Hot, :count).by(1)
    end
  end

end
