# encoding: utf-8
class NavsController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]
  prepend_before_filter :authenticate_user!

  create! do |success, failure|
    neighbor = params[:neighbor]
    if neighbor
      neighbor_item = end_of_association_chain.find(params[:neighbor])
      # reload重新加载pos属性值
      resource.reload.move(params[:direct].to_sym => neighbor_item)
    end
  end

  edit! do |format|
    format.html { render :action => "new" }
  end

  update! do |success, failure|
  end

  def sort
    params[:nav].each_with_index do |id, index|
      end_of_association_chain.find(id).update_attributes :pos => index
    end
    render :template => "shared/sort"
  end

  protected
  def begin_of_association_chain
    store
  end
end
