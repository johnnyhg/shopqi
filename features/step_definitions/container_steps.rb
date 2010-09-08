# encoding: utf-8
假如 /^首页已有布局容器$/ do
  page = User.current.store.pages.homepage
  root = page.containers.roots.first
  root.children << page.containers.create
  root.children.init_list!
end

当 /^我?把鼠标移进容器操作横栏$/ do
  page.execute_script("$('.container_operates').mouseover()")
end

当 /^我?把鼠标移进空白容器$/ do
  page.execute_script("$('.grid_1:empty, .grid_2:empty, .grid_3:empty, .grid_4:empty, .grid_5:empty, .grid_6:empty, .grid_7:empty, .grid_8:empty, .grid_9:empty, .grid_10:empty, .grid_11:empty, .grid_12:empty, .grid_13:empty, .grid_14:empty, .grid_15:empty, .grid_16:empty, .grid_17:empty, .grid_18:empty, .grid_19:empty, .grid_20:empty, .grid_21:empty, .grid_22:empty, .grid_23:empty, .grid_24:empty').mouseover()")
end

当 /^我?把鼠标移出空白容器$/ do
  page.execute_script("$('.grid_1:empty, .grid_2:empty, .grid_3:empty, .grid_4:empty, .grid_5:empty, .grid_6:empty, .grid_7:empty, .grid_8:empty, .grid_9:empty, .grid_10:empty, .grid_11:empty, .grid_12:empty, .grid_13:empty, .grid_14:empty, .grid_15:empty, .grid_16:empty, .grid_17:empty, .grid_18:empty, .grid_19:empty, .grid_20:empty, .grid_21:empty, .grid_22:empty, .grid_23:empty, .grid_24:empty').mouseout()")
end
