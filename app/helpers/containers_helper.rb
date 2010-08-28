module ContainersHelper
  def container_root
    current_user.store.pages.homepage.containers.roots.first
  end

  # 根据item类型，render相应的页面内容
  def item_partial(child)
    send(child.item.type, child.item.focuses)
  end

  # 所有子记录所占列总数
  def grids_sum(item)
    item.children.map(&:grids).sum
  end
end
