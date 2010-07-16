# coding: utf-8
# 以上修正:invalid multibyte char (US-ASCII)

假如 /^我?在(.+)(?:页面)?$/ do |page_name|
  visit path_to(page_name)
end

当 /^我?打开(.+)$/ do |page_name|
  visit path_to(page_name)
end

#(?:)表示括号中的内容不捕获
当 /^我?(?:在(.+)区域)?点击(.+)$/ do |selector, button_or_link|
  with_scope(selector) do
    click(button_or_link)
  end
end

当 /^我?(?:在(.+)区域)?输入(.+)为(.+)/ do |selector, field, value|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

# Use this to fill in an entire form with data from a table. Example:
#
#   当 I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
当 /^我?fill in the following(?: within "([^"]*)")?:$/ do |selector, fields|
  with_scope(selector) do
    fields.rows_hash.each do |name, value|
      当 %{I fill in "#{name}" with "#{value}"}
    end
  end
end

当 /^我?select "([^"]*)" from "([^"]*)"(?: within "([^"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    select(value, :from => field)
  end
end

当 /^我?check "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector|
  with_scope(selector) do
    check(field)
  end
end

当 /^我?uncheck "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector|
  with_scope(selector) do
    uncheck(field)
  end
end

当 /^我?choose "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector|
  with_scope(selector) do
    choose(field)
  end
end

当 /^我?attach the file "([^"]*)" to "([^"]*)"(?: within "([^"]*)")?$/ do |path, field, selector|
  with_scope(selector) do
    attach_file(field, path)
  end
end

那么 /^我?should see JSON:$/ do |expected_json|
  require 'json'
  expected = JSON.pretty_generate(JSON.parse(expected_json))
  actual   = JSON.pretty_generate(JSON.parse(response.body))
  expected.should == actual
end

那么 /^我?(?:在(.+)区域)?应该能看到(.+)$/ do |selector, text|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

那么 /^我?should see \/([^\/]*)\/(?: within "([^"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_xpath('//*', :text => regexp)
    else
      assert page.has_xpath?('//*', :text => regexp)
    end
  end
end

那么 /^我?(?:在(.+)区域)?应该看不到(.+)$/ do |selector, text|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_no_content(text)
    else
      assert page.has_no_content?(text)
    end
  end
end

那么 /^我?should not see \/([^\/]*)\/(?: within "([^"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_no_xpath('//*', :text => regexp)
    else
      assert page.has_no_xpath?('//*', :text => regexp)
    end
  end
end

那么 /^the "([^"]*)" field(?: within "([^"]*)")? should contain "([^"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

那么 /^the "([^"]*)" field(?: within "([^"]*)")? should not contain "([^"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should_not
      field_value.should_not =~ /#{value}/
    else
      assert_no_match(/#{value}/, field_value)
    end
  end
end

那么 /^the "([^"]*)" checkbox(?: within "([^"]*)")? should be checked$/ do |label, selector|
  with_scope(selector) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_true
    else
      assert field_checked
    end
  end
end

那么 /^the "([^"]*)" checkbox(?: within "([^"]*)")? should not be checked$/ do |label, selector|
  with_scope(selector) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_false
    else
      assert !field_checked
    end
  end
end
 
那么 /^我?should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

那么 /^我?should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')} 
  
  if actual_params.respond_to? :should
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end


当 /^我?把鼠标移到(.+)$/ do |field|
  page.execute_script("$('#navs a:first').mouseover()")
end

#此方法尽量少用， 会不定时报错:
# <DRb::DRbConnError: too large packet 67654656
那么 /^显示页面$/ do
  save_and_open_page
end
