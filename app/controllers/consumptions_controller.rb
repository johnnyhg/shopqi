# encoding: utf-8
class ConsumptionsController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update
  respond_to :js, :only => [:new, :create, :edit, :update]
  prepend_before_filter :authenticate_user!
end
