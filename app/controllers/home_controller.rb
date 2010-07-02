class HomeController < ApplicationController
  def index
  end

  def show
    render :layout => 'user'
  end
end
