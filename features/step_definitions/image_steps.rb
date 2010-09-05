# encoding: utf-8
那么 /^我看到网店Logo$/ do
  @href = find('#logo a img')[:src]
end

那么 /^网店Logo改变了$/ do
  @new_href = find('#logo a img')[:src]
  @new_href.should_not eql @href
end
