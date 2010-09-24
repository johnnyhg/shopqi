module MenusHelper
  def menu_selected(item_counter)
    return "menu_#{item_counter} #{item_counter == 0 ? 'on' : ''}"
  end

  # 菜单背景图片
  def menu_bg_img
    "/images/menu/#{store.id}.png"
  end
end
