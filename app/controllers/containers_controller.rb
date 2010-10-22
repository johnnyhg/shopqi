# encoding: utf-8
class ContainersController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]
  prepend_before_filter :authenticate_user!
  before_filter :init_parent, :only => :new

  create! do |success, failure|
    success.js {
      # 初始化位置
      resource.parent.children.init_list!
    }
  end

  def sort
    params[:container].each_with_index do |id, index|
      container = end_of_association_chain.find(id)
      container.update_attributes :pos => index
      @first = container if index == 0
      @last = container
    end
  end

  protected
  def begin_of_association_chain
    current_user.store
  end

  def init_parent
    @parent = if params[:parent_id].blank? 
      end_of_association_chain.roots.first
    else
      end_of_association_chain.find(params[:parent_id])
    end
  end
end
