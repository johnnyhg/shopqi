# encoding: utf-8
class HomeController < ApplicationController
  prepend_before_filter :authenticate_user!, :only => [ :show ]

  def index
  end

  # dashboard
  def show
    render :layout => 'user'
  end
end
