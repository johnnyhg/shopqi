# coding: utf-8
假如 /^系统存在网店信息$/ do
  假如 "系统已有网店布局"
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
  mappings = {'名称' => 'name', '市场价格' => 'market_price', '价格' => 'price', '分类' => 'category_name'}
  #不一定会指定所有的列
  mappings.reject!{|k, v| !table.headers.include?(k)}
  table.map_headers! mappings
  table.hashes.each do |hash|
    if hash.has_key?('category_name')
      category = @store.categories.where(:name => hash.delete('category_name')).first
      hash['category'] = category
    end
    @store.products.create hash
  end
end
