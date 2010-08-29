module ContainersHelper
  def container_root
    current_user.store.pages.homepage.containers.roots.first
  end

  # 根据item类型，render相应的页面内容
  def item_partial(child)
    send(child.item.type, child.item)
  end

  def grid_class(containers, item)
    css_class = [name(item), "grid_#{item.grids}"]
    css_class << :alpha if (item == containers.first)
    css_class << :omega if (item == containers.last)
    css_class.join(' ')
  end
end
