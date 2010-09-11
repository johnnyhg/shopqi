module ContainersHelper
  def container_root
    current_user.store.pages.homepage.containers.roots.first
  end

  # 根据item类型，render相应的页面内容
  def item_partial(child)
    send(child.type, child)
  end

  # 容器class
  def grid_class(containers, item)
    css_class = [name(item), "grid_#{item.grids}"]
    nested = (item.grids == item.parent.grids)
    css_class << :alpha if nested or (item == containers.first)
    css_class << :omega if nested or (item == containers.last and item.parent.children_full?)
    css_class.join(' ')
  end
end
