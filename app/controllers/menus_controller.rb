# encoding: utf-8
class MenusController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]
  after_filter :sprite, :only => [:create, :update, :destroy, :sort]

  create! do |success, failure|
    neighbor = params[:neighbor]
    if neighbor
      neighbor_item = end_of_association_chain.find(params[:neighbor])
      resource.update_attributes :store_id => neighbor_item.store_id

      # 初始化位置
      resource.store.menus.init_list!
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
    params[:menu].each_with_index do |id, index|
      end_of_association_chain.find(id).update_attributes :pos => index
    end
  end

  protected
  def begin_of_association_chain
    current_user.store
  end

  def sprite
    Menu.sprite(current_user.store)
  end

end
