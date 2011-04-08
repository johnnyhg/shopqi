# encoding: utf-8
class HelpsController < ApplicationController
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]
  prepend_before_filter :authenticate_user!

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

  def sort
    params[:help].each_with_index do |id, index|
      end_of_association_chain.find(id).update_attributes :pos => index
    end
    render :template => "shared/sort"
  end

  protected
  def begin_of_association_chain
    store
  end
end
