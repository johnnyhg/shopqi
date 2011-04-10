# encoding:utf-8
class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SentientController
  include InheritedResources::DSL
  #before_filter :check_permission!, :only => [ :create, :update, :destroy ]
  protect_from_forgery

  # 定义devise layout
  layout :layout_by_resource

  def layout_by_resource
    (devise_controller? && resource_name == :member) ? 'compact' : 'application'
  end

  # 网店未到期
  def store_valid!
    #判断是否存在该二级域名的网店，若不存在，则跳到官网
    unless store
      redirect_to show_store_url
    else
      redirect_to invalid_path unless store.available?
    end
  end

  protected
  # I18n flash message
  def interpolation_options
    { :resource_name => resource_class.model_name.human }
  end

=begin
  # 检查当前用户是否拥有对网店拥有的信息（如商品）进行修改的权限
  def check_permission!
    # 保证parent可被访问，否则在belong_to参数optional为true的情况下parent总返回nil
    association_chain
    case action_name.to_sym
    when :update
      redirect_to new_user_session_path unless resource.store == current_user.store
    when :create
      if defined?(parent)
        redirect_to new_user_session_path unless !parent || parent.store == current_user.store
      end
    end
  end
=end
end
