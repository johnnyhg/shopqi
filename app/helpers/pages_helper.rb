module PagesHelper
  ##### header #####
  def logo
    render :partial => "pages/header/logo"
  end

  def navs
    render :partial => "pages/header/navs"
  end

  def menus
    render :partial => "pages/header/menus"
  end

  def telephone
    render :partial => "pages/header/telephone"
  end

  def welcome
    render :partial => "pages/header/welcome"
  end

  def keywords
    render :partial => "pages/header/keywords"
  end

  def search
    render :partial => "pages/header/search"
  end

  def car
    render :partial => "pages/header/car"
  end

  ##### content #####
  def focuses(item)
    render :partial => "containers/items/focuses", :locals => { :collection => item.sorted_focuses }
  end

  def sidead(item)
    render :partial => "containers/items/sidead", :object => item.image
  end
end
