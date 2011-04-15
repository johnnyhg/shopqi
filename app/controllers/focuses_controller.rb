# encoding: utf-8
class FocusesController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]
  prepend_before_filter :authenticate_user!

  edit! do |format|
    format.html { render :action => "new" }
  end

  create! do |success, failure|
    neighbor = params[:neighbor]
    if neighbor
      neighbor_item = end_of_association_chain.find(params[:neighbor])
      resource.update_attributes :parent_id => neighbor_item.parent_id

      # reload重新加载pos属性值
      resource.reload.move(params[:direct].to_sym => neighbor_item)
    end
  end

  def sort
    params[:focus].each_with_index do |id, index|
      end_of_association_chain.find(id).update_attributes :position => index
    end
  end

  protected
  def begin_of_association_chain
    current_user.store
  end
end
