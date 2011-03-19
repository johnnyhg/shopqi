# coding: utf-8
假如 /^首页没有聚焦广告容器$/ do
  focus_container = @store.pages.homepage.containers.where(:type => 'focuses').first
  focus_container.parent.parent.destroy
end
