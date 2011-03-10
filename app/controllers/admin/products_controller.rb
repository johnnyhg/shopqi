# encoding: utf-8
class Admin::ProductsController < InheritedResources::Base
  actions :index
  layout nil
  respond_to :js, :only => [ :index]
  prepend_before_filter :authenticate_user!
  prepend_before_filter :store_valid!

  def list
    collection
  end

  protected
  def collection
    @products ||= end_of_association_chain.page(params[:page]).per(1)
  end

  def begin_of_association_chain
    store
  end

end
