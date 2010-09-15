# encoding: utf-8
class ContainersController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]

  create! do |success, failure|
    success.js {
      # 初始化位置
      resource.parent.children.init_list!
      if resource.root?
        render :action => "create.container"
      else
        render :action => "create"
      end
    }
  end

  def sort
    params[:container].each_with_index do |id, index|
      end_of_association_chain.find(id).update_attributes :pos => index
    end
  end

  protected
  def begin_of_association_chain
    current_user.store
  end
end
