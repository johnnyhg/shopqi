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

  MAX_GRIDS = 24
  # 占多少列
  field :grids, :type => Integer, :default => MAX_GRIDS

  # 用于传递给item
  attr_accessor :type

  # 回调方法
  before_create :set_page
  before_create :init_grids
  before_create :init_item
  after_create :tranform_to_child

  def init_grids
    if self.type
      self.grids = case self.type.to_sym
        when :focuses, :hots then 18
        when :sidead then 6
        when :fullad then 24
      end
    end
  end

  def init_item
    if self.type and !is_nested?
      self.item = Item.new(:type => self.type)
      self.item.run_callbacks :create
    end
  end

  def set_page
    self.page = parent.page if parent_id
  end

  # 是否需要转换为嵌套父容器
  def tranform_to_child
    if is_nested?
      self.children << self.class.new(:type => self.type)
      self.children.init_list!
      self.type = nil
    end
  end

  def is_nested?
    parent and parent.grids > self.grids
  end

  def children_full?
    self.children.map(&:grids).sum == self.grids
  end

  # 重载根节点的判断方法
  def root?
    self.depth == 1
  end
end

#内容元素
class Item
  include Mongoid::Document
  embedded_in :container, :inverse_of => :item
  references_many :focuses
  referenced_in :hot

  field :type
  # mongoid暂不支持
  validates_inclusion_of :type, :in => %w( focuses sidead fullad hots)

  # 在线文字合成ID: (通栏,边栏)广告
  field :image_id

  def sorted_focuses
    focuses.sort {|x, y| x.pos <=> y.pos}
  end

  def sorted_hots
    self.hot.children.sort {|x, y| x.pos <=> y.pos}
  end

  before_create :init_item

  def init_item
    case self.type.to_sym
    when :focuses
      3.times { |i| self.focuses << Focus.create(:name => "标题#{i+1}", :url => '/', :item => self) }
      self.focuses.init_list!
    when :hots
      self.hot = Hot.root
      3.times do |i| 
        hot = Hot.create(:name => "分类#{i+1}", :url => '/')
        3.times {|j| hot.children << Hot.create(:name => "子类#{j+1}", :url => '/')}
        hot.children.init_list!
        self.hot.children << hot
      end
      self.hot.children.init_list!
    when :sidead
      self.image_id = Image.create(:width => 220, :height => 120).id
    when :fullad
      self.image_id = Image.create(:width => 940, :height => 60).id
    end
  end

  def image
    Image.find image_id
  end
end
