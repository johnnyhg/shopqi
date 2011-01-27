# coding: utf-8
当 /^我?选择所在地区为(.+),(.+),(.+)$/ do |province, city, district|
  select(province, :from => 'address_province')
  select(city, :from => 'address_city')
  select(district, :from => 'address_district')
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
  expected_list.diff!(actual_list)
end

假如 /^会员(.+)提交订单购买以下商品:$/ do |email, product_list|
  假如 "我已经以用户名saberma@shopqi.com成功注册"
  而且 "已经填写完支付方式"
  假如 "网店已有具体商品分类"
  假如 "网店有以下商品:", product_list
  假如 "我已经以会员#{email}成功注册"
  假如 "会员已关联收货地址"
  @order = @member.orders.build(:address_id => @address.id.to_s, :payment => @payment)
  product_list.rows.each do |row|
    product = @store.products.where(:name => row.first).first
    @order.items.build :product => product, :price => product.price, :quantity => 1, :sum => product.price
  end
  @order.save
end

那么 /我应该在任务栏看不到订单(.+)/ do |number|
  当 "我应该看不到#{today_number(number)}"
end

那么 /我应该能在任务栏看到订单(.+)/ do |number|
  当 "我应该能看到#{today_number(number)}"
end

当 /会员成功支付订单/ do
  @order.pay!
end

当 /我单击订单(.+)/ do |number|
  当 "我点击#{today_number(number)}"
end

def today_number(number)
  number.sub /20100101/, Date.today.to_s(:serial)
end
