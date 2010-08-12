# encoding: utf-8
class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, :except => [ :show ]

  def index
  end

  # dashboard
  def show
    render :layout => 'user'
  end
end
