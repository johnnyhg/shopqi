# encoding: utf-8
class MenusController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]
  after_filter :sprite, :only => [:create, :update, :destroy, :sort]

  create! do |success, failure|
    failure.js { render :action => "create.failure.js.haml"}
  end

  edit! do |format|
    format.html { render :action => "new" }
  end

  update! do |success, failure|
    failure.js { render :action => "update.failure.js.haml"}
  end

  def sort
    params[:menu].each_with_index do |id, index|
      Page.mbaobao.menus.find(id).update_attributes :pos => index
    end
  end

  protected
  def begin_of_association_chain
    Page.mbaobao
  end

  def sprite
    Menu.sprite(Page.mbaobao)
  end

end
