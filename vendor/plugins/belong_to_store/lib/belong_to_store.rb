# encoding: utf-8
# 所有实体都需要归属于store实体
module Mongoid
  module BelongToStore
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def belong_to_store
        class_eval do
          referenced_in :store

          # 回调方法
          before_create :init_store

          def init_store
            self.store = User.current.store
            raise 'security prevent' if respond_to?(:parent) and parent and parent.store != self.store
          end

          if respond_to?(:acts_as_tree)
            # 虚拟根节点
            def self.root
              self.create(:name => :invisible)
            end

            # 配合acts_as_list，限定子记录排序范围
            def scope_condition
              {:parent_id => parent.id, :pos.ne => nil}
            end
          end
        end
      end

      def store_has_many(*args)
        class_eval do
          args.each do |children_name|
            references_many children_name, :dependent => :destroy

            child_class = Kernel.const_get(children_name.to_s.singularize.capitalize)
            # 只有tree结构的实体才需要初始化子记录的根节点
            if child_class.respond_to?(:acts_as_tree)
              # 回调方法
              after_create "init_#{children_name}"

              define_method "init_#{children_name}" do
                # 设置虚拟root节点是为了方便子记录调用parent.children.init_list!
                self.send(children_name) << child_class.root
              end
            end
          end
        end
      end
    end
  end
end
