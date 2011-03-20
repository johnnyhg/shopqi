# encoding: utf-8
# 支持排序的tree
module Mongoid
  module ActsAsSortableTree
    def self.included(base)
      base.send :include, Mongoid::Tree
      base.send :include, Mongoid::Tree::Ordering
      base.send :include, InstanceMethods

      base.send :before_destroy, :destroy_children
    end

    module InstanceMethods
      # @param options { :below => <#object> }
      # @param options { :above => <#object> }
      def move(options)
        direct = options.first[0]
        other = options.first[1]
        send("move_#{direct}", other)
      end
    end

  end
end
