# encoding: utf-8
当 /^我在支付信息表格输入以下内容:$/ do |fields|
  within_table('payment_type') do
    fields.map_headers! '帐号' => 'account', '合作者身份ID' => 'partnerid', '交易安全校验码' => 'verifycode'
    fields.hashes.each_with_index do |hash, pos|
      hash.each_with_index do |item, index|
        name = item.first
        value = item.second
        span_id = "#payment_type__#{name}__#{pos+1}"
        has_no_field?('value').should be_true
        find(span_id).click
        fill_in 'value', :with => value
        find_field('value').send_string_of_keys('return')
      end
    end
  end
end

而且 /^我?已经填写完支付方式$/ do
  Factory(:payment, :store => @store)
end

而且 /^我单击刷新表格$/ do
  find('.ui-icon-refresh').click
end

那么 /^页面应该显示以下支付列表:$/ do |expected_list|
  # 去掉表头再比较
  expected_list.cell_matrix.shift
  actual_list = tableish('#payment_type tr.item', 'td')
  expected_list.diff!(actual_list, :surplus_row => false)
end
