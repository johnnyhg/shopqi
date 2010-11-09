# encoding:utf-8
class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SentientController
  include InheritedResources::DSL
  #before_filter :check_permission!, :only => [ :create, :update, :destroy ]
  before_filter {|c| Member.current = current_member }

  protect_from_forgery

  # 定义devise layout
  layout :layout_by_resource

  def layout_by_resource
    (devise_controller? && resource_name == :member) ? 'compact' : 'application'
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
