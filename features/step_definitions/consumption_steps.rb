# coding: utf-8
当 /^我单击(.+)按钮并完成支付$/ do |button|
  find_button(button).visible?
  consumption = @store.consumptions.unpay
  consumption.pay!
end

当 /^网店到期$/ do
  @store.update_attributes :deadline => Date.yesterday
end
