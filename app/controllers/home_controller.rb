class HomeController < ApplicationController
  prepend_before_filter :authenticate_user! ,:only => [:dashboard]
  def index
  end

  # 网店管理首页
  def dashboard
    render :layout => 'admin'
  end
end
