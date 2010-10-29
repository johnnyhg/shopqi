# coding: utf-8
When /^I delete the (\d+)(?:st|nd|rd|th) order$/ do |pos|
  visit orders_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

#@see: http://github.com/aslakhellesoy/cucumber-rails-test/blob/master/features/step_definitions/lorry_steps.rb
#@see: http://github.com/aslakhellesoy/cucumber-rails-test/blob/master/features/manage_lorries.feature
那么 /^页面应该显示以下订单列表:$/ do |expected_list|
  #@see http://github.com/aslakhellesoy/cucumber/blob/master/lib/cucumber/ast/table.rb
  #@see: http://github.com/aslakhellesoy/cucumber-rails/blob/master/lib/cucumber/web/tableish.rb
  expected_list.diff!(tableish('.list > ul', 'li'))
end
