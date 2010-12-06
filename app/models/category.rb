# encoding: utf-8
# 商品分类
class Category
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::ActsAsSortableTree
  referenced_in :store

  acts_as_sortable_tree
  references_many :products
  referenced_in :container
  
  field :name

  before_validation :security_check
  before_update :reset_products_category_path

  # 与父节点的store保持一致
  def security_check
    raise 'security prevent' if parent and parent.store != self.store
  end

  def reset_products_category_path
    if self.parent_id_changed?
      # TODO: 修改为ruby driver的update方式
      # http://www.mongodb.org/display/DOCS/Updating#Updating-update%28%29
      self.products.each do |product|
        product.update_attributes :category_path => self.full_path
      end
    end
  end

  # path contain self.id
  def full_path
    self.path.clone << self.id
  end
end
