# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :member do |m|
  m.password '666666'
  m.password_confirmation '666666'
end

Factory.define :member_saberma, :parent => :member do |u|
  u.email 'saberma@shopqi.com'
  u.login :saberma
end

Factory.define :member_ben, :parent => :member do |u|
  u.email 'ben@shopqi.com'
  u.login :ben
end
