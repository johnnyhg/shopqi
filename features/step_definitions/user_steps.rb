# coding: utf-8
假如 /^我已经以用户名(.+)成功注册$/ do |email|
  @user = Factory(:user, :email => email)
  @store = @user.store
  # 固定store subdomain
  @store.update_attributes :subdomain => 'vancl'
end

假如 /^我已经以用户名(.+)登录$/ do |email|
  假如 "我已经以用户名#{email}成功注册"
  而且 "我访问首页"
  而且 "点击登录管理您的网店"
  当 "我输入用户名为#{email}"
  而且 "输入密码为666666"
  而且 "点击登录"
end
