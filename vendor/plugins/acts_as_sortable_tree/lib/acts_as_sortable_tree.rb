# encoding: utf-8
# 支持排序的tree
module Mongoid
  module ActsAsSortableTree
    def self.included(base)
      base.send :include, Mongoid::Tree
      base.send :include, Mongoid::Tree::Ordering
      base.send :include, InstanceMethods
      base.send :extend, ClassMethods
    end

    module InstanceMethods
      def init_list_item!
      end

      # @param options { :below => <#object> }
      # @param options { :above => <#object> }
      def move(options)
        direct = options.first[0]
        other = options.first[1]
        send("move_#{direct}", other)
      end
    end

    module ClassMethods
      def acts_as_sortable_tree
        # 配合acts_as_list，限定子记录排序范围
        def scope_condition
          {:parent_id => parent.id, :pos.ne => nil}
        end
      end
    end
  end
end
