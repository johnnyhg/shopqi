module StoresHelper
  def config_store_url
    "#{show_store_url}?config=true"
  end

  def show_store_url
    "#{request.protocol}#{store.subdomain}.#{request.domain}#{request.port_string}"
  end

  def admin_store_url
    "#{show_store_url}/admin"
  end
end
