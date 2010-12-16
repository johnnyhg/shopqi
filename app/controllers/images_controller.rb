# encoding: utf-8
class ImagesController < InheritedResources::Base
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
    @image = params[:id].blank? ? end_of_association_chain.create(params[:image]) : end_of_association_chain.find(params[:id])
    @background = Background.new params[:background]
    @image.backgrounds << @background
    @background.save
  end

  protected
  def begin_of_association_chain
    store
  end
end
