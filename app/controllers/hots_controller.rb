# encoding: utf-8
class HotsController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]
  prepend_before_filter :authenticate_user!

  edit! do |format|
    format.html { render :action => "new" }
  end

  create! do |success, failure|
    resource.move(params[:direct].to_sym => end_of_association_chain.find(params[:neighbor])) unless params[:direct].blank?
  end

  def sort
    params[:hot].each_with_index do |id, index|
      end_of_association_chain.find(id).update_attributes :pos => index
    end
    render :template => "shared/sort"
  end

  protected
  def begin_of_association_chain
    store
  end
end
