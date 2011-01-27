# encoding: utf-8
class PagesController < InheritedResources::Base
  layout nil
  # 配置网店需要用户登录
  prepend_before_filter :config_authenticate
  prepend_before_filter :store_valid!, :except => [:logo, :dynamic]

  def show
    render :template => "pages/templates/#{template}/home", :layout => "pages"
  end

  def logo
    @image = store.images.find(params[:image_id])
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

  def begin_of_association_chain
    store
  end

  def config_authenticate
    authenticate_user! if config?
  end
end
