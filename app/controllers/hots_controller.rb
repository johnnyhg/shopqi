# encoding: utf-8
class HotsController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]

  edit! do |format|
    format.html { render :action => "new" }
  end

  def sort
    params[:hot].each_with_index do |id, index|
      Hot.find(id).update_attributes :pos => index
    end
  end
end
