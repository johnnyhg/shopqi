# encoding: utf-8
class NavsController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]

  create! do |success, failure|
  end

  edit! do |format|
    format.html { render :action => "new" }
  end

  update! do |success, failure|
  end

  def sort
    params[:nav].each_with_index do |id, index|
      current_user.store.pages.homepage.navs.find(id).update_attributes :pos => index
    end
  end

  protected
  def begin_of_association_chain
    current_user.store.pages.homepage
  end
end
