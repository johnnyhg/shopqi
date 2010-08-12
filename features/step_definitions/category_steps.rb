# encoding: utf-8
假如 /^系统有以下商品分类:$/ do |table|
  root = User.current.store.categories.roots.first
  level = [root]
  table.raw.each do |row|
    row.each_with_index do |col, index|
      next if col.blank?
      node = Category.create(:name => col)
      level = level[0, index + 1]
      level.last.children << node
      level.last.children.init_list!
      level << node
      break
    end
  end
end

#(?:)表示括号中的内容不捕获
当 /^我?(?:在(.+)区域)?右击(.+)$/ do |selector, button_or_link|
  with_scope(selector) do
    sleep 2
    page.execute_script("$(\"a:contains('#{button_or_link}'):first\").trigger('contextmenu.jstree')")
  end
end

当 /^在分类名称输入框中输入(.+)/ do |value|
  find('.tree input:first').set(value)
  # 点击其他节点，使输入框失焦点，并向后台提交信息
  find('.tree').click
  # 等一会，让ajax后台提交数据
  sleep 2
end

当 /^系统会显示以下商品分类:/ do |table|
  within(".tree") do
    table.raw.each_with_index do |row, index|
      find(:xpath, "//ul/li[position()=#{index+1}]").text.should eql row.first
    end
  end
end
