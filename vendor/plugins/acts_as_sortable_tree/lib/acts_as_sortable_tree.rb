# encoding: utf-8
# 支持排序的tree
module Mongoid
  module ActsAsSortableTree
    def self.included(base)
      base.send :include, ActsAsList::Mongoid
      base.send :include, Mongoid::Acts::Tree
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def acts_as_sortable_tree
        #排序
        field :pos, :type => Integer

        acts_as_list :column => :pos
        acts_as_tree :order => [:pos, :asc]

        # 虚拟根节点
        def self.root(options = {})
          self.create({:name => :invisible}.merge(options))
        end

        # 配合acts_as_list，限定子记录排序范围
        def scope_condition
          {:parent_id => parent.id, :pos.ne => nil}
        end
      end
    end
  end
end
