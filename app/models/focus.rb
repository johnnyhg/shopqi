# encoding: utf-8
# 首页顶端轮播图片
class Focus
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Sortable
  sortable_belong_to :page

  field :name
  field :url

  field :image_id

  #先关联图片
  before_create :init_image

  def init_image
    self.image_id = Image.create(:width => 725, :height => 391).id
  end

  def image
    Image.find(image_id)
  end
end
