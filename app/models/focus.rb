# encoding: utf-8
# 首页顶端轮播图片
class Focus
  include Mongoid::Document
  #TODO:待mongoid的find(string_id)方法恢复正常后去掉此定义
  identity :type => String

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
