Given /^the following payments:$/ do |payments|
  Payment.create!(payments.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) payment$/ do |pos|
  visit payments_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following payments:$/ do |expected_payments_table|
  expected_payments_table.diff!(tableish('table tr', 'td,th'))
end
