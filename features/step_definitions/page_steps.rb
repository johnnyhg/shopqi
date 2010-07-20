# coding: utf-8
假如 /^系统已有网店布局$/ do
  Factory :page_mbaobao
end

假如 /^页面会显示操作表单$/ do
  page.find('#tooltip').visible?.should == true
end

而且 /^(.+)显示在(.+)之(前|后)$/ do |field, neighbor, direct|
  direct = ('前' == direct) ? :prev : :next
  label = page.evaluate_script("$(\"#navs li a:contains('#{neighbor}')\").parent('li').#{direct}().text()")
  label.chomp.should == field
end

#暂不支持后位置
而且 /^我?将(.+)移至(.+)(前|后){1}面$/ do |field, neighbor, direct|
  find("#navs a:contains('#{field}')").drag_to(find("#navs a:contains('#{neighbor}')"))
end
