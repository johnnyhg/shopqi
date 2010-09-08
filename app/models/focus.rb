# encoding: utf-8
# 首页顶端轮播图片(设计为tree结构，方便Item关联根节点)
class Focus
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::ActsAsSortableTree
  include Mongoid::BelongToStore

  belong_to_store
  acts_as_sortable_tree
  references_one :item

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
