# encoding: utf-8
class ContainersController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]
  before_filter :init_parent, :only => :create

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
    params[:container][:parent_id] = current_user.store.containers.roots.first.id.to_s if params[:container][:parent_id].blank?
  end
end
