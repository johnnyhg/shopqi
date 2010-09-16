# encoding: utf-8
# 网店页面中的布局容器
class Container
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::ActsAsSortableTree
  include Mongoid::BelongToStore

  belong_to_store
  acts_as_sortable_tree
  alias top_root? root?

  referenced_in :focus, :class_name => 'Focus'
  referenced_in :hot
  references_many :categories, :stored_as => :array, :inverse_of => :container

  referenced_in :page

  # 在线文字合成ID: (通栏,边栏)广告
  referenced_in :image

  MAX_GRIDS = 24
  # 占多少列
  field :grids, :type => Integer, :default => MAX_GRIDS

  field :type

  # mongoid暂不支持
  validates_inclusion_of :type, :in => %w( focuses sidead fullad hots products products_accordion products_head), :allow_blank => true

  # 回调方法
  before_create :set_page
  before_create :init_grids
  before_create :init_item
  after_create :tranform

  def init_grids
    if self.type
      self.grids = case self.type.to_sym
        when :focuses, :hots then 18
        when :sidead, :products_accordion then 6
        when :fullad, :products, :products_head then 24
      end
    end
  end

  def set_page
    self.page = parent.page if parent_id
  end

  # 是否需要转换为根容器或嵌套父容器
  def tranform
    self.update_attributes :grids => MAX_GRIDS if is_root_missing?
    if is_root_missing? or is_nested?
      self.children << self.class.new(:type => self.type)
      self.children.init_list!
      self.update_attributes :type => nil
    end
  end

  # 未建立根容器?
  def is_root_missing?
    parent and parent.top_root?
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

  def sorted_focuses
    self.focus.children.sort {|x, y| x.pos <=> y.pos}
  end

  def sorted_hots
    self.hot.children.sort {|x, y| x.pos <=> y.pos}
  end

  def init_item
    if self.type and !(is_root_missing? or is_nested?)
      case self.type.to_sym
      when :focuses
        self.focus = Focus.root
        3.times { |i| self.focus.children << Focus.create(:name => "标题#{i+1}", :url => '/') }
        self.focus.children.init_list!
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
        self.image = Image.create(:width => 220, :height => 120)
      when :fullad
        self.image = Image.create(:width => 940, :height => 60)
      when :products, :products_accordion
        self.categories = User.current.store.categories.roots.first.children
      when :products_head
        self.image = Image.new(:width => 264, :height => 40)
        self.image.words << Word.new(:x => 20, :y => 0, :font => :yahei, 'font-size' => '36px', :color => '#000000', :text => '分类')
        self.image.words << Word.new(:x => 100, :y => 16, :font => :yahei, 'font-size' => '24px', :color => '#EBEBEB', :text => 'Categories')
        self.image.save
      end
    end
  end
end
