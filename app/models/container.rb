# encoding: utf-8
# 网店页面中的布局容器
class Container
  include Extensions::Base
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::ActsAsSortableTree

  # 操作
  OPERATES = {
    :fullad => { :grids => 24, :name => '通栏广告'},
    :focuses => { :grids => 18, :name => '聚焦广告'},
    :sidead => { :grids => 6, :name => '边栏广告'},
    :hots => { :grids => 18, :name => '热门分类'},
    :products_head => { :grids => 24, :name => '商品列表标题'},
    :products => { :grids => 24, :name => '商品列表'},
    :products_accordion => { :grids => 6, :name => '商品列表[手风琴展示效果]'},
  }

  referenced_in :store
  alias top_root? root?

  referenced_in :focus, :class_name => 'Focus'
  referenced_in :hot
  references_and_referenced_in_many :categories

  referenced_in :page

  # 在线文字合成ID: (通栏,边栏)广告
  referenced_in :image

  MAX_GRIDS = 24
  # 占多少列
  field :grids, :type => Integer, :default => MAX_GRIDS

  field :type

  validates_inclusion_of :type, :in => OPERATES.keys, :allow_blank => true

  # 回调方法
  before_create :set_page
  before_create :init_grids
  before_create :init_item
  after_create :tranform


  def remain_grids
    remain = self.grids - self.children.map(&:grids).sum
    remain = self.grids if remain <= 0
    remain
  end

  def init_grids
    self.grids = OPERATES[self.type.to_sym][:grids] if self.type
  end

  def set_page
    self.page = parent.page if parent_id
  end

  # 是否需要转换为根容器或嵌套父容器
  def tranform
    self.update_attributes :grids => MAX_GRIDS if is_root_missing?
    if is_root_missing? or is_nested?
      self.children << store.containers.build(:type => self.type)
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
        self.focus = store.focuses.create :name => :invisible
        3.times { |i| self.focus.children << store.focuses.create(:name => "标题#{i+1}", :url => '/') }
      when :hots
        self.hot = store.hots.create :name => :invisible
        3.times do |i| 
          hot = store.hots.create(:name => "分类#{i+1}", :url => '/')
          3.times {|j| hot.children << store.hots.create(:name => "子类#{j+1}", :url => '/')}
          self.hot.children << hot
        end
      when :sidead
        self.image = store.images.create(:width => 220, :height => 120)
      when :fullad
        self.image = store.images.create(:width => 940, :height => 60)
      when :products, :products_accordion
        self.categories << store.categories.roots.first.children
      when :products_head
        self.image = store.images.new(:width => 264, :height => 40)
        self.image.words << Word.new(:x => 20, :y => 0, :font => :yahei, 'font-size' => '36px', :color => '#000000', :text => '分类')
        self.image.words << Word.new(:x => 100, :y => 16, :font => :yahei, 'font-size' => '24px', :color => '#EBEBEB', :text => 'Categories')
        self.image.save
      end
    end
  end
end
