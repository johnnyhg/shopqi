Factory.define :user do |u|
  u.login :saberma
  u.email 'saberma@shopqi.com'
  u.password '666666'
  u.password_confirmation '666666'
end

Factory.define :user_saberma, :parent => :user do |u|
end

Factory.define :user_ben, :parent => :user do |u|
  u.login :ben
  u.email 'ben@shopqi.com'
end
