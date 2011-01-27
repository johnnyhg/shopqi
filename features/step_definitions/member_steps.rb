# coding: utf-8
假如 /^我已经以会员(.+)成功注册$/ do |email|
  @member = @store.members.create(Factory.attributes_for(:member, :email => email))
end

假如 /^我已经以会员(.+)登录$/ do |email|
  假如 "我已经以会员#{email}成功注册"
  而且 "我访问会员登录注册页面"
  当 "我输入用户名为#{email}"
  而且 "输入密　码为666666"
  而且 "点击登录"
end

假如 /^会员已关联收货地址$/ do
  @address = @member.addresses.create(Factory.attributes_for(:address))
end
