# encoding: utf-8
# 首页热门分类，不同于商品分类，此分类只作为普通的链接
class Hot
  include Mongoid::Document
  include Mongoid::Acts::Tree

  field :name

  acts_as_tree :order => :pos

  def sorted_children
    children.sort {|x, y| x.pos <=> y.pos}
  end
end
