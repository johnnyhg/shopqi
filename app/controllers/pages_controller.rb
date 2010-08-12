# encoding: utf-8
class PagesController < InheritedResources::Base
  layout nil

  def logo
    @image = Image.find(params[:image_id])
    resource.logo.update_attributes :url => @image.url, :image_id => @image.id
    render :nothing => true
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
