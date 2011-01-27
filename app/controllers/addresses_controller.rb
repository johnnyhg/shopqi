# encoding: utf-8
class AddressesController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [ :create, :update, :destroy]
  prepend_before_filter :authenticate_member!

  create! do |success, failure|
    failure.js { render :action => "create.failure.js.haml"}
  end

  edit! do |format|
    format.html { render :action => "new" }
  end

  update! do |success, failure|
    success.js { render :action => "update.js.haml"}
    failure.js { render :action => "create.failure.js.haml"}
  end

  protected
  def begin_of_association_chain
    current_member
  end
end
