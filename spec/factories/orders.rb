# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :order do |f|
  f.product_id 1
  f.quantity 1
  f.price 1.5
end
