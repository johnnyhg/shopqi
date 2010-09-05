# encoding:utf-8
Factory.define :image do |f|
  f.width 300
  f.height 200
end

Factory.define :image_with_words, :parent => :image do |f|
  f.words {[
    Factory.build(:word, :text => 'ShopQi'),
    Factory.build(:word, :text => '索奇')
  ]}
end

Factory.define :word do |f|
  f.x 10
  f.y 10
  f.font :yahei
  f.send('font-size', '12px')
  f.color '#618d5e'
  f.text :ShopQi
end
