module ContainersHelper
  def container_root
    current_user.store.pages.homepage.containers.roots.first
  end
end
