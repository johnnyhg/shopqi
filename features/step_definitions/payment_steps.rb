# encoding: utf-8
当 /^我在第(.+)行输入以下内容:$/ do |pos, fields|
  within_table('payments') do
    tr = find("tr:nth-child(#{pos.to_i+1})")
    tr.click
    fields.map_headers! '帐号' => 'account', '合作者身份ID' => 'partnerid', '交易安全校验码' => 'verifycode'
    fields.hashes.each do |hash|
      hash.each do |name, value|
        当 %{输入#{name}为#{value}}
      end
    end
    find("##{tr[:id]}_verifycode").send_string_of_keys('return')
  end
end

而且 /^我单击刷新表格$/ do
  find('.ui-icon-refresh').click
end

那么 /^页面应该显示以下支付列表:$/ do |expected_list|
  # 去掉表头再比较
  expected_list.cell_matrix.shift
  actual_list = tableish('#payments tr.jqgrow', 'td')
  expected_list.diff!(actual_list, :surplus_row => false)
end
