# encoding: utf-8
class FocusesController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]

  edit! do |format|
    format.html { render :action => "new" }
  end

  def sort
    params[:focus].each_with_index do |id, index|
      current_user.store.pages.homepage.focuses.find(id).update_attributes :pos => index
    end
  end

  protected
  def begin_of_association_chain
    current_user.store.pages.homepage
  end
end
