# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :member do |m|
  m.email 'ben@shopqi.com'
  m.password '666666'
  m.password_confirmation '666666'
end
