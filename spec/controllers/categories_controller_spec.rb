# encoding: utf-8
require 'spec_helper'

describe CategoriesController do
  include Devise::TestHelpers

  describe :normal do
    before :each do
      @saberma = Factory(:user_saberma)
      @store = @saberma.store
      sign_in @saberma

      @root = @store.categories.roots.first
      @category_man = @store.categories.create(Factory.attributes_for(:category_man))
      @category_woman = @store.categories.create(Factory.attributes_for(:category_woman))
      @root.children.push(@category_man).push(@category_woman).init_list!

      %w( 衬衫 POLO衫 针织衫 外套 ).each do |label| 
        @category_man.children << @store.categories.build(Factory.attributes_for(:category, :name => label))
      end
      @category_man.children.init_list!
    end

    it 'should be index' do
      xhr :get, :index, :id => ''
      response.should be_success
      json = ActiveSupport::JSON.decode(response.body)
      json.size.should eql 2
      json.map{|h| h['data']}.should eql %w( 男装 女装 )
      json.first['children'].size.should eql @category_man.children.size
    end

    it 'should show children' do
      category = @root.children.first
      xhr :get, :index, :id => category.id
      response.should be_success
      json = ActiveSupport::JSON.decode(response.body)
      json.size.should eql category.children.size
      json.map{|h| h['data']}.should eql category.children.map(&:name)
    end

    it 'should be rename' do
      #男装
      node = @root.children.first

      xhr :post, :update, :id => node.id, :category => { 
        :name => '时尚男装'
      }
      response.should be_success
      
      node.reload.name.should eql '时尚男装'
    end

    it 'should be move' do
      parent = @root.children.first
      parent.children.map(&:name).should eql %w( 衬衫 POLO衫 针织衫 外套 )

      node = Category.where(:name => '衬衫').first
      neighbor = Category.where(:name => '针织衫').first

      xhr :post, :update, :id => node.id, :category => { 
        :parent_id => parent.id,
        :neighbor => neighbor.id
      }
      response.should be_success
      
      parent.children.map(&:name).should eql %w( POLO衫 衬衫 针织衫 外套 )
    end
  end

  describe 'security' do
    before :each do
      @saberma = Factory(:user_saberma)
      # 清除，以便新增用户
      Thread.current[:user] = nil
      @ben = Factory(:user_ben)
      @ben_store = @ben.store
      @ben_root = @ben_store.categories.first
      @ben_category_man = @ben_store.categories.create(Factory.attributes_for(:category_man))
      @ben_category_woman = @ben_store.categories.create(Factory.attributes_for(:category_woman))
      @ben_root.children.push(@ben_category_man).push(@ben_category_woman).init_list!

      sign_in @saberma
    end

    it "should prevent create someone's data" do
      lambda do
        lambda do
          #男装
          node = @ben_root.children.first

          xhr :post, :create, :category => { 
            :name => '时尚男装',
            :parent_id => node.id
          }
        end.should raise_error
      end.should_not change(Category, :count)
    end

    it "should prevent change someone's data" do
      lambda do
        #男装
        node = @ben_root.children.first

        xhr :post, :update, :id => node.id, :category => { 
          :name => '时尚男装'
        }
        
        node.reload.name.should eql '男装'
      end.should raise_error
    end
  end
end
