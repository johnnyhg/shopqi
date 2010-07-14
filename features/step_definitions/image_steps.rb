Given /^the following images:$/ do |images|
  Image.create!(images.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) image$/ do |pos|
  visit images_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following images:$/ do |expected_images_table|
  expected_images_table.diff!(tableish('table tr', 'td,th'))
end
