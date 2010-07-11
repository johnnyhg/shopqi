#首页顶端导航
class Nav
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActsAsList::Mongoid 

  field :name
  field :url

  #排序
  field :pos, :type => Integer
  acts_as_list :column => :pos

  attr_accessor :neighbor, :direct

  validates_presence_of :name, :url
  #mongoid暂不支持scope
  #validates_uniqueness_of :name, :scope => :page

  embedded_in :page, :inverse_of => :navs

  #一定要初始化pos
  after_create :init_pos

  def init_pos
    page.navs.init_list!
    if direct
      move(direct.to_sym => page.navs.find(neighbor))
      page.save
    end
  end
end
