module PagesHelper
  ##### header #####
  def logo
    render :partial => "pages/header/logo"
  end

  def navs
    render :partial => "pages/header/navs"
  end

  def welcome
    render :partial => "pages/header/welcome"
  end
end
