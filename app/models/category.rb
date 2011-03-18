# encoding: utf-8
# 商品分类
class Category
  include Extensions::Base
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::ActsAsSortableTree
  referenced_in :store
  references_many :products
  
  field :name

  before_validation :security_check
  before_update :reset_products_category_parent_ids

  # 与父节点的store保持一致
  def security_check
    raise 'security prevent' if !parent.nil? and parent.store != self.store
  end

  def reset_products_category_parent_ids
    if self.parent_id_changed?
      # TODO: 修改为ruby driver的update方式
      # http://www.mongodb.org/display/DOCS/Updating#Updating-update%28%29
      self.products.each do |product|
        product.update_attributes :category_parent_ids => self.full_parent_ids
      end
    end
  end

  # parent_ids path contain self.id
  def full_parent_ids
    self.parent_ids.clone << self.id
  end
end
