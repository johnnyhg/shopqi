# encoding: utf-8
# 首页顶端轮播图片
class Focus
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActsAsList::Mongoid

  embedded_in :item, :inverse_of => :focueses

  #排序
  field :pos, :type => Integer
  acts_as_list :column => :pos

  field :name
  field :url

  field :image_id

  #先关联图片
  before_create :init_image

  def init_image
    self.image_id = Image.create(:width => 700, :height => 390).id
  end

  def image
    Image.find(image_id)
  end
end
