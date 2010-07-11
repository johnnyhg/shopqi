# coding: utf-8
假如 /^系统有以下导航:$/ do |table|
  page = Page.create :name => :mbaobao
  table.raw.flatten.each do |label|
    page.navs << Nav.new(:name => label, :url => "/#{label}")
  end
  page.navs.init_list!
end

Given /^the following navs:$/ do |navs|
  Nav.create!(navs.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) nav$/ do |pos|
  visit navs_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following navs:$/ do |expected_navs_table|
  expected_navs_table.diff!(tableish('table tr', 'td,th'))
end
