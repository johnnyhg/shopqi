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
  embeds_one :item

  # 在线文字合成ID: 通栏广告
  field :image_id

  # 占多少列
  field :grids, :type => Integer, :default => 24

  # 用于传递给item
  attr_accessor :type

  # 回调方法
  before_create :create_image_and_set_page
  before_create :init_item

  def init_item
    if self.type
      self.item = Item.new(:type => self.type)
      self.item.run_callbacks :create
      self.grids = case self.type.to_sym
      when :focuses
        18
      end
    end
  end

  def create_image_and_set_page
    if parent_id
      self.page = parent.page
      #self.image_id = Image.create(:width => 940, :height => 70).id
    end
  end

  def image
    Image.find image_id
  end
end

#内容元素
class Item
  include Mongoid::Document
  embedded_in :container, :inverse_of => :item
  embeds_many :focuses

  field :type
  # mongoid暂不支持
  #validates_inclusion_of :type, :in => %w( focuses )

  def sorted_focuses
    focuses.sort {|x, y| x.pos <=> y.pos}
  end

  before_create :init_focuses

  def init_focuses
    3.times do |i|
      self.focuses << Focus.new(:name => "标题#{i+1}", :url => '/')
      self.focuses.last.run_callbacks :create
    end
  end
end
