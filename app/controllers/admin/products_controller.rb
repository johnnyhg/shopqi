# encoding: utf-8
class Admin::ProductsController < InheritedResources::Base
  layout nil
  respond_to :js, :only => [:list, :index, :create, :update, :destroy]
  prepend_before_filter :authenticate_user!
  prepend_before_filter :store_valid!

  def list
    collection
  end

  protected
  def collection
    @products ||= end_of_association_chain.page(params[:page])
  end

  def begin_of_association_chain
    store
  end

end
