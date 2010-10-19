# encoding:utf-8
class ApplicationController < ActionController::Base
  include SentientController
  include InheritedResources::DSL
  include ApplicationHelper
  before_filter :authenticate_user!
  #before_filter :check_permission!, :only => [ :create, :update, :destroy ]

  protect_from_forgery
  layout 'application'

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
