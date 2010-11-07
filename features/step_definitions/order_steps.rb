# coding: utf-8
当 /^我?选择所在地区为(.+),(.+),(.+)$/ do |province, city, district|
  select(province, :from => 'address_province')
  select(city, :from => 'address_city')
  select(district, :from => 'address_district')
end

When /^I delete the (\d+)(?:st|nd|rd|th) order$/ do |pos|
  visit orders_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

#@see: http://github.com/aslakhellesoy/cucumber/wiki/Multiline-Step-Arguments
#@see: http://github.com/aslakhellesoy/cucumber-rails-test/blob/master/features/step_definitions/lorry_steps.rb
#@see: http://github.com/aslakhellesoy/cucumber-rails-test/blob/master/features/manage_lorries.feature
那么 /^页面应该显示以下订单列表:$/ do |expected_list|
  #@see http://github.com/aslakhellesoy/cucumber/blob/master/lib/cucumber/ast/table.rb
  #@see: http://github.com/aslakhellesoy/cucumber-rails/blob/master/lib/cucumber/web/tableish.rb
  actual_list = table(tableish('.list > ul', 'li'), :missing_col => false)
  # 将订单日期后的时分秒去掉再比较
  actual_list.map_column!('订单日期') { |text| text.split(' ')[0]}
  # 替换动态值
  day = Date.today
  expected_list = expected_list.arguments_replaced('20100101' => day.to_s(:serial), '2010-01-01 10:10:10' => day.to_s(:db))
  expected_list.diff!(actual_list);
end
