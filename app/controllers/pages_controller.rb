# encoding: utf-8
class PagesController < InheritedResources::Base
  layout nil

  def show
    render :template => "pages/templates/#{template}/home", :layout => "pages"
  end

  def logo
    @image = Image.find(params[:image_id])
    resource.logo.update_attributes :url => @image.url, :image_id => @image.id
    render :nothing => true
  end

  def dynamic
    render :action => :dynamic, :content_type => 'text/css'
  end

  protected
  def resource
    @resource ||= end_of_association_chain.homepage
  end

  protected
  def begin_of_association_chain
    current_user.store
  end
end
