# encoding: utf-8
class StoresController < InheritedResources::Base
  actions :edit, :update
  respond_to :js, :only => [:edit, :update]
  layout nil
  prepend_before_filter :authenticate_user!

  def resource
    store
  end
end
