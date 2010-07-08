#首页顶端导航
class Nav
  include Mongoid::Document
  include ActsAsList::Mongoid 
  field :name
  field :url

  #排序
  field :pos, :type => Integer, :default => 0
  acts_as_list :column => :pos

  validates_presence_of :name, :url
  #mongoid暂不支持scope
  #validates_uniqueness_of :name, :scope => :page

  embedded_in :page, :inverse_of => :navs
end
