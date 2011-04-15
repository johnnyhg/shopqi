# encoding: utf-8
class HelpsController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy, :show
  respond_to :js, :only => [:create, :update, :destroy]
  prepend_before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

  create! do |success, failure|
    neighbor = params[:neighbor]
    if neighbor
      neighbor_item = end_of_association_chain.find(params[:neighbor])
      resource.move(params[:direct].to_sym => neighbor_item)
    end
  end

  edit! do |format|
    format.html { render :action => "new" }
  end

  
  show! do |format|
    format.html { render :layout => 'pages' }
  end

  def sort
    params[:help].each_with_index do |id, index|
      end_of_association_chain.find(id).update_attributes :position => index
    end
  end

  protected
  def begin_of_association_chain
    store
  end
end
