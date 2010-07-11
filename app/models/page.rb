class Page
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  validates_uniqueness_of :name

  embeds_many :navs, :order_by => 'pos desc'

  def sorted_navs
    navs.sort {|x, y| x.pos <=> y.pos}
  end

  def self.mbaobao
    where(:name => :mbaobao).first
  end
end
