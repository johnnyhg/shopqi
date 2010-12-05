# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :payment do |f|
  f.payment_type_id PaymentType.first.id
  f.is_show true
end
