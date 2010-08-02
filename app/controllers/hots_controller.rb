# encoding: utf-8
class HotsController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]
  before_filter :check_parent_id

  edit! do |format|
    format.html { render :action => "new" }
  end

  def create
    @hot = Hot.new(params[:hot])
    unless @hot.parent_id
      @hot.page = Page.mbaobao
    end
    create!
  end

  def sort
    params[:hot].each_with_index do |id, index|
      Hot.find(id).update_attributes :pos => index
    end
  end

  protected
  def check_parent_id
    params[:hot].delete(:parent_id) if params[:hot] and params[:hot][:parent_id].blank?
  end
end
