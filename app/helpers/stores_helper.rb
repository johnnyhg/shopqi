# encoding: utf-8
module StoresHelper
  def platform
    store.name.blank? ? 'ShopQi工作平台' : "#{store.name}工作平台"
  end

  def store_title
    store.title.blank? ? '请在[后台管理]-[设置]中输入标题' : store.title
  end

  def config_store_url
    "#{show_store_url}?config=true"
  end

  def show_store_url
    unless store.subdomain
      "#{request.protocol}#{request.domain}#{request.port_string}"
    else
      "#{request.protocol}#{store.subdomain}.#{request.domain}#{request.port_string}"
    end
  end

  def admin_store_url
    "#{show_store_url}/admin"
  end
end
