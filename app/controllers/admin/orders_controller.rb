# encoding: utf-8
class Admin::OrdersController < InheritedResources::Base
  layout nil
  respond_to :js, :only => [:list, :index, :create, :edit, :update, :destroy]
  prepend_before_filter :authenticate_user!
  prepend_before_filter :store_valid!

  edit! do |format|
    format.html { render :action => "new" }
  end

  def list
    collection
  end

  protected
  def collection
    @orders ||= end_of_association_chain.page(params[:page])
  end

  def begin_of_association_chain
    store
  end

end
