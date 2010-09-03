# encoding: utf-8
class FocusesController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]

  edit! do |format|
    format.html { render :action => "new" }
  end

  create! do |success, failure|
    container = store.containers.find(params[:container_id])
    resource.update_attributes :item_id => container.item.id
    # 初始化位置
    container.item.focuses.init_list!
    # reload重新加载pos属性值
    resource.reload.move(params[:direct].to_sym => end_of_association_chain.find(params[:neighbor])) unless params[:direct].blank?
  end

  def sort
    params[:focus].each_with_index do |id, index|
      end_of_association_chain.find(id).update_attributes :pos => index
    end
  end

  protected
  def begin_of_association_chain
    current_user.store
  end
end
