# coding: utf-8
假如 /^系统存在网店信息$/ do
  Factory('page_mbaobao')
end

而且 /将图片(.+)上传/ do |path|
  # 鼠标悬停才能生成input element
  page.execute_script("$('#upload_photo').mouseover();")
  attach_file('photo[file]', "#{Rails.root}/#{path}")
  sleep 3
end

那么 /缩略图应该能显示/ do
  within '#photos' do
    find('img').should_not be_nil
  end
end

假如 /^网店有以下商品:$/ do |table|
  store = User.current.store
  table.rows.each do |row|
    category = store.categories.where(:name => row.fourth).first
    node = store.products.create(
      :name => row.first,
      :market_price => row.second,
      :price => row.third,
      :category => category
    )
  end
end
