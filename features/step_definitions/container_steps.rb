# encoding: utf-8
假如 /^首页已有布局容器$/ do
  page = User.current.store.pages.homepage
  root = page.containers.roots.first
  root.children << page.containers.create
  root.children.init_list!
end

当 /^我?把鼠标移进空白容器$/ do
  page.execute_script("$('.container').mouseover()")
end

当 /^我?把鼠标移出空白容器$/ do
  page.execute_script("$('.container').mouseout()")
end
