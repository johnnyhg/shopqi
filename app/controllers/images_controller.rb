# encoding: utf-8
class ImagesController < InheritedResources::Base
  skip_before_filter :authenticate_user!
  actions :new, :create, :edit, :update
  respond_to :js, :only => [:create, :update]

  edit! do |format|
    format.html { render :action => "new" }
  end

  create! do |success, failure|
    failure.js { render :action => "create.failure.js.haml"}
  end

  update! do |success, failure|
    failure.js { render :action => "update.failure.js.haml"}
  end

  def upload
    @image = params[:id].blank? ? Image.create(params[:image]) : Image.find(params[:id])
    @background = Background.new params[:background]
    @image.backgrounds << @background
    @background.save
  end
end
