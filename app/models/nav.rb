# encoding: utf-8
#首页顶端导航
class Nav
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Sortable
  sortable_belong_to :page
  #TODO:待mongoid的find(string_id)方法恢复正常后去掉此定义
  identity :type => String

  field :name
  field :url
end
