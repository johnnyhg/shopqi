Factory.define :user do |u|
  u.password '666666'
  u.password_confirmation '666666'
end

Factory.define :user_saberma, :parent => :user do |u|
  u.email 'saberma@shopqi.com'
  u.login :saberma
end

Factory.define :user_ben, :parent => :user do |u|
  u.email 'ben@shopqi.com'
  u.login :ben
end
