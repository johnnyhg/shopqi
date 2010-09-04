module MenusHelper
  def menu_selected(item_counter)
    return "menu_#{item_counter} #{item_counter == 0 ? 'on' : ''}"
  end
end
