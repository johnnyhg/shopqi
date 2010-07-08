module NavsHelper
  def nav_bar(navs, nav)
    return '' if navs.nil?
    (nav == navs.first) ? :no_bar : ''
  end
end
