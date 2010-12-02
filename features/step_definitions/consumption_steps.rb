# coding: utf-8
当 /^我单击(.+)按钮并完成支付$/ do |button|
  find_button(button).visible?
  consumption = User.current.store.consumptions.unpay
  consumption.pay!
end

