# encoding: utf-8
# 网店页面中的布局容器
class Container
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::ActsAsSortableTree
  include Mongoid::BelongToStore

  belong_to_store
  acts_as_sortable_tree

  referenced_in :page
  references_many :categories, :stored_as => :array, :inverse_of => :container

  # 在线文字合成ID: 通栏广告
  field :image_id

  # 回调方法
  before_create :create_image_and_set_page

  def create_image_and_set_page
    if parent_id
      self.page = parent.page
      self.image_id = Image.create(:width => 940, :height => 70).id
    end
  end

  def image
    Image.find image_id
  end
end
